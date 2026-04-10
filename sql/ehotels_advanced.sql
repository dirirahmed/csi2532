USE ehotels;

-- =========================================
-- VIEWS 
-- =========================================

-- View 1: Available rooms by zone (Requirement: Available rooms per area) 
CREATE OR REPLACE VIEW available_rooms_by_zone AS
SELECT 
    h.city AS zone,
    COUNT(r.room_id) AS available_room_count
FROM ROOM r
JOIN HOTEL h ON r.hotel_id = h.hotel_id
WHERE r.room_id NOT IN (SELECT room_id FROM RESERVATION WHERE status IN ('Confirmed', 'Pending'))
AND r.room_id NOT IN (SELECT room_id FROM RENTAL WHERE status = 'Active')
GROUP BY h.city;

-- View 2: Total room capacity of each hotel 
CREATE OR REPLACE VIEW hotel_total_capacity AS
SELECT
    h.hotel_id,
    h.name AS hotel_name,
    SUM(CASE r.capacity WHEN 'Single' THEN 1 WHEN 'Double' THEN 2 WHEN 'Suite' THEN 4 WHEN 'Family' THEN 5 ELSE 0 END) AS total_capacity
FROM HOTEL h
JOIN ROOM r ON h.hotel_id = r.hotel_id
GROUP BY h.hotel_id, h.name;

-- =========================================
-- INDEXES (Requirement: At least 3) 
-- =========================================
CREATE INDEX idx_hotel_city ON HOTEL(city); -- Speed up zone-based searches
CREATE INDEX idx_room_price ON ROOM(price); -- Speed up price filtering
CREATE INDEX idx_res_dates ON RESERVATION(start_date, end_date); -- Speed up availability checks

-- =========================================
-- TRIGGERS (Requirement: At least 2) 
-- =========================================
DELIMITER $$

-- Trigger 1: Sync num_rooms on insert 
CREATE TRIGGER after_room_insert 
AFTER INSERT ON ROOM
FOR EACH ROW
BEGIN
    UPDATE HOTEL SET num_rooms = num_rooms + 1 WHERE hotel_id = NEW.hotel_id;
END $$

-- Trigger 2: Prevent deletion if active rentals exist 
CREATE TRIGGER before_hotel_delete
BEFORE DELETE ON HOTEL
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM RENTAL ren JOIN ROOM r ON ren.room_id = r.room_id WHERE r.hotel_id = OLD.hotel_id AND ren.status = 'Active') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete hotel with active rentals.';
    END IF;
END $$

DELIMITER ;