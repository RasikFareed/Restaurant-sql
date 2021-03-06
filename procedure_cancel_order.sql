DROP PROCEDURE cancel_order;

DELIMITER $$

CREATE PROCEDURE cancel_order(order_id INT,seatno VARCHAR(20),item VARCHAR(20),OUT cancel_message VARCHAR(50))
BEGIN
DECLARE itemId INT;
DECLARE itemType INT;
DECLARE f_orderedTime VARCHAR(20);
DECLARE l_qty INT;
DECLARE qty INT;
DECLARE f_ordereditem VARCHAR(20);

SET f_ordereditem=(SELECT  ordered_item FROM food_transaction WHERE ordered_id=order_id AND seat_no=seatno AND ordered_item=item AND ordered_date=CURRENT_DATE AND state='Ordered'
			ORDER BY ordered_time DESC LIMIT 0,1);
SET f_orderedTime=(SELECT  ordered_time FROM food_transaction WHERE ordered_id=order_id AND  seat_no=seatno AND ordered_item=f_ordereditem AND ordered_date=CURRENT_DATE AND state='Ordered'
			ORDER BY ordered_time DESC LIMIT 0,1);
SET qty=(SELECT quantity FROM food_transaction WHERE ordered_id=order_id AND  seat_no=seatno AND ordered_item=item AND ordered_date=CURRENT_DATE AND state='Ordered' ORDER BY ordered_time DESC LIMIT 0,1);
SET itemId = (SELECT id FROM menu WHERE food_list=item);
SET itemType = (SELECT food_type FROM menuorder WHERE menu_list=itemId AND food_type IN
		 (SELECT id FROM foodtype WHERE foodtype.`From_time` <=f_orderedTime  AND foodtype.`To_time`>=f_orderedTime ));
		 
SET l_qty=(SELECT quantity FROM menuorder WHERE menu_list=itemId AND food_type=itemType);

IF order_id IN(SELECT ordered_id FROM food_transaction)
THEN
	IF(l_qty<(SELECT quantity FROM foodtype WHERE id=itemType))
	THEN
		START TRANSACTION;
		SET autocommit=0;
		UPDATE food_transaction
		SET quantity=0,state='Cancelled'
		WHERE ordered_id=order_id AND  seat_no=seatno AND ordered_item=f_ordereditem AND ordered_time=f_orderedTime;
		UPDATE menuorder
		SET quantity=quantity+qty
		WHERE menu_list=itemId AND food_type=itemType ;
		SELECT 'Order cancelled sucessfully' INTO cancel_message;
		SELECT cancel_message;
		COMMIT;
	ELSE
		SELECT 'You cant cancel'INTO cancel_message;
		SELECT cancel_message;
		
	END IF;
ELSE
	SELECT 'There is no such order id.' INTO cancel_message;
	SELECT cancel_message;
END IF;
	
END $$
DELIMITER ;





