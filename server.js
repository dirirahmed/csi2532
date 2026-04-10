const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
const port = 3000;

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

// --- NAVIGATION ---
app.get('/', (req, res) => res.render('recherche'));
app.get('/admin', (req, res) => res.render('admin'));

// --- SEARCH: Combined Criteria (Req #8) ---
app.get('/rechercher', async(req, res) => {
    const { capacite, categorie, prixMax, superficie, ville, chaine } = req.query;
    try {
        const queryVille = ville ? `%${ville}%` : '%';
        const queryCat = categorie || '%';
        const queryChain = chaine ? `%${chaine}%` : '%';

        const [rows] = await pool.query(`
            SELECT r.room_id as id_chambre, h.name as nom_hotel, h.category as categorie, 
                   h.city as ville, r.price as prix, r.capacity as capacite, 
                   r.area as superficie, r.view_type as vue, r.amenities as commodites
            FROM ROOM r
            JOIN HOTEL h ON r.hotel_id = h.hotel_id
            JOIN HOTEL_CHAIN hc ON h.chain_id = hc.chain_id
            WHERE r.capacity = ? AND h.category LIKE ? AND h.city LIKE ? 
              AND hc.name LIKE ? AND r.price <= ? AND r.area >= ?`, [capacite, queryCat, queryVille, queryChain, prixMax || 9999, superficie || 0]);
        res.render('resultats', { chambres: rows });
    } catch (err) { res.status(500).send("Search Error"); }
});

// --- EMPLOYEE: Conversions & Direct Rental (Req #6, #8) ---
app.get('/employe', async(req, res) => {
    try {
        const [reserves] = await pool.query(`
            SELECT res.reservation_id as id, c.full_name as client 
            FROM RESERVATION res JOIN CLIENT c ON res.client_id = c.client_id`);
        res.render('employe', { reservations: reserves });
    } catch (err) { res.render('employe', { reservations: [] }); }
});

// Conversion: Reservation -> Rental (Check-in)
app.post('/checkin/:id', async(req, res) => {
    try {
        const [reservation] = await pool.query('SELECT * FROM RESERVATION WHERE reservation_id = ?', [req.params.id]);
        if (reservation.length > 0) {
            const r = reservation[0];
            await pool.query(
                'INSERT INTO RENTAL (client_id, room_id, check_in_date, check_out_date, status) VALUES (?, ?, ?, ?, "Active")', [r.client_id, r.room_id, r.start_date, r.end_date]
            );
            await pool.query('DELETE FROM RESERVATION WHERE reservation_id = ?', [req.params.id]);
        }
        res.redirect('/employe');
    } catch (err) { res.status(500).send("Check-in Error"); }
});

// Direct Rental (Location Directe)
app.post('/louer-direct', async(req, res) => {
    const { nas, room_id } = req.body;
    try {
        const [client] = await pool.query('SELECT client_id FROM CLIENT WHERE ssn_sin = ?', [nas]);
        if (client.length > 0) {
            await pool.query(
                'INSERT INTO RENTAL (client_id, room_id, check_in_date, check_out_date, status) VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 2 DAY), "Active")', [client[0].client_id, room_id]
            );
            res.send(`<h1>Location Réussie</h1><a href="/employe">Retour</a>`);
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

app.post('/admin/add-room', async(req, res) => {
    const { hotel_id, prix, capacite } = req.body;
    try {
        await pool.query('INSERT INTO ROOM (hotel_id, price, capacity, area, view_type, room_number, extendable_bed) VALUES (?, ?, ?, 25, "City", "AUTO", 0)', [hotel_id, prix, capacite]);
        res.redirect('/admin');
    } catch (err) { res.status(500).send("CRUD Error"); }
});

// --- STATS (Req #9) ---
app.get('/stats', async(req, res) => {
    try {
        const [cityStats] = await pool.query('SELECT * FROM available_rooms_by_city');
        const [hotelStats] = await pool.query('SELECT * FROM hotel_total_capacity');
        res.render('stats', { cityStats, hotelStats });
    } catch (err) { res.render('stats', { cityStats: [], hotelStats: [] }); }
});

app.post('/reserver', (req, res) => res.render('reservation'));

app.listen(port, () => console.log(`🚀 System Online: http://localhost:${port}`));