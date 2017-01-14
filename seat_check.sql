DELIMITER $$

CREATE  FUNCTION check_seat(seat_no VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT Seats FROM seat WHERE Seats=seat_no) THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;

DROP FUNCTION check_seat
SELECT  check_seat('seat11');


DELIMITER $$

CREATE  FUNCTION check_item(item VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT foodList FROM menu WHERE foodList=item) THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;

SELECT check_item('Chapattis')






DELIMITER $$

CREATE  FUNCTION check_quantity(itemId INT,itemtype INT,item_quantity INT) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF((item_quantity>0 AND item_quantity<=(SELECT quantity FROM menuorder WHERE menuList=itemId AND foodType=itemtype)))
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$

DELIMITER ;

DROP FUNCTION check_quantity
SELECT check_quantity(1,1,500)


