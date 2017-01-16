DELIMITER $$
CREATE TRIGGER stock_log AFTER INSERT ON menuorder

FOR EACH ROW BEGIN  

INSERT INTO food_stock SELECT * FROM menuorder WHERE id = menuorder.`id`;

END $$
DELIMITER ;

TRUNCATE TABLE food_stock;
DROP TRIGGER stock_log;