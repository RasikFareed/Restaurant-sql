/*Create a function to check the seat*/
DROP FUNCTION check_seat;

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

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Create a function to check the item*/
DROP FUNCTION check_item;
DELIMITER $$

CREATE  FUNCTION check_item(item VARCHAR(20)) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF EXISTS(SELECT food_list FROM menu WHERE food_list=item) THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END$$

DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Create a function to check the quantity*/
DROP FUNCTION check_quantity;

DELIMITER $$

CREATE  FUNCTION check_quantity(itemId INT,itemtype INT,item_quantity INT) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF((item_quantity>0 AND item_quantity<=(SELECT quantity FROM menuorder WHERE menu_list=itemId AND food_type=itemtype)))
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$

DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Create a function to check whether Restaurant is serving*/
DROP FUNCTION check_serving;

DELIMITER $$
CREATE  FUNCTION check_serving(orderedTime TIME) RETURNS INT(11)
BEGIN
DECLARE flag INT;

IF  EXISTS(SELECT id FROM foodtype WHERE orderedTime BETWEEN From_time AND To_time)
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$
DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Create a function to check whether the ordered item is served in respective session*/
DROP FUNCTION check_serving_time;
DELIMITER $$
CREATE  FUNCTION check_serving_time(itemType INT,orderedTime TIME) RETURNS INT(11)
BEGIN
DECLARE flag INT;
IF(itemType IN (SELECT id FROM FoodType WHERE foodtype.`From_time` <=orderedTime  AND foodtype.`To_time`>=orderedTime ))
THEN
SET flag=1;
ELSE
SET flag=0;
END IF;
RETURN flag;
END $$
DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Create a function to check the seat status*/
DROP FUNCTION seat_status;

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

CALL seat_status('seat1')
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Create a function to generate unique order_id*/
DROP FUNCTION rand_no;

DELIMITER $$
CREATE FUNCTION rand_no() RETURNS INT(11)
BEGIN
DECLARE order_id INT;
SET order_id=(FLOOR(100+RAND()*(900)));
IF order_id IN(SELECT ordered_id AS ordere_id FROM food_transaction)
THEN
CALL rand_no();
END IF;
RETURN order_id;
END $$
DELIMITER ;


