USE ehotels;
INSERT INTO HOTEL_CHAIN (name, head_office_address, num_hotels, contact_email, contact_phone) VALUES
('MapleStay Hotels', '100 King St W, Toronto, ON, Canada', 8, 'contact@maplestay.com', '416-555-1001'),
('Northern Suites', '200 Rue Sainte-Catherine, Montreal, QC, Canada', 8, 'info@northernsuites.com', '514-555-2002'),
('BlueWave Resorts', '300 Ocean Dr, Vancouver, BC, Canada', 8, 'support@bluewave.com', '604-555-3003'),
('UrbanNest Hotels', '400 Sparks St, Ottawa, ON, Canada', 8, 'hello@urbannest.com', '613-555-4004'),
('Continental Comfort', '500 5th Ave, New York, NY, USA', 8, 'service@continentalcomfort.com', '212-555-5005');
INSERT INTO HOTEL (chain_id, name, category, address, city, province_state, country, postal_code, num_rooms, contact_email, contact_phone, manager_employee_id) VALUES
-- Chain 2: Northern Suites
(2, 'Northern Suites Downtown Montreal', 5, '901 Saint Laurent Blvd', 'Montreal', 'Quebec', 'Canada', 'H2X2T1', 5, 'montreal1@northernsuites.com', '514-555-2101', NULL),
(2, 'Northern Suites Old Port', 4, '902 Notre-Dame St W', 'Montreal', 'Quebec', 'Canada', 'H2Y1T2', 5, 'montreal2@northernsuites.com', '514-555-2102', NULL),
(2, 'Northern Suites Quebec City', 4, '903 Grande Allée', 'Quebec City', 'Quebec', 'Canada', 'G1R2J5', 5, 'quebec@northernsuites.com', '418-555-2103', NULL),
(2, 'Northern Suites Gatineau', 3, '904 Boulevard Maloney', 'Gatineau', 'Quebec', 'Canada', 'J8P1E6', 5, 'gatineau@northernsuites.com', '819-555-2104', NULL),
(2, 'Northern Suites Halifax Waterfront', 5, '905 Lower Water St', 'Halifax', 'Nova Scotia', 'Canada', 'B3J1S3', 5, 'halifax@northernsuites.com', '902-555-2105', NULL),
(2, 'Northern Suites Moncton', 3, '906 Main St', 'Moncton', 'New Brunswick', 'Canada', 'E1C1B7', 5, 'moncton@northernsuites.com', '506-555-2106', NULL),
(2, 'Northern Suites Winnipeg Central', 4, '907 Portage Ave', 'Winnipeg', 'Manitoba', 'Canada', 'R3B2E8', 5, 'winnipeg@northernsuites.com', '204-555-2107', NULL),
(2, 'Northern Suites Edmonton North', 4, '908 Jasper Ave', 'Edmonton', 'Alberta', 'Canada', 'T5J0N3', 5, 'edmonton@northernsuites.com', '780-555-2108', NULL),

-- Chain 3: BlueWave Resorts
(3, 'BlueWave Vancouver Beach', 5, '1001 Beach Ave', 'Vancouver', 'British Columbia', 'Canada', 'V6E1T7', 5, 'vancouver1@bluewave.com', '604-555-3101', NULL),
(3, 'BlueWave Victoria Harbour', 4, '1002 Government St', 'Victoria', 'British Columbia', 'Canada', 'V8W1X5', 5, 'victoria@bluewave.com', '250-555-3102', NULL),
(3, 'BlueWave Seattle Downtown', 5, '1003 Pine St', 'Seattle', 'Washington', 'USA', '98101', 5, 'seattle@bluewave.com', '206-555-3103', NULL),
(3, 'BlueWave Portland Pearl', 4, '1004 Burnside St', 'Portland', 'Oregon', 'USA', '97209', 5, 'portland@bluewave.com', '503-555-3104', NULL),
(3, 'BlueWave San Diego Bay', 5, '1005 Harbor Dr', 'San Diego', 'California', 'USA', '92101', 5, 'sandiego@bluewave.com', '619-555-3105', NULL),
(3, 'BlueWave Los Angeles West', 4, '1006 Sunset Blvd', 'Los Angeles', 'California', 'USA', '90028', 5, 'la@bluewave.com', '323-555-3106', NULL),
(3, 'BlueWave Miami Oceanfront', 5, '1007 Ocean Dr', 'Miami', 'Florida', 'USA', '33139', 5, 'miami@bluewave.com', '305-555-3107', NULL),
(3, 'BlueWave Tampa Central', 3, '1008 Water St', 'Tampa', 'Florida', 'USA', '33602', 5, 'tampa@bluewave.com', '813-555-3108', NULL),

-- Chain 4: UrbanNest Hotels
(4, 'UrbanNest Ottawa Downtown', 4, '1101 Laurier Ave', 'Ottawa', 'Ontario', 'Canada', 'K1P5J2', 5, 'ottawa1@urbannest.com', '613-555-4101', NULL),
(4, 'UrbanNest Ottawa East', 3, '1102 Montreal Rd', 'Ottawa', 'Ontario', 'Canada', 'K1K0T6', 5, 'ottawa2@urbannest.com', '613-555-4102', NULL),
(4, 'UrbanNest Toronto Midtown', 4, '1103 Eglinton Ave', 'Toronto', 'Ontario', 'Canada', 'M4P1A6', 5, 'toronto1@urbannest.com', '416-555-4103', NULL),
(4, 'UrbanNest Toronto Liberty', 5, '1104 King St W', 'Toronto', 'Ontario', 'Canada', 'M6K1H1', 5, 'toronto2@urbannest.com', '416-555-4104', NULL),
(4, 'UrbanNest Chicago Loop', 5, '1105 Wacker Dr', 'Chicago', 'Illinois', 'USA', '60601', 5, 'chicago@urbannest.com', '312-555-4105', NULL),
(4, 'UrbanNest Boston Central', 4, '1106 Boylston St', 'Boston', 'Massachusetts', 'USA', '02116', 5, 'boston@urbannest.com', '617-555-4106', NULL),
(4, 'UrbanNest Philadelphia Center', 3, '1107 Market St', 'Philadelphia', 'Pennsylvania', 'USA', '19107', 5, 'philly@urbannest.com', '215-555-4107', NULL),
(4, 'UrbanNest Washington Metro', 5, '1108 Pennsylvania Ave', 'Washington', 'District of Columbia', 'USA', '20004', 5, 'dc@urbannest.com', '202-555-4108', NULL),

-- Chain 5: Continental Comfort
(5, 'Continental Comfort Manhattan', 5, '1201 Madison Ave', 'New York', 'New York', 'USA', '10022', 5, 'ny1@continentalcomfort.com', '212-555-5101', NULL),
(5, 'Continental Comfort Brooklyn', 4, '1202 Atlantic Ave', 'Brooklyn', 'New York', 'USA', '11217', 5, 'ny2@continentalcomfort.com', '718-555-5102', NULL),
(5, 'Continental Comfort Newark', 3, '1203 Broad St', 'Newark', 'New Jersey', 'USA', '07102', 5, 'newark@continentalcomfort.com', '973-555-5103', NULL),
(5, 'Continental Comfort Jersey City', 4, '1204 Hudson St', 'Jersey City', 'New Jersey', 'USA', '07302', 5, 'jersey@continentalcomfort.com', '201-555-5104', NULL),
(5, 'Continental Comfort Dallas Central', 5, '1205 Elm St', 'Dallas', 'Texas', 'USA', '75201', 5, 'dallas@continentalcomfort.com', '214-555-5105', NULL),
(5, 'Continental Comfort Houston West', 4, '1206 Main St', 'Houston', 'Texas', 'USA', '77002', 5, 'houston@continentalcomfort.com', '713-555-5106', NULL),
(5, 'Continental Comfort Atlanta Midtown', 4, '1207 Peachtree St', 'Atlanta', 'Georgia', 'USA', '30308', 5, 'atlanta@continentalcomfort.com', '404-555-5107', NULL),
(5, 'Continental Comfort Charlotte Uptown', 3, '1208 Tryon St', 'Charlotte', 'North Carolina', 'USA', '28202', 5, 'charlotte@continentalcomfort.com', '704-555-5108', NULL);

INSERT INTO CLIENT (full_name, address, ssn_sin, registration_date) VALUES
('John Smith', '12 Main St, Ottawa, ON, Canada', 'SIN10001', '2025-01-10'),
('Emma Johnson', '45 Queen St, Toronto, ON, Canada', 'SIN10002', '2025-02-14'),
('Liam Brown', '78 King Rd, Montreal, QC, Canada', 'SIN10003', '2025-03-01'),
('Olivia Davis', '23 Bank St, Ottawa, ON, Canada', 'SIN10004', '2025-03-12'),
('Noah Wilson', '67 Rideau St, Ottawa, ON, Canada', 'SIN10005', '2025-03-20'),
('Sophia Miller', '89 Elgin St, Ottawa, ON, Canada', 'SIN10006', '2025-03-25');

INSERT INTO HOTEL (chain_id, name, category, address, city, province_state, country, postal_code, num_rooms, contact_email, contact_phone, manager_employee_id) VALUES
(1, 'MapleStay Downtown Toronto', 5, '101 Bay St', 'Toronto', 'Ontario', 'Canada', 'M5J2X1', 5, 'toronto1@maplestay.com', '416-555-1101', NULL),
(1, 'MapleStay North York', 4, '202 Yonge St', 'Toronto', 'Ontario', 'Canada', 'M2N5N4', 5, 'toronto2@maplestay.com', '416-555-1102', NULL),
(1, 'MapleStay Ottawa Centre', 3, '303 Rideau St', 'Ottawa', 'Ontario', 'Canada', 'K1N5Y6', 5, 'ottawa1@maplestay.com', '613-555-1103', NULL),
(1, 'MapleStay Ottawa West', 4, '404 Wellington St', 'Ottawa', 'Ontario', 'Canada', 'K1A0A9', 5, 'ottawa2@maplestay.com', '613-555-1104', NULL),
(1, 'MapleStay Montreal Central', 5, '505 Sherbrooke St', 'Montreal', 'Quebec', 'Canada', 'H3A1B5', 5, 'montreal1@maplestay.com', '514-555-1105', NULL),
(1, 'MapleStay Laval', 3, '606 Cartier Blvd', 'Laval', 'Quebec', 'Canada', 'H7N2J3', 5, 'laval@maplestay.com', '450-555-1106', NULL),
(1, 'MapleStay Vancouver Harbour', 5, '707 Hastings St', 'Vancouver', 'British Columbia', 'Canada', 'V6C1A1', 5, 'vancouver@maplestay.com', '604-555-1107', NULL),
(1, 'MapleStay Calgary South', 4, '808 17th Ave', 'Calgary', 'Alberta', 'Canada', 'T2T0A1', 5, 'calgary@maplestay.com', '403-555-1108', NULL);

INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role) VALUES
(1, 'Alice Martin', 'Ottawa, ON, Canada', 'EMP20001', 'Manager'),
(1, 'Brian Lee', 'Ottawa, ON, Canada', 'EMP20002', 'Receptionist'),
(2, 'Chloe White', 'Toronto, ON, Canada', 'EMP20003', 'Manager'),
(2, 'David Hall', 'Toronto, ON, Canada', 'EMP20004', 'Receptionist'),
(3, 'Eva Green', 'Ottawa, ON, Canada', 'EMP20005', 'Manager'),
(3, 'Frank Young', 'Ottawa, ON, Canada', 'EMP20006', 'Housekeeping'),
(4, 'Grace Scott', 'Ottawa, ON, Canada', 'EMP20007', 'Manager'),
(5, 'Henry Adams', 'Montreal, QC, Canada', 'EMP20008', 'Manager'),
(6, 'Isabella Baker', 'Laval, QC, Canada', 'EMP20009', 'Manager'),
(7, 'Jack Carter', 'Vancouver, BC, Canada', 'EMP20010', 'Manager'),
(8, 'Lily Nelson', 'Calgary, AB, Canada', 'EMP20011', 'Manager');

INSERT INTO EMPLOYEE (hotel_id, full_name, address, ssn_sin, role) VALUES
-- Hotels 9 to 16
(9, 'Mia Turner', 'Montreal, QC, Canada', 'EMP20012', 'Manager'),
(9, 'Ethan Walker', 'Montreal, QC, Canada', 'EMP20013', 'Receptionist'),
(10, 'Ava Harris', 'Montreal, QC, Canada', 'EMP20014', 'Manager'),
(10, 'Lucas King', 'Montreal, QC, Canada', 'EMP20015', 'Receptionist'),
(11, 'Charlotte Wright', 'Quebec City, QC, Canada', 'EMP20016', 'Manager'),
(11, 'Mason Lopez', 'Quebec City, QC, Canada', 'EMP20017', 'Housekeeping'),
(12, 'Amelia Hill', 'Gatineau, QC, Canada', 'EMP20018', 'Manager'),
(12, 'James Scott', 'Gatineau, QC, Canada', 'EMP20019', 'Receptionist'),
(13, 'Harper Green', 'Halifax, NS, Canada', 'EMP20020', 'Manager'),
(13, 'Benjamin Adams', 'Halifax, NS, Canada', 'EMP20021', 'Admin'),
(14, 'Evelyn Baker', 'Moncton, NB, Canada', 'EMP20022', 'Manager'),
(14, 'Elijah Nelson', 'Moncton, NB, Canada', 'EMP20023', 'Receptionist'),
(15, 'Abigail Carter', 'Winnipeg, MB, Canada', 'EMP20024', 'Manager'),
(15, 'Logan Mitchell', 'Winnipeg, MB, Canada', 'EMP20025', 'Housekeeping'),
(16, 'Emily Perez', 'Edmonton, AB, Canada', 'EMP20026', 'Manager'),
(16, 'Jacob Roberts', 'Edmonton, AB, Canada', 'EMP20027', 'Receptionist'),

-- Hotels 17 to 24
(17, 'Ella Campbell', 'Vancouver, BC, Canada', 'EMP20028', 'Manager'),
(17, 'Michael Phillips', 'Vancouver, BC, Canada', 'EMP20029', 'Receptionist'),
(18, 'Elizabeth Evans', 'Victoria, BC, Canada', 'EMP20030', 'Manager'),
(18, 'Daniel Turner', 'Victoria, BC, Canada', 'EMP20031', 'Receptionist'),
(19, 'Sofia Parker', 'Seattle, WA, USA', 'EMP20032', 'Manager'),
(19, 'Jackson Collins', 'Seattle, WA, USA', 'EMP20033', 'Admin'),
(20, 'Avery Edwards', 'Portland, OR, USA', 'EMP20034', 'Manager'),
(20, 'Sebastian Stewart', 'Portland, OR, USA', 'EMP20035', 'Receptionist'),
(21, 'Scarlett Sanchez', 'San Diego, CA, USA', 'EMP20036', 'Manager'),
(21, 'Jack Morris', 'San Diego, CA, USA', 'EMP20037', 'Housekeeping'),
(22, 'Victoria Rogers', 'Los Angeles, CA, USA', 'EMP20038', 'Manager'),
(22, 'Owen Reed', 'Los Angeles, CA, USA', 'EMP20039', 'Receptionist'),
(23, 'Aria Cook', 'Miami, FL, USA', 'EMP20040', 'Manager'),
(23, 'Gabriel Morgan', 'Miami, FL, USA', 'EMP20041', 'Admin'),
(24, 'Luna Bell', 'Tampa, FL, USA', 'EMP20042', 'Manager'),
(24, 'Levi Murphy', 'Tampa, FL, USA', 'EMP20043', 'Receptionist'),

-- Hotels 25 to 32
(25, 'Grace Bailey', 'Ottawa, ON, Canada', 'EMP20044', 'Manager'),
(25, 'Henry Rivera', 'Ottawa, ON, Canada', 'EMP20045', 'Receptionist'),
(26, 'Zoey Cooper', 'Ottawa, ON, Canada', 'EMP20046', 'Manager'),
(26, 'Wyatt Richardson', 'Ottawa, ON, Canada', 'EMP20047', 'Housekeeping'),
(27, 'Nora Cox', 'Toronto, ON, Canada', 'EMP20048', 'Manager'),
(27, 'Julian Howard', 'Toronto, ON, Canada', 'EMP20049', 'Receptionist'),
(28, 'Hannah Ward', 'Toronto, ON, Canada', 'EMP20050', 'Manager'),
(28, 'Isaac Torres', 'Toronto, ON, Canada', 'EMP20051', 'Admin'),
(29, 'Lily Peterson', 'Chicago, IL, USA', 'EMP20052', 'Manager'),
(29, 'Lincoln Gray', 'Chicago, IL, USA', 'EMP20053', 'Receptionist'),
(30, 'Layla Ramirez', 'Boston, MA, USA', 'EMP20054', 'Manager'),
(30, 'Anthony James', 'Boston, MA, USA', 'EMP20055', 'Housekeeping'),
(31, 'Aurora Watson', 'Philadelphia, PA, USA', 'EMP20056', 'Manager'),
(31, 'Christopher Brooks', 'Philadelphia, PA, USA', 'EMP20057', 'Receptionist'),
(32, 'Savannah Kelly', 'Washington, DC, USA', 'EMP20058', 'Manager'),
(32, 'Andrew Sanders', 'Washington, DC, USA', 'EMP20059', 'Admin'),

-- Hotels 33 to 40
(33, 'Stella Price', 'New York, NY, USA', 'EMP20060', 'Manager'),
(33, 'Joshua Bennett', 'New York, NY, USA', 'EMP20061', 'Receptionist'),
(34, 'Natalie Wood', 'Brooklyn, NY, USA', 'EMP20062', 'Manager'),
(34, 'Ryan Barnes', 'Brooklyn, NY, USA', 'EMP20063', 'Receptionist'),
(35, 'Zoe Ross', 'Newark, NJ, USA', 'EMP20064', 'Manager'),
(35, 'Nathan Henderson', 'Newark, NJ, USA', 'EMP20065', 'Housekeeping'),
(36, 'Brooklyn Coleman', 'Jersey City, NJ, USA', 'EMP20066', 'Manager'),
(36, 'Christian Jenkins', 'Jersey City, NJ, USA', 'EMP20067', 'Receptionist'),
(37, 'Hazel Perry', 'Dallas, TX, USA', 'EMP20068', 'Manager'),
(37, 'Aaron Powell', 'Dallas, TX, USA', 'EMP20069', 'Admin'),
(38, 'Violet Long', 'Houston, TX, USA', 'EMP20070', 'Manager'),
(38, 'Thomas Patterson', 'Houston, TX, USA', 'EMP20071', 'Receptionist'),
(39, 'Claire Hughes', 'Atlanta, GA, USA', 'EMP20072', 'Manager'),
(39, 'Charles Flores', 'Atlanta, GA, USA', 'EMP20073', 'Housekeeping'),
(40, 'Lucy Washington', 'Charlotte, NC, USA', 'EMP20074', 'Manager'),
(40, 'Josiah Butler', 'Charlotte, NC, USA', 'EMP20075', 'Receptionist');

UPDATE HOTEL SET manager_employee_id = 1 WHERE hotel_id = 1;
UPDATE HOTEL SET manager_employee_id = 3 WHERE hotel_id = 2;
UPDATE HOTEL SET manager_employee_id = 5 WHERE hotel_id = 3;
UPDATE HOTEL SET manager_employee_id = 7 WHERE hotel_id = 4;
UPDATE HOTEL SET manager_employee_id = 8 WHERE hotel_id = 5;
UPDATE HOTEL SET manager_employee_id = 9 WHERE hotel_id = 6;
UPDATE HOTEL SET manager_employee_id = 10 WHERE hotel_id = 7;
UPDATE HOTEL SET manager_employee_id = 11 WHERE hotel_id = 8;
UPDATE HOTEL SET manager_employee_id = 12 WHERE hotel_id = 9;
UPDATE HOTEL SET manager_employee_id = 14 WHERE hotel_id = 10;
UPDATE HOTEL SET manager_employee_id = 16 WHERE hotel_id = 11;
UPDATE HOTEL SET manager_employee_id = 18 WHERE hotel_id = 12;
UPDATE HOTEL SET manager_employee_id = 20 WHERE hotel_id = 13;
UPDATE HOTEL SET manager_employee_id = 22 WHERE hotel_id = 14;
UPDATE HOTEL SET manager_employee_id = 24 WHERE hotel_id = 15;
UPDATE HOTEL SET manager_employee_id = 26 WHERE hotel_id = 16;

UPDATE HOTEL SET manager_employee_id = 28 WHERE hotel_id = 17;
UPDATE HOTEL SET manager_employee_id = 30 WHERE hotel_id = 18;
UPDATE HOTEL SET manager_employee_id = 32 WHERE hotel_id = 19;
UPDATE HOTEL SET manager_employee_id = 34 WHERE hotel_id = 20;
UPDATE HOTEL SET manager_employee_id = 36 WHERE hotel_id = 21;
UPDATE HOTEL SET manager_employee_id = 38 WHERE hotel_id = 22;
UPDATE HOTEL SET manager_employee_id = 40 WHERE hotel_id = 23;
UPDATE HOTEL SET manager_employee_id = 42 WHERE hotel_id = 24;

UPDATE HOTEL SET manager_employee_id = 44 WHERE hotel_id = 25;
UPDATE HOTEL SET manager_employee_id = 46 WHERE hotel_id = 26;
UPDATE HOTEL SET manager_employee_id = 48 WHERE hotel_id = 27;
UPDATE HOTEL SET manager_employee_id = 50 WHERE hotel_id = 28;
UPDATE HOTEL SET manager_employee_id = 52 WHERE hotel_id = 29;
UPDATE HOTEL SET manager_employee_id = 54 WHERE hotel_id = 30;
UPDATE HOTEL SET manager_employee_id = 56 WHERE hotel_id = 31;
UPDATE HOTEL SET manager_employee_id = 58 WHERE hotel_id = 32;

UPDATE HOTEL SET manager_employee_id = 60 WHERE hotel_id = 33;
UPDATE HOTEL SET manager_employee_id = 62 WHERE hotel_id = 34;
UPDATE HOTEL SET manager_employee_id = 64 WHERE hotel_id = 35;
UPDATE HOTEL SET manager_employee_id = 66 WHERE hotel_id = 36;
UPDATE HOTEL SET manager_employee_id = 68 WHERE hotel_id = 37;
UPDATE HOTEL SET manager_employee_id = 70 WHERE hotel_id = 38;
UPDATE HOTEL SET manager_employee_id = 72 WHERE hotel_id = 39;
UPDATE HOTEL SET manager_employee_id = 74 WHERE hotel_id = 40;

INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
(1, '101', 120.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.5),
(1, '102', 150.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.0),
(1, '103', 210.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 40.0),
(1, '104', 180.00, 'WiFi,TV', 'Double', 'City', FALSE, 'Minor wall scratch', 30.0),
(1, '105', 250.00, 'WiFi,TV,AC,Mini Bar', 'Family', 'Garden', TRUE, 'None', 45.0),

(2, '201', 130.00, 'WiFi,TV', 'Single', 'City', FALSE, 'None', 23.0),
(2, '202', 160.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.0),
(2, '203', 220.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.0),
(2, '204', 175.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.0),
(2, '205', 240.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.0);
INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
-- Hotel 3
(3, '301', 125.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.0),
(3, '302', 155.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.0),
(3, '303', 215.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 40.0),
(3, '304', 185.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 30.0),
(3, '305', 245.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 44.0),

-- Hotel 4
(4, '401', 128.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.5),
(4, '402', 158.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.5),
(4, '403', 218.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.0),
(4, '404', 188.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.0),
(4, '405', 248.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.0),

-- Hotel 5
(5, '501', 135.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.0),
(5, '502', 165.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.0),
(5, '503', 225.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.0),
(5, '504', 195.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.0),
(5, '505', 255.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.0),

-- Hotel 6
(6, '601', 118.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.5),
(6, '602', 148.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.5),
(6, '603', 208.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 39.0),
(6, '604', 178.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 29.5),
(6, '605', 238.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 43.0),

-- Hotel 7
(7, '701', 145.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.0),
(7, '702', 175.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.0),
(7, '703', 235.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 43.0),
(7, '704', 205.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.0),
(7, '705', 265.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.0),

-- Hotel 8
(8, '801', 132.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.8),
(8, '802', 162.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.8),
(8, '803', 222.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.5),
(8, '804', 192.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.5),
(8, '805', 252.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.5);
INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
-- Hotel 9
(9, '901', 140.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.0),
(9, '902', 170.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.0),
(9, '903', 230.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.0),
(9, '904', 200.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.0),
(9, '905', 260.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.0),

-- Hotel 10
(10, '1001', 138.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.8),
(10, '1002', 168.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.8),
(10, '1003', 228.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.8),
(10, '1004', 198.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.8),
(10, '1005', 258.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.8),

-- Hotel 11
(11, '1101', 142.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.2),
(11, '1102', 172.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.2),
(11, '1103', 232.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.2),
(11, '1104', 202.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.2),
(11, '1105', 262.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.2),

-- Hotel 12
(12, '1201', 122.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.8),
(12, '1202', 152.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.8),
(12, '1203', 212.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 39.8),
(12, '1204', 182.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 29.8),
(12, '1205', 242.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 43.8),

-- Hotel 13
(13, '1301', 150.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.0),
(13, '1302', 180.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.0),
(13, '1303', 240.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 43.0),
(13, '1304', 210.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.0),
(13, '1305', 270.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.0),

-- Hotel 14
(14, '1401', 118.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.5),
(14, '1402', 148.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.5),
(14, '1403', 208.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 39.5),
(14, '1404', 178.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 29.5),
(14, '1405', 238.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 43.5),

-- Hotel 15
(15, '1501', 134.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.9),
(15, '1502', 164.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.9),
(15, '1503', 224.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.9),
(15, '1504', 194.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.9),
(15, '1505', 254.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.9),

-- Hotel 16
(16, '1601', 136.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.1),
(16, '1602', 166.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.1),
(16, '1603', 226.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.1),
(16, '1604', 196.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.1),
(16, '1605', 256.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.1);
INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
-- Hotel 17
(17, '1701', 144.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.4),
(17, '1702', 174.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.4),
(17, '1703', 234.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.4),
(17, '1704', 204.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.4),
(17, '1705', 264.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.4),

-- Hotel 18
(18, '1801', 139.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.9),
(18, '1802', 169.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.9),
(18, '1803', 229.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.9),
(18, '1804', 199.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.9),
(18, '1805', 259.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.9),

-- Hotel 19
(19, '1901', 152.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.2),
(19, '1902', 182.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.2),
(19, '1903', 242.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 43.2),
(19, '1904', 212.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.2),
(19, '1905', 272.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.2),

-- Hotel 20
(20, '2001', 133.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.3),
(20, '2002', 163.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.3),
(20, '2003', 223.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.3),
(20, '2004', 193.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.3),
(20, '2005', 253.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.3),

-- Hotel 21
(21, '2101', 155.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.5),
(21, '2102', 185.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.5),
(21, '2103', 245.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 43.5),
(21, '2104', 215.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.5),
(21, '2105', 275.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.5),

-- Hotel 22
(22, '2201', 147.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.7),
(22, '2202', 177.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.7),
(22, '2203', 237.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.7),
(22, '2204', 207.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.7),
(22, '2205', 267.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.7),

-- Hotel 23
(23, '2301', 158.00, 'WiFi,TV,AC', 'Single', 'Sea', FALSE, 'None', 24.8),
(23, '2302', 188.00, 'WiFi,TV,AC', 'Double', 'Sea', TRUE, 'None', 30.8),
(23, '2303', 248.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Sea', TRUE, 'None', 43.8),
(23, '2304', 218.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.8),
(23, '2305', 278.00, 'WiFi,TV,AC', 'Family', 'Sea', TRUE, 'None', 47.8),

-- Hotel 24
(24, '2401', 129.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.9),
(24, '2402', 159.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.9),
(24, '2403', 219.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 40.9),
(24, '2404', 189.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 30.9),
(24, '2405', 249.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 44.9);
INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
-- Hotel 25
(25, '2501', 131.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.1),
(25, '2502', 161.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.1),
(25, '2503', 221.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.1),
(25, '2504', 191.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.1),
(25, '2505', 251.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.1),

-- Hotel 26
(26, '2601', 126.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.6),
(26, '2602', 156.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.6),
(26, '2603', 216.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 40.6),
(26, '2604', 186.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 30.6),
(26, '2605', 246.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 44.6),

-- Hotel 27
(27, '2701', 143.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.3),
(27, '2702', 173.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.3),
(27, '2703', 233.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.3),
(27, '2704', 203.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.3),
(27, '2705', 263.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.3),

-- Hotel 28
(28, '2801', 149.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.9),
(28, '2802', 179.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.9),
(28, '2803', 239.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.9),
(28, '2804', 209.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.9),
(28, '2805', 269.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.9),

-- Hotel 29
(29, '2901', 154.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.4),
(29, '2902', 184.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.4),
(29, '2903', 244.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 43.4),
(29, '2904', 214.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.4),
(29, '2905', 274.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.4),

-- Hotel 30
(30, '3001', 146.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.6),
(30, '3002', 176.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.6),
(30, '3003', 236.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 42.6),
(30, '3004', 206.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.6),
(30, '3005', 266.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.6),

-- Hotel 31
(31, '3101', 127.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 21.7),
(31, '3102', 157.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 27.7),
(31, '3103', 217.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 40.7),
(31, '3104', 187.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 30.7),
(31, '3105', 247.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 44.7),

-- Hotel 32
(32, '3201', 160.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 25.0),
(32, '3202', 190.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 31.0),
(32, '3203', 250.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 44.0),
(32, '3204', 220.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 34.0),
(32, '3205', 280.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 48.0);

INSERT INTO ROOM (hotel_id, room_number, price, amenities, capacity, view_type, extendable_bed, damage_status, area) VALUES
-- Hotel 33
(33, '3301', 165.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 25.2),
(33, '3302', 195.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 31.2),
(33, '3303', 255.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 44.2),
(33, '3304', 225.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 34.2),
(33, '3305', 285.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 48.2),

-- Hotel 34
(34, '3401', 148.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.8),
(34, '3402', 178.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.8),
(34, '3403', 238.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 42.8),
(34, '3404', 208.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.8),
(34, '3405', 268.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.8),

-- Hotel 35
(35, '3501', 132.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.2),
(35, '3502', 162.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.2),
(35, '3503', 222.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.2),
(35, '3504', 192.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.2),
(35, '3505', 252.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.2),

-- Hotel 36
(36, '3601', 141.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.1),
(36, '3602', 171.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.1),
(36, '3603', 231.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 42.1),
(36, '3604', 201.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.1),
(36, '3605', 261.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.1),

-- Hotel 37
(37, '3701', 153.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 24.3),
(37, '3702', 183.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 30.3),
(37, '3703', 243.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 43.3),
(37, '3704', 213.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 33.3),
(37, '3705', 273.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 47.3),

-- Hotel 38
(38, '3801', 145.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 23.5),
(38, '3802', 175.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 29.5),
(38, '3803', 235.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 42.5),
(38, '3804', 205.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 32.5),
(38, '3805', 265.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 46.5),

-- Hotel 39
(39, '3901', 137.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.7),
(39, '3902', 167.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.7),
(39, '3903', 227.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'Garden', TRUE, 'None', 41.7),
(39, '3904', 197.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.7),
(39, '3905', 257.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.7),

-- Hotel 40
(40, '4001', 134.00, 'WiFi,TV,AC', 'Single', 'City', FALSE, 'None', 22.4),
(40, '4002', 164.00, 'WiFi,TV,AC', 'Double', 'City', TRUE, 'None', 28.4),
(40, '4003', 224.00, 'WiFi,TV,AC,Mini Bar', 'Suite', 'City', TRUE, 'None', 41.4),
(40, '4004', 194.00, 'WiFi,TV', 'Double', 'City', FALSE, 'None', 31.4),
(40, '4005', 254.00, 'WiFi,TV,AC', 'Family', 'Garden', TRUE, 'None', 45.4);

INSERT INTO RESERVATION (client_id, room_id, start_date, end_date, reservation_date, status) VALUES
(1, 1, '2026-04-15', '2026-04-18', '2026-04-09', 'Confirmed'),
(2, 2, '2026-04-20', '2026-04-23', '2026-04-09', 'Pending'),
(3, 6, '2026-04-12', '2026-04-14', '2026-04-08', 'Confirmed');
INSERT INTO RESERVATION (client_id, room_id, start_date, end_date, reservation_date, status) VALUES
(4, 10, '2026-04-18', '2026-04-21', '2026-04-10', 'Confirmed'),
(5, 15, '2026-04-22', '2026-04-25', '2026-04-11', 'Pending'),
(6, 21, '2026-04-16', '2026-04-19', '2026-04-10', 'Confirmed'),
(2, 26, '2026-04-28', '2026-05-01', '2026-04-12', 'Confirmed'),
(3, 31, '2026-04-17', '2026-04-20', '2026-04-09', 'Cancelled'),
(1, 36, '2026-04-24', '2026-04-27', '2026-04-13', 'Confirmed'),
(5, 41, '2026-04-19', '2026-04-22', '2026-04-12', 'Pending'),
(6, 46, '2026-04-26', '2026-04-29', '2026-04-14', 'Confirmed'),
(2, 51, '2026-04-21', '2026-04-23', '2026-04-12', 'Confirmed'),
(4, 56, '2026-04-30', '2026-05-03', '2026-04-15', 'Pending');

INSERT INTO RENTAL (client_id, room_id, employee_id, reservation_id, check_in_date, check_out_date, status) VALUES
(1, 1, 2, 1, '2026-04-15', '2026-04-18', 'Active'),
(4, 3, 1, NULL, '2026-04-10', '2026-04-12', 'Active');

INSERT INTO RENTAL (client_id, room_id, employee_id, reservation_id, check_in_date, check_out_date, status) VALUES
(4, 10, 14, 4, '2026-04-18', '2026-04-21', 'Active'),
(6, 21, 20, 6, '2026-04-16', '2026-04-19', 'Active'),
(2, 26, 24, 8, '2026-04-28', '2026-05-01', 'Active'),
(5, 60, 44, NULL, '2026-04-11', '2026-04-13', 'Completed'),
(3, 75, 52, NULL, '2026-04-14', '2026-04-16', 'Completed'),
(1, 90, 60, NULL, '2026-04-20', '2026-04-22', 'Active');

SELECT chain_id, COUNT(*) AS hotel_count
FROM HOTEL
GROUP BY chain_id;
SELECT COUNT(*) AS employee_count FROM EMPLOYEE;
SELECT COUNT(*) AS hotels_with_manager
FROM HOTEL
WHERE manager_employee_id IS NOT NULL;

SELECT hotel_id, COUNT(*) AS room_count
FROM ROOM
GROUP BY hotel_id
ORDER BY hotel_id;

SELECT COUNT(*) AS reservation_count FROM RESERVATION;
SELECT COUNT(*) AS rental_count FROM RENTAL;