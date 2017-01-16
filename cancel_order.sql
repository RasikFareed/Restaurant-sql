
DELIMITER $$

CREATE PROCEDURE cancel_order(seatno VARCHAR(20),item VARCHAR(20))
BEGIN
DECLARE itemId INT;
DECLARE itemType INT;
DECLARE f_orderedTime VARCHAR(20);
DECLARE l_qty INT;
DECLARE qty INT;
DECLARE f_ordereditem VARCHAR(20);

SET f_ordereditem=(SELECT  ordered_item FROM food_transaction WHERE seat_no=seatno AND ordered_item=item
		ORDER BY ordered_time DESC LIMIT 0,1);
SET f_orderedTime=(SELECT  ordered_time FROM food_transaction WHERE seat_no=seatno AND ordered_item=f_ordereditem
		ORDER BY ordered_time DESC LIMIT 0,1);
SET qty=(SELECT quantity FROM food_transaction WHERE seat_no=seatno AND ordered_item=item ORDER BY ordered_time DESC LIMIT 0,1);
SET itemId = (SELECT id FROM menu WHERE foodlist=item);
SET itemType = (SELECT foodType FROM menuorder WHERE menuList=itemId AND foodtype IN
		 (SELECT id FROM foodtype WHERE foodtype.`FromTime` <=f_orderedTime  AND foodtype.`ToTime`>=f_orderedTime ));
		 
SET l_qty=(SELECT quantity FROM menuorder WHERE menuList=itemId AND foodType=itemType);
IF(l_qty<(SELECT quantity FROM foodtype WHERE id=itemType))
THEN
UPDATE food_transaction
SET quantity=0,state='Cancelled'
WHERE seat_no=seatno AND ordered_item=f_ordereditem AND ordered_time=f_orderedTime;
UPDATE menuorder
SET quantity=quantity+qty
WHERE menuList=itemId AND foodType=itemType ;
SELECT 'Order cancelled sucessfully' AS message;
END IF;
END $$
DELIMITER ;

DROP PROCEDURE cancel_order
CALL cancel_order('seat4','Idly')



