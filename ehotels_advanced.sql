USE ehotels;

-- =========================================
-- VIEWS
-- =========================================

-- View 1: Number of available rooms by city
CREATE OR REPLACE VIEW available_rooms_by_city AS
SELECT 
    h.city,
    COUNT(r.room_id) AS available_room_count
FROM ROOM r
JOIN HOTEL h ON r.hotel_id = h.hotel_id
WHERE r.room_id NOT IN (
    SELECT res.room_id
    FROM RESERVATION res
    WHERE res.status IN ('Confirmed', 'Pending')
)
AND r.room_id NOT IN (
    SELECT ren.room_id
    FROM RENTAL ren
    WHERE ren.status = 'Active'
)
GROUP BY h.city;

-- View 2: Total room capacity of each hotel
CREATE OR REPLACE VIEW hotel_total_capacity AS
SELECT
    h.hotel_id,
    h.name AS hotel_name,
    SUM(
        CASE r.capacity
            WHEN 'Single' THEN 1
            WHEN 'Double' THEN 2
            WHEN 'Suite' THEN 4
            WHEN 'Family' THEN 5
            ELSE 0
        END
    ) AS total_capacity
FROM HOTEL h
JOIN ROOM r ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.name;

-- Test views
SELECT * FROM available_rooms_by_city;
SELECT * FROM hotel_total_capacity;

-- =========================================
-- INDEXES
-- =========================================

-- Speeds up searches by city
CREATE INDEX idx_hotel_city ON HOTEL(city);

-- Speeds up joins between ROOM and HOTEL
CREATE INDEX idx_room_hotel_id ON ROOM(hotel_id);

-- Speeds up room/date availability checks
CREATE INDEX idx_reservation_room_dates ON RESERVATION(room_id, start_date, end_date);

-- Check indexes
SHOW INDEX FROM HOTEL;
SHOW INDEX FROM ROOM;
SHOW INDEX FROM RESERVATION;

-- =========================================
-- TRIGGERS
-- =========================================

-- Trigger 1: Prevent overlapping reservations for the same room
DELIMITER $$

CREATE TRIGGER trg_prevent_overlapping_reservations
BEFORE INSERT ON RESERVATION
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM RESERVATION
        WHERE room_id = NEW.room_id
          AND status IN ('Confirmed', 'Pending')
          AND NEW.start_date < end_date
          AND NEW.end_date > start_date
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Overlapping reservation for this room is not allowed';
    END IF;
END $$

DELIMITER ;

-- Trigger 2: Prevent assigning a non-manager as hotel manager
DELIMITER $$

CREATE TRIGGER trg_check_manager_role
BEFORE UPDATE ON HOTEL
FOR EACH ROW
BEGIN
    IF NEW.manager_employee_id IS NOT NULL THEN
        IF (SELECT role FROM EMPLOYEE WHERE employee_id = NEW.manager_employee_id) <> 'Manager' THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Assigned employee must have role Manager';
        END IF;
    END IF;
END $$

DELIMITER ;

DROP INDEX idx_hotel_city ON HOTEL;
DROP INDEX idx_room_hotel_id ON ROOM;
DROP INDEX idx_reservation_room_dates ON RESERVATION;

CREATE INDEX idx_hotel_city ON HOTEL(city);
CREATE INDEX idx_room_hotel_id ON ROOM(hotel_id);
CREATE INDEX idx_reservation_room_dates ON RESERVATION(room_id, start_date, end_date);

SHOW TABLES;

SELECT * FROM available_rooms_by_city;
SHOW INDEX FROM HOTEL;
SHOW INDEX FROM ROOM;
SHOW INDEX FROM RESERVATION;
SHOW TRIGGERS;