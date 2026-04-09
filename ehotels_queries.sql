USE ehotels;

-- Query 1: List all hotels with their chain
SELECT 
    h.hotel_id,
    h.name AS hotel_name,
    hc.name AS chain_name,
    h.city,
    h.category
FROM HOTEL h
JOIN HOTEL_CHAIN hc ON h.chain_id = hc.chain_id
ORDER BY hc.name, h.city;

-- Query 2: Search rooms by city, capacity, and max price
SELECT 
    r.room_id,
    h.name AS hotel_name,
    h.city,
    r.room_number,
    r.capacity,
    r.price
FROM ROOM r
JOIN HOTEL h ON r.hotel_id = h.hotel_id
WHERE h.city = 'Ottawa'
  AND r.capacity = 'Double'
  AND r.price <= 200
ORDER BY r.price;

-- Query 3: Show all reservations with client and hotel info
SELECT 
    res.reservation_id,
    c.full_name AS client_name,
    h.name AS hotel_name,
    r.room_number,
    res.start_date,
    res.end_date,
    res.status
FROM RESERVATION res
JOIN CLIENT c ON res.client_id = c.client_id
JOIN ROOM r ON res.room_id = r.room_id
JOIN HOTEL h ON r.hotel_id = h.hotel_id
ORDER BY res.start_date;

-- Query 4: Show active rentals with employee responsible
SELECT
    ren.rental_id,
    c.full_name AS client_name,
    h.name AS hotel_name,
    r.room_number,
    e.full_name AS employee_name,
    ren.check_in_date,
    ren.check_out_date,
    ren.status
FROM RENTAL ren
JOIN CLIENT c ON ren.client_id = c.client_id
JOIN ROOM r ON ren.room_id = r.room_id
JOIN HOTEL h ON r.hotel_id = h.hotel_id
LEFT JOIN EMPLOYEE e ON ren.employee_id = e.employee_id
WHERE ren.status = 'Active';