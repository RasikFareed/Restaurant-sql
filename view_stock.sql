/*Create a View to display the stock details*/

CREATE VIEW view_stock AS
SELECT foodList,TYPE,quantity FROM menu
JOIN menuorder,foodtype
WHERE menu.`id`=menuorder.`menuList` AND foodtype.`id`=menuorder.`foodType`
ORDER BY foodlist;

DROP VIEW view_stock

SELECT * FROM view_stock