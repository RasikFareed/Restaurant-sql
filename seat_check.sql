/*Create a function to check the seat*/
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


/*Create a function to check the item*/

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


/*Create a function to check the quantity*/

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




