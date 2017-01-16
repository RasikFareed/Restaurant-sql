DELIMITER $$

CREATE PROCEDURE foodOrder(l_order_id INT,seatno VARCHAR(20),item VARCHAR(20),quant SMALLINT,orderedTime TIME)
BEGIN
DECLARE seat INT;
DECLARE l_item VARCHAR(20);
DECLARE itemId INT;
DECLARE itemType INT;
DECLARE check_quant INT;
DECLARE l_seat_id INT;
SET itemId =     (SELECT id FROM menu WHERE foodlist=item);
SET itemType =   (SELECT foodType FROM menuorder WHERE menuList=itemId AND foodtype IN
		(SELECT id FROM foodtype WHERE foodtype.`FromTime` <=orderedTime  AND foodtype.`ToTime`>=orderedTime ));
SET l_item=check_item(item);
SET seat=check_seat(seatno);
SET check_quant=check_quantity(itemId,itemType,quant);
SET l_seat_id=(SELECT id FROM seat WHERE Seats=seatno);
 /*Check whether the seat exists*/ 
IF(seat=1)
THEN
/*Check whether the item exists*/ 
IF(l_item=1)
THEN
/*Check whether the restaurant takes order in given time*/ 
IF  EXISTS(SELECT id FROM foodtype WHERE orderedTime BETWEEN FromTime AND toTime)
THEN
/*Check whether the ordered item is served in respective session*/
IF(itemType IN (SELECT id FROM FoodType WHERE foodtype.`FromTime` <=orderedTime  AND foodtype.`ToTime`>=orderedTime ))
	THEN
/*Check for the ordered quantity is available in stock*/
IF(quant>0 AND quant<=(SELECT quantity FROM menuorder WHERE menuList=itemId AND foodType=itemtype))
THEN
	START TRANSACTION;
	SET Autocommit=0;
	INSERT INTO food_transaction(seat_no,ordered_item,quantity,ordered_time,state)VALUES(seatno,item,quant,orderedTime,'Ordered');
	UPDATE menuorder SET quantity=quantity-quant
	WHERE menuList=itemId AND foodType=itemType;
	insert into order_details(order_id,seat_id,order_item) values(l_order_id,l_seat_id,itemId);
	COMMIT;
ELSE
SELECT 'Invalid Quantity'AS message;
END IF;	
ELSE
SELECT 'Invalid Time.We dont serve those items now.' AS message;
END IF;
ELSE
SELECT 'We are not serving at a moment.Wait for next session' AS message;
END IF;
ELSE
SELECT 'Invalid Item. We dont serve that item.' AS message;
END IF;
ELSE
SELECT 'Invalid Seat no.Please choose the correct seat no(seat1-seat10)' AS message;
END IF;
END $$
DELIMITER ;

DROP PROCEDURE foodOrder;

CALL foodOrder('seat1','Chapatti',5,'20:00');

TRUNCATE food_transaction