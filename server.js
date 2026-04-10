const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
const port = 3000;

const CITY_OPTIONS = [
    'Ottawa',
    'Gatineau',
    'Montreal',
    'Toronto',
    'Vancouver',
    'Calgary',
    'Quebec City',
    'Halifax'
];

const CHAIN_OPTIONS = [
    { id: 1, name: 'MapleStay Hotels' },
    { id: 2, name: 'Northern Suites' },
    { id: 3, name: 'BlueWave Resorts' },
    { id: 4, name: 'UrbanNest Hotels' },
    { id: 5, name: 'Continental Comfort' }
];

function getFallbackEmployees() {
    return CHAIN_OPTIONS.flatMap((chain) => ([
        {
            employee_id: chain.id * 100 + 1,
            hotel_id: chain.id,
            actual_hotel_id: null,
            full_name: `Manager ${chain.name}`,
            role: 'Manager',
            ssn_sin: `${chain.id}00000001`
        },
        {
            employee_id: chain.id * 100 + 2,
            hotel_id: chain.id,
            actual_hotel_id: null,
            full_name: `Employee ${chain.name}`,
            role: 'Receptionist',
            ssn_sin: `${chain.id}00000002`
        }
    ]));
}

function getFallbackHotels() {
    const hotels = [];
    let id = 1;

    for (const chain of CHAIN_OPTIONS) {
        for (const city of CITY_OPTIONS) {
            hotels.push({ hotel_id: id, name: `${chain.name} ${city}` });
            id += 1;
        }
    }

    return hotels;
}

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT
}).promise();

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));

function normalizeCapacity(capacite) {
    const map = {
        simple: 'Single',
        double: 'Double',
        suite: 'Suite',
        family: 'Family',
        Single: 'Single',
        Double: 'Double',
        Suite: 'Suite',
        Family: 'Family'
    };

    return map[capacite] || '';
}

function normalizeChain(chaine) {
    const map = {
        'MapleStay Hotels': 'MapleStay Hotels',
        'Northern Suites': 'Northern Suites',
        'BlueWave Resorts': 'BlueWave Resorts',
        'UrbanNest Hotels': 'UrbanNest Hotels',
        'Continental Comfort': 'Continental Comfort'
    };

    return map[chaine] || '';
}

function normalizeDateRange(dateDebut, dateFin) {
    if (!dateDebut || !dateFin) {
        return null;
    }

    if (dateFin < dateDebut) {
        return null;
    }

    if (dateFin === dateDebut) {
        const start = new Date(`${dateDebut}T00:00:00`);
        start.setDate(start.getDate() + 1);
        return {
            effectiveEndDate: start.toISOString().split('T')[0]
        };
    }

    return {
        effectiveEndDate: dateFin
    };
}

// --- NAVIGATION ---
app.get('/', (req, res) => res.render('recherche', { cities: CITY_OPTIONS, chains: CHAIN_OPTIONS }));

async function getAdminFormData() {
    try {
        const [chains] = await pool.query('SELECT chain_id AS id, name FROM HOTEL_CHAIN ORDER BY name');
        const [hotels] = await pool.query('SELECT hotel_id, name FROM HOTEL ORDER BY name');
        return { chains, hotels };
    } catch (err) {
        return { chains: CHAIN_OPTIONS, hotels: getFallbackHotels() };
    }
}

async function getEmployeeRooms() {
    try {
        const [rooms] = await pool.query(`
            SELECT r.room_id, r.room_number, h.name AS hotel_name
            FROM ROOM r
            JOIN HOTEL h ON r.hotel_id = h.hotel_id
            ORDER BY h.name, r.room_number
        `);
        return rooms;
    } catch (err) {
        return [];
    }
}

async function getEmployeeAccessData() {
    try {
        await pool.query(`
            INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role)
            SELECT MIN(h.hotel_id), CONCAT('Manager ', hc.name), 'Address St', CONCAT('1', LPAD(hc.chain_id, 8, '0')), 'Manager'
            FROM HOTEL_CHAIN hc
            JOIN HOTEL h ON h.chain_id = hc.chain_id
            WHERE NOT EXISTS (
                SELECT 1
                FROM EMPLOYEE existing_employee
                JOIN HOTEL existing_hotel ON existing_employee.hotel_id = existing_hotel.hotel_id
                WHERE existing_hotel.chain_id = hc.chain_id
                  AND existing_employee.role = 'Manager'
            )
            GROUP BY hc.chain_id, hc.name
        `);
        await pool.query(`
            INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role)
            SELECT MIN(h.hotel_id), CONCAT('Employee ', hc.name), 'Address St', CONCAT('2', LPAD(hc.chain_id, 8, '0')), 'Receptionist'
            FROM HOTEL_CHAIN hc
            JOIN HOTEL h ON h.chain_id = hc.chain_id
            WHERE NOT EXISTS (
                SELECT 1
                FROM EMPLOYEE existing_employee
                JOIN HOTEL existing_hotel ON existing_employee.hotel_id = existing_hotel.hotel_id
                WHERE existing_hotel.chain_id = hc.chain_id
                  AND existing_employee.role <> 'Manager'
            )
            GROUP BY hc.chain_id, hc.name
        `);
        await pool.query(`
            UPDATE HOTEL h
            JOIN (
                SELECT MIN(hotel_id) AS hotel_id
                FROM HOTEL
                GROUP BY chain_id
            ) representative_hotels ON representative_hotels.hotel_id = h.hotel_id
            JOIN EMPLOYEE e ON e.hotel_id = h.hotel_id AND e.role = 'Manager'
            SET h.manager_employee_id = e.employee_id
            WHERE h.manager_employee_id IS NULL
        `);

        const [employees] = await pool.query(`
            SELECT e.employee_id, hc.chain_id AS hotel_id, e.hotel_id AS actual_hotel_id, e.full_name, e.role, e.ssn_sin
            FROM EMPLOYEE e
            JOIN HOTEL h ON e.hotel_id = h.hotel_id
            JOIN HOTEL_CHAIN hc ON h.chain_id = hc.chain_id
            WHERE e.role <> 'Manager'
               OR e.employee_id = (
                    SELECT MIN(e2.employee_id)
                    FROM EMPLOYEE e2
                    JOIN HOTEL h2 ON e2.hotel_id = h2.hotel_id
                    WHERE h2.chain_id = hc.chain_id
                      AND e2.role = 'Manager'
               )
            ORDER BY hc.chain_id, e.role = 'Manager' DESC, e.full_name
        `);
        return {
            hotels: CHAIN_OPTIONS.map(chain => ({ hotel_id: chain.id, name: chain.name })),
            employees
        };
    } catch (err) {
        return {
            hotels: CHAIN_OPTIONS.map(chain => ({ hotel_id: chain.id, name: chain.name })),
            employees: getFallbackEmployees()
        };
    }
}

async function getEmployeeSession(employeeId, hotelId) {
    const [employees] = await pool.query(
        `SELECT e.employee_id, hc.chain_id AS hotel_id, e.hotel_id AS actual_hotel_id, e.full_name, e.role, hc.name AS hotel_name
         FROM EMPLOYEE e
         JOIN HOTEL h ON e.hotel_id = h.hotel_id
         JOIN HOTEL_CHAIN hc ON h.chain_id = hc.chain_id
         WHERE e.employee_id = ? AND hc.chain_id = ?`,
        [employeeId, hotelId]
    );

    return employees[0] || null;
}

app.get('/admin', async(req, res) => {
    const { employee_id, hotel_id } = req.query;

    if (employee_id && hotel_id) {
        try {
            const session = await getEmployeeSession(employee_id, hotel_id);
            if (!session || session.role !== 'Manager') {
                return res.redirect('/employe');
            }
        } catch (err) {
            return res.redirect('/employe');
        }
    }

    const { chains, hotels } = await getAdminFormData();
    res.render('admin', { chains, hotels, cities: CITY_OPTIONS, returnToEmployee: Boolean(employee_id && hotel_id) });
});

async function getOrCreateClient({ nom, adresse, nas }) {
    const [existingClient] = await pool.query(
        'SELECT client_id FROM CLIENT WHERE ssn_sin = ?',
        [nas]
    );

    if (existingClient.length) {
        await pool.query(
            'UPDATE CLIENT SET full_name = ?, address = ? WHERE client_id = ?',
            [nom, adresse, existingClient[0].client_id]
        );
        return existingClient[0].client_id;
    }

    const [result] = await pool.query(
        'INSERT INTO CLIENT (full_name, address, ssn_sin, registration_date) VALUES (?, ?, ?, CURDATE())',
        [nom, adresse, nas]
    );

    return result.insertId;
}

async function searchRooms(filters) {
    const {
        capacite,
        categorie,
        prixMax,
        superficie,
        ville,
        chaine,
        dateDebut,
        dateFin,
        numChambres
    } = filters;

    const normalizedDates = normalizeDateRange(dateDebut, dateFin);
    if (!normalizedDates) {
        return [];
    }
    const effectiveEndDate = normalizedDates.effectiveEndDate;

    const normalizedCapacity = normalizeCapacity(capacite);
    const normalizedChain = normalizeChain(chaine);
    const queryVille = ville || '';
    const queryCat = categorie ? Number(categorie) : null;
    const maxPrice = prixMax ? Number(prixMax) : 9999;
    const minArea = superficie ? Number(superficie) : 0;
    const minRooms = numChambres ? Number(numChambres) : null;

    let query = `
        SELECT r.room_id as id_chambre,
               h.name as nom_hotel,
               h.category as categorie,
               h.city as ville,
               h.num_rooms as nombre_chambres_hotel,
               hc.name as chaine,
               r.price as prix,
               r.capacity as capacite,
               r.extendable_bed as lit_additionnel,
               r.area as superficie,
               r.view_type as vue,
               r.amenities as commodites,
               r.damage_status as etat
        FROM ROOM r
        JOIN HOTEL h ON r.hotel_id = h.hotel_id
        JOIN HOTEL_CHAIN hc ON h.chain_id = hc.chain_id
        WHERE r.price <= ?
          AND r.area >= ?
          AND NOT EXISTS (
                SELECT 1
                FROM RESERVATION res
                WHERE res.room_id = r.room_id
                  AND res.status IN ('Pending', 'Confirmed')
                  AND NOT (? >= res.end_date OR ? <= res.start_date)
          )
          AND NOT EXISTS (
                SELECT 1
                FROM RENTAL ren
                WHERE ren.room_id = r.room_id
                  AND ren.status = 'Active'
                  AND NOT (? >= ren.check_out_date OR ? <= ren.check_in_date)
          )`;

    const params = [maxPrice, minArea, dateDebut, effectiveEndDate, dateDebut, effectiveEndDate];

    if (normalizedCapacity) {
        query += ' AND r.capacity = ?';
        params.push(normalizedCapacity);
    }

    if (Number.isInteger(queryCat)) {
        query += ' AND h.category = ?';
        params.push(queryCat);
    }

    if (queryVille) {
        query += ' AND h.city = ?';
        params.push(queryVille);
    }

    if (normalizedChain) {
        query += ' AND hc.name = ?';
        params.push(normalizedChain);
    }

    if (Number.isInteger(minRooms)) {
        query += ' AND h.num_rooms >= ?';
        params.push(minRooms);
    }

    query += ' ORDER BY h.name, r.price';

    const [rows] = await pool.query(query, params);
    return rows;
}

// --- SEARCH: Combined Criteria (Req #8) ---
app.get('/rechercher', async(req, res) => {
    const { dateDebut, dateFin } = req.query;
    try {
        const rows = await searchRooms(req.query);
        res.render('resultats', { chambres: rows, dateDebut, dateFin });
    } catch (err) {
        console.error('Search Error:', err);
        res.status(500).send("Search Error");
    }
});

app.get('/api/rechercher', async(req, res) => {
    try {
        const rows = await searchRooms(req.query);
        res.json({ chambres: rows });
    } catch (err) {
        console.error('Live Search Error:', err);
        res.status(500).json({ error: 'Search Error' });
    }
});

// --- EMPLOYEE: Conversions & Direct Rental (Req #6, #8) ---
app.get('/employe', async(req, res) => {
    const { hotels, employees } = await getEmployeeAccessData();
    res.render('employe', {
        mode: 'select',
        hotels,
        employees,
        reservations: [],
        rooms: [],
        session: null
    });
});

app.get('/employe/console', async(req, res) => {
    const { employee_id, hotel_id } = req.query;

    try {
        const session = await getEmployeeSession(employee_id, hotel_id);
        if (!session) {
            return res.redirect('/employe');
        }

        if (session.role === 'Manager') {
            return res.redirect(`/admin?employee_id=${employee_id}&hotel_id=${hotel_id}`);
        }

        const [reserves] = await pool.query(`
            SELECT res.reservation_id as id,
                   c.full_name as client,
                   c.ssn_sin as nas,
                   res.room_id,
                   DATE_FORMAT(res.start_date, '%Y-%m-%d') as start_date
            FROM RESERVATION res
            JOIN CLIENT c ON res.client_id = c.client_id
            JOIN ROOM r ON res.room_id = r.room_id
            JOIN HOTEL h ON r.hotel_id = h.hotel_id
            WHERE res.status IN ('Pending', 'Confirmed')
              AND h.chain_id = ?
            ORDER BY res.start_date, res.reservation_id`,
            [hotel_id]
        );
        const [rooms] = await pool.query(`
            SELECT r.room_id, r.room_number, h.name AS hotel_name
            FROM ROOM r
            JOIN HOTEL h ON r.hotel_id = h.hotel_id
            WHERE h.chain_id = ?
            ORDER BY r.room_number
        `, [hotel_id]);

        res.render('employe', {
            mode: 'console',
            reservations: reserves,
            rooms,
            session,
            hotels: [],
            employees: []
        });
    } catch (err) {
        res.redirect('/employe');
    }
});

// Conversion: Reservation -> Rental (Check-in)
app.post('/checkin/:id', async(req, res) => {
    const { employee_id, hotel_id } = req.body;
    try {
        const session = await getEmployeeSession(employee_id, hotel_id);
        if (!session) {
            return res.status(403).send('Employe non autorise');
        }

        const [reservation] = await pool.query(`
            SELECT res.*
            FROM RESERVATION res
            JOIN ROOM r ON res.room_id = r.room_id
            JOIN HOTEL h ON r.hotel_id = h.hotel_id
            WHERE res.reservation_id = ?
              AND h.chain_id = ?`,
            [req.params.id, hotel_id]
        );
        if (reservation.length > 0) {
            const r = reservation[0];
            await pool.query(
                'INSERT INTO RENTAL (client_id, room_id, employee_id, reservation_id, check_in_date, check_out_date, status) VALUES (?, ?, ?, ?, ?, ?, "Active")',
                [r.client_id, r.room_id, employee_id, r.reservation_id, r.start_date, r.end_date]
            );
            await pool.query('UPDATE RESERVATION SET status = "Confirmed" WHERE reservation_id = ?', [req.params.id]);
        }
        res.redirect(`/employe/console?employee_id=${employee_id}&hotel_id=${hotel_id}`);
    } catch (err) { res.status(500).send("Check-in Error"); }
});

// Direct Rental (Location Directe)
app.post('/louer-direct', async(req, res) => {
    const { nas, room_id, employee_id, hotel_id } = req.body;
    try {
        const session = await getEmployeeSession(employee_id, hotel_id);
        if (!session) {
            return res.status(403).send('Employe non autorise');
        }

        const [client] = await pool.query('SELECT client_id FROM CLIENT WHERE ssn_sin = ?', [nas]);
        if (client.length > 0) {
            const [rooms] = await pool.query(
                `SELECT r.room_id
                 FROM ROOM r
                 JOIN HOTEL h ON r.hotel_id = h.hotel_id
                 WHERE r.room_id = ? AND h.chain_id = ?`,
                [room_id, hotel_id]
            );
            if (!rooms.length) {
                return res.status(403).send('Chambre non autorisee');
            }

            await pool.query(
                'INSERT INTO RENTAL (client_id, room_id, employee_id, check_in_date, check_out_date, status) VALUES (?, ?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 2 DAY), "Active")',
                [client[0].client_id, room_id, employee_id]
            );
            res.redirect(`/employe/console?employee_id=${employee_id}&hotel_id=${hotel_id}`);
        } else { res.status(404).send("Client non trouvé"); }
    } catch (err) { res.status(500).send("Rental Error"); }
});

// --- ADMIN: CRUD (Req #8) ---
app.post('/admin/add-client', async(req, res) => {
    const { nom, nas, adresse } = req.body;
    try {
        await pool.query('INSERT INTO CLIENT (full_name, address, ssn_sin, registration_date) VALUES (?, ?, ?, CURDATE())', [nom, adresse, nas]);
        res.redirect('/admin');
    } catch (err) { res.status(500).send("CRUD Error"); }
});

app.post('/admin/add-employee', async(req, res) => {
    const { nom, nas, role, hotel_id } = req.body;
    try {
        await pool.query('INSERT INTO EMPLOYEE (hotel_id, full_name, ssn_sin, role, address) VALUES (?, ?, ?, ?, "Address TBD")', [hotel_id, nom, nas, role]);
        res.redirect('/admin');
    } catch (err) { res.status(500).send("CRUD Error"); }
});

app.post('/admin/add-hotel', async(req, res) => {
    const { chain_id, nom, categorie, adresse, ville, province_state, country, postal_code, email, phone } = req.body;
    try {
        await pool.query(
            `INSERT INTO HOTEL
            (chain_id, name, category, address, city, province_state, country, postal_code, num_rooms, contact_email, contact_phone)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?)`,
            [chain_id, nom, categorie, adresse, ville, province_state, country, postal_code, email, phone]
        );
        res.redirect('/admin');
    } catch (err) { res.status(500).send("CRUD Error"); }
});

app.post('/admin/add-room', async(req, res) => {
    const { hotel_id, room_number, prix, commodites, capacite, vue, extendable_bed, damage_status, area } = req.body;
    try {
        await pool.query(
            `INSERT INTO ROOM
            (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [hotel_id, room_number, prix, commodites || null, capacite, vue, Number(extendable_bed), damage_status || 'None', area]
        );
        res.redirect('/admin');
    } catch (err) { res.status(500).send("CRUD Error"); }
});

// --- STATS (Req #9) ---
app.get('/stats', async(req, res) => {
    try {
        let cityStats = [];
        try {
            const [rows] = await pool.query('SELECT * FROM available_rooms_by_city');
            cityStats = rows;
        } catch (viewErr) {
            const [rows] = await pool.query('SELECT * FROM available_rooms_by_zone');
            cityStats = rows;
        }
        const [hotelStats] = await pool.query('SELECT * FROM hotel_total_capacity');
        res.render('stats', { cityStats, hotelStats });
    } catch (err) { res.render('stats', { cityStats: [], hotelStats: [] }); }
});

app.post('/reserver', async(req, res) => {
    const { id, dateDebut, dateFin } = req.body;

    try {
        const normalizedDates = normalizeDateRange(dateDebut, dateFin);
        if (!normalizedDates) {
            return res.status(400).send('Dates invalides');
        }

        const [rooms] = await pool.query(
            `SELECT r.room_id, r.room_number, r.price, r.capacity, r.view_type, r.area,
                    r.extendable_bed, r.damage_status, r.amenities,
                    h.name AS hotel_name, h.city
             FROM ROOM r
             JOIN HOTEL h ON r.hotel_id = h.hotel_id
             WHERE r.room_id = ?`,
            [id]
        );

        if (!rooms.length) {
            return res.status(404).send('Chambre non trouvee');
        }

        res.render('reservation', {
            chambre: rooms[0],
            dateDebut,
            dateFin,
            success: false
        });
    } catch (err) {
        res.status(500).send('Reservation Error');
    }
});

app.post('/reserver/confirmer', async(req, res) => {
    const { room_id, dateDebut, dateFin, nom, adresse, nas } = req.body;

    try {
        const normalizedDates = normalizeDateRange(dateDebut, dateFin);
        if (!normalizedDates) {
            return res.status(400).send('Dates invalides');
        }

        const clientId = await getOrCreateClient({ nom, adresse, nas });

        const [result] = await pool.query(
            `INSERT INTO RESERVATION (client_id, room_id, start_date, end_date, reservation_date, status)
             VALUES (?, ?, ?, ?, CURDATE(), "Pending")`,
            [clientId, room_id, dateDebut, normalizedDates.effectiveEndDate]
        );

        const [rooms] = await pool.query(
            `SELECT r.room_id, r.room_number, r.price, r.capacity, r.view_type, r.area,
                    r.extendable_bed, r.damage_status, r.amenities,
                    h.name AS hotel_name, h.city
             FROM ROOM r
             JOIN HOTEL h ON r.hotel_id = h.hotel_id
             WHERE r.room_id = ?`,
            [room_id]
        );

        res.render('reservation', {
            chambre: rooms[0],
            dateDebut,
            dateFin,
            success: true,
            reservationId: result.insertId
        });
    } catch (err) {
        console.error('Reservation Error:', err);
        res.status(500).send('Reservation Error');
    }
});

app.listen(port, () => console.log(`🚀 System Online: http://localhost:${port}`));
