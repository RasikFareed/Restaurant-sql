DELIMITER $$

CREATE PROCEDURE stock_details()
BEGIN
SELECT menulist,quantity FROM menuorder;
END $$
DELIMITER ;

CALL stock_details();

CREATE VIEW view_stock AS
SELECT foodList,TYPE,quantity FROM menu
JOIN menuorder,foodtype
WHERE menu.`id`=menuorder.`menuList` AND foodtype.`id`=menuorder.`foodType`
ORDER BY foodlist;

DROP VIEW view_stock

SELECT * FROM view_stock