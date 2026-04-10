USE ehotels;

-- 5 Chains 
INSERT INTO HOTEL_CHAIN (name, head_office_address, num_hotels, contact_email, contact_phone) VALUES
('MapleStay Hotels', '100 King St W, Toronto', 8, 'contact@maplestay.com', '416-555-1001'),
('Northern Suites', '200 Rue Sainte-Catherine, Montreal', 8, 'info@northernsuites.com', '514-555-2002'),
('BlueWave Resorts', '300 Ocean Dr, Vancouver', 8, 'support@bluewave.com', '604-555-3003'),
('UrbanNest Hotels', '400 Sparks St, Ottawa', 8, 'hello@urbannest.com', '613-555-4004'),
('Continental Comfort', '500 5th Ave, New York', 8, 'service@continentalcomfort.com', '212-555-5005');

-- 40 Hotels (8 per chain) 
INSERT INTO HOTEL (chain_id, name, category, address, city, province_state, country, postal_code, num_rooms, contact_email, contact_phone)
SELECT 
    hc.chain_id, 
    CONCAT(hc.name, ' ', city_name), 
    (FLOOR(RAND() * 5) + 1), -- Range of 1-5 stars [cite: 20, 80]
    'Main St', city_name, 'Prov', 'Canada', 'K1A0A1', 0, 'h@test.com', '555-0000'
FROM HOTEL_CHAIN hc
CROSS JOIN (
    SELECT 'Ottawa' AS city_name UNION SELECT 'Gatineau' UNION SELECT 'Montreal' 
    UNION SELECT 'Toronto' UNION SELECT 'Vancouver' UNION SELECT 'Calgary' 
    UNION SELECT 'Quebec City' UNION SELECT 'Halifax'
) AS cities;

-- 200 Rooms (5 per hotel) 
INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area)
SELECT 
    h.hotel_id, 
    CONCAT('R', nums.n), 
    100 + (nums.n * 25), 
    'WiFi, TV, AC', 
    CASE WHEN nums.n=1 THEN 'Single' WHEN nums.n IN (2,3) THEN 'Double' WHEN nums.n=4 THEN 'Suite' ELSE 'Family' END,
    'City', 1, 'None', 25 + (nums.n * 5)
FROM HOTEL h
CROSS JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) AS nums;

-- Managers: one manager per hotel chain for the employee access demo
INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role)
SELECT MIN(h.hotel_id), CONCAT('Manager ', hc.name), 'Address St', CONCAT('1', LPAD(hc.chain_id, 8, '0')), 'Manager'
FROM HOTEL_CHAIN hc
JOIN HOTEL h ON h.chain_id = hc.chain_id
GROUP BY hc.chain_id, hc.name;

-- Test non-manager employee for each hotel chain
INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role)
SELECT MIN(h.hotel_id), CONCAT('Employee ', hc.name), 'Address St', CONCAT('2', LPAD(hc.chain_id, 8, '0')), 'Receptionist'
FROM HOTEL_CHAIN hc
JOIN HOTEL h ON h.chain_id = hc.chain_id
GROUP BY hc.chain_id, hc.name;

-- Link Managers back to Hotels
UPDATE HOTEL h
JOIN (
    SELECT MIN(hotel_id) AS hotel_id
    FROM HOTEL
    GROUP BY chain_id
) representative_hotels ON representative_hotels.hotel_id = h.hotel_id
JOIN EMPLOYEE e ON e.hotel_id = h.hotel_id AND e.role = 'Manager'
SET h.manager_employee_id = e.employee_id;

-- Clients [cite: 30]
INSERT INTO CLIENT (full_name, address, ssn_sin, registration_date) VALUES
('John Smith', 'Ottawa, ON', 'SIN991', CURDATE()),
('Emma Watson', 'Toronto, ON', 'SIN992', CURDATE());
