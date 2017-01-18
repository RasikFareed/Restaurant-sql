DROP PROCEDURE view_order_details
DELIMITER $$
CREATE PROCEDURE view_order_details (l_order_id INT)
BEGIN
SELECT order_id,foodList FROM order_details
JOIN menu
WHERE order_id=l_order_id AND menu.`id`=order_details.`order_item`
ORDER BY order_id;
END $$
DELIMITER ;


SELECT*FROM order_details
CALL view_order_details(691)


CREATE VIEW view_order_details AS
SELECT order_id,foodList FROM order_details
JOIN menu
WHERE menu.`id`=order_details.`order_item`
ORDER BY order_id;

SELECT * FROM view_order_details