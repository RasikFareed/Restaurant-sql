DROP PROCEDURE foodOrder;

DELIMITER $$

CREATE PROCEDURE foodOrder(l_order_id INT,seatno VARCHAR(20),item VARCHAR(20),quant SMALLINT,orderedTime TIME,OUT out_message VARCHAR(200))
BEGIN
DECLARE seat INT;
DECLARE l_item VARCHAR(20);
DECLARE itemId INT;
DECLARE itemType INT;
DECLARE check_quant INT;
DECLARE l_seat_id INT;
SET itemId = (SELECT id FROM menu WHERE food_list=item);
SET itemType = (SELECT food_type FROM menuorder WHERE menu_list=itemId AND food_type IN
		(SELECT id FROM foodtype WHERE foodtype.`From_time` <=orderedTime  AND foodtype.`To_time`>=orderedTime ));
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
	IF(check_serving(orderedTime)=1)
	THEN
/*Check whether the ordered item is served in respective session*/
	IF(check_serving_time(itemType,orderedTime)=1)
	THEN
/*Check for the ordered quantity is available in stock*/
	IF(check_quant=1)
	THEN
		START TRANSACTION;
		SET Autocommit=0;
		INSERT INTO food_transaction(ordered_id,seat_no,ordered_item,quantity,ordered_time,ordered_date,state)VALUES(l_order_id,seatno,item,quant,orderedTime,CURRENT_DATE,'Ordered');
		UPDATE menuorder SET quantity=quantity-quant
		WHERE menu_list=itemId AND food_type=itemType;
		INSERT INTO order_details(order_id,seat_id,order_item) VALUES(l_order_id,l_seat_id,itemId);
		SELECT CONCAT('Order Placed. Your order id is ',l_order_id)INTO out_message;
		COMMIT;
	ELSE
	SELECT 'Invalid Quantity.Please choose a valid quantity'INTO out_message;
	END IF;	
	ELSE
	SELECT 'Invalid Time.We dont serve those items now.' INTO out_message;
	END IF;
	ELSE
	SELECT 'We are not serving at a moment.Wait for next session' INTO out_message;
	END IF;
	ELSE
	SELECT 'Invalid Item. We dont serve that item.' INTO out_message;
	END IF;
	ELSE
	SELECT 'Invalid Seat no.Please choose the correct seat no(seat1-seat10)' INTO out_message;
	END IF;
END $$
DELIMITER ;

