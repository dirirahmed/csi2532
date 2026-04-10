DELIMITER //

-- TRIGGER 1: Synchronize Room Counts
-- Requirement: Automatic update after insertion
-- This ensures that when the Admin adds a room via the website, 
-- the 'num_rooms' in the HOTEL table updates automatically.
CREATE TRIGGER after_room_insert 
AFTER INSERT ON ROOM
FOR EACH ROW
BEGIN
    UPDATE HOTEL 
    SET num_rooms = num_rooms + 1 
    WHERE hotel_id = NEW.hotel_id;
END //

-- TRIGGER 2: Referential Integrity Protection
-- Requirement: Custom constraint for deletion
-- Per instructions, some entities can be deleted, but we must 
-- prevent deleting a hotel if it still has active reservations.
CREATE TRIGGER before_hotel_delete
BEFORE DELETE ON HOTEL
FOR EACH ROW
BEGIN
    DECLARE res_count INT;
    
    SELECT COUNT(*) INTO res_count 
    FROM ROOM r 
    JOIN RESERVATION res ON r.room_id = res.room_id 
    WHERE r.hotel_id = OLD.hotel_id;

    IF res_count > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erreur: Impossible de supprimer un hôtel avec des réservations actives.';
    END IF;
END //

DELIMITER ;