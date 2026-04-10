DROP DATABASE IF EXISTS ehotels;
CREATE DATABASE IF NOT EXISTS ehotels;
USE ehotels;

CREATE TABLE HOTEL_CHAIN (
    chain_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    head_office_address VARCHAR(255) NOT NULL,
    num_hotels INT NOT NULL DEFAULT 0 CHECK (num_hotels >= 0),
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL
);

CREATE TABLE CLIENT (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    ssn_sin VARCHAR(20) NOT NULL UNIQUE,
    registration_date DATE NOT NULL 
);

CREATE TABLE HOTEL (
    hotel_id INT AUTO_INCREMENT PRIMARY KEY,
    chain_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    category INT NOT NULL CHECK (category BETWEEN 1 AND 5),
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    province_state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    num_rooms INT NOT NULL DEFAULT 0 CHECK (num_rooms >= 0),
    contact_email VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    manager_employee_id INT UNIQUE,
    FOREIGN KEY (chain_id) REFERENCES HOTEL_CHAIN(chain_id) ON DELETE CASCADE
);

CREATE TABLE EMPLOYEE (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    ssn_sin VARCHAR(20) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL CHECK (role IN ('Manager', 'Receptionist', 'Housekeeping', 'Admin', 'Other')),
    FOREIGN KEY (hotel_id) REFERENCES HOTEL(hotel_id) ON DELETE CASCADE
);

ALTER TABLE HOTEL ADD CONSTRAINT fk_manager_employee FOREIGN KEY (manager_employee_id) REFERENCES EMPLOYEE(employee_id) ON DELETE SET NULL;

CREATE TABLE ROOM (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    hotel_id INT NOT NULL,
    room_number VARCHAR(10) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    amenities VARCHAR(255),
    capacity VARCHAR(50) NOT NULL CHECK (capacity IN ('Single', 'Double', 'Suite', 'Family')),
    view_type VARCHAR(50) CHECK (view_type IN ('Sea', 'Mountain', 'City', 'Garden', 'None')),
    extendable_bed BOOLEAN NOT NULL,
    damage_status VARCHAR(255),
    area DECIMAL(8,2) NOT NULL CHECK (area > 0),
    UNIQUE (hotel_id, room_number),
    FOREIGN KEY (hotel_id) REFERENCES HOTEL(hotel_id) ON DELETE CASCADE
);

CREATE TABLE RESERVATION (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    room_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reservation_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('Pending', 'Confirmed', 'Cancelled')),
    CHECK (end_date > start_date),
    FOREIGN KEY (client_id) REFERENCES CLIENT(client_id),
    FOREIGN KEY (room_id) REFERENCES ROOM(room_id)
);

CREATE TABLE RENTAL (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    room_id INT NOT NULL,
    employee_id INT,
    reservation_id INT,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('Active', 'Completed', 'Cancelled')),
    CHECK (check_out_date > check_in_date),
    FOREIGN KEY (client_id) REFERENCES CLIENT(client_id),
    FOREIGN KEY (room_id) REFERENCES ROOM(room_id),
    FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
    FOREIGN KEY (reservation_id) REFERENCES RESERVATION(reservation_id)
);