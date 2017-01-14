DELIMITER $$

CREATE PROCEDURE cancel_order(seatno VARCHAR(20),item VARCHAR(20))
BEGIN
DECLARE itemId INT;
DECLARE itemType INT;
DECLARE orderedTime VARCHAR(20);
DECLARE l_qty INT;
DECLARE qty INT;
SET orderedTime=(SELECT ordered_time FROM food_transaction WHERE seat_no=seatno AND ordered_item=item);
SET qty=(SELECT quantity FROM food_transaction WHERE seat_no=seatno AND ordered_item=item);
SET itemId = (SELECT id FROM menu WHERE foodlist=item);
SET itemType = (SELECT foodType FROM menuorder WHERE menuList=itemId AND foodtype IN
		 (SELECT id FROM foodtype WHERE foodtype.`FromTime` <=orderedTime  AND foodtype.`ToTime`>=orderedTime ));
		 
SET l_qty=(SELECT quantity FROM menuorder WHERE menuList=itemId AND foodType=itemType);
IF(l_qty<(SELECT quantity FROM foodtype WHERE id=itemType))
THEN
UPDATE food_transaction
SET quantity=0,state='Cancelled'
WHERE seat_no=seatno AND ordered_item=item AND ordered_time=orderedTime;
UPDATE menuorder
SET quantity=quantity+qty
WHERE menuList=itemId AND foodType=itemType ;
SELECT 'Order cancelled sucessfully' AS message;
END IF;
END $$
DELIMITER ;

DROP PROCEDURE cancel_order
CALL cancel_order('seat4','Coffee')