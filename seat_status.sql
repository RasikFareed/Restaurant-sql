DELIMITER $$
CREATE FUNCTION seat_status(seatno VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE states VARCHAR(20);
DECLARE flag INT;
SET states=(SELECT state FROM seat_status WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno));
IF(states='Available')
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$
DELIMITER ;

DROP FUNCTION seat_status
SELECT seat_status('seat4')