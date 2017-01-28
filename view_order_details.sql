DROP PROCEDURE view_order_details;
DELIMITER $$
CREATE PROCEDURE view_order_details (l_order_id INT)
BEGIN
SELECT ordered_id,seat_no,ordered_item,quantity,ordered_time,ordered_date,state FROM food_transaction
WHERE ordered_id=l_order_id
ORDER BY ordered_id;
END $$
DELIMITER ;





CREATE VIEW view_order_details AS
SELECT ordered_id,seat_no,ordered_item,quantity,ordered_time,ordered_date,state FROM food_transaction
ORDER BY ordered_id;

DROP VIEW view_order_details

SELECT * FROM view_order_details