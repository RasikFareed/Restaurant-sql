DROP PROCEDURE seat_check;

DELIMITER $$
CREATE PROCEDURE seat_check(seatno VARCHAR(20),OUT seat_msg VARCHAR(20),OUT FLAG BOOLEAN)
BEGIN
DECLARE states VARCHAR(20);
DECLARE toggle_seats BOOLEAN;

SELECT concurrent_user_state INTO toggle_seats FROM seat_status WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno);
SET states=(SELECT state FROM seat_status WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno));
IF(states='Available')
THEN
IF toggle_seats=FALSE
	THEN
	
		UPDATE seat_status SET concurrent_user_state=TRUE WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno);
		SET FLAG=1;
		SELECT FLAG INTO seat_msg;
		
		
	ELSE
		SET FLAG=0;
		SELECT FLAG INTO seat_msg;
		
     
	END IF;
	ELSE
		SET FLAG=0;
		SELECT FLAG INTO seat_msg;
		
END IF;

end $$
delimiter ;

call seat_check('seat1',@seat_msg,@FLAG);