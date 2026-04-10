USE ehotels;

-- Query 1: Search rooms with combined criteria 
SELECT r.*, h.name, h.city, h.category
FROM ROOM r 
JOIN HOTEL h ON r.hotel_id = h.hotel_id
WHERE h.city = 'Ottawa' AND r.capacity = 'Double' AND r.price <= 250;

-- Query 2: Convert Reservation to Rental (Check-in) 
-- Assuming reservation_id 1 is checking in
INSERT INTO RENTAL (client_id, room_id, employee_id, reservation_id, check_in_date, check_out_date, status)
SELECT client_id, room_id, (SELECT employee_id FROM EMPLOYEE WHERE hotel_id = (SELECT hotel_id FROM ROOM WHERE room_id = RESERVATION.room_id) LIMIT 1), 
       reservation_id, start_date, end_date, 'Active'
FROM RESERVATION WHERE reservation_id = 1;

-- Query 3: Show available rooms per zone 
SELECT * FROM available_rooms_by_zone;

-- Query 4: Capacity check per hotel 
SELECT * FROM hotel_total_capacity;