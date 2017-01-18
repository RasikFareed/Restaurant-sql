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

SELECT check_item('Fried Rice')
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


/*Create a function to check whether Restaurant is serving*/
DELIMITER $$
CREATE  FUNCTION check_serving(orderedTime TIME) RETURNS INT(11)
BEGIN
DECLARE flag INT;

IF  EXISTS(SELECT id FROM foodtype WHERE orderedTime BETWEEN FromTime AND ToTime)
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$
DELIMITER ;

SELECT check_serving('11:20:22')



/*Create a function to check whether the ordered item is served in respective session*/
DELIMITER $$
CREATE  FUNCTION check_serving_time(itemType INT,orderedTime TIME) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF(itemType IN (SELECT id FROM FoodType WHERE foodtype.`FromTime` <=orderedTime  AND foodtype.`ToTime`>=orderedTime ))
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$
DELIMITER ;


/*Create a function to check the seat status*/
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


