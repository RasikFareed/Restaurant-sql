/*Create a View to display the stock details*/
DROP VIEW view_stock

CREATE VIEW view_stock AS
SELECT foodList,TYPE,quantity FROM menu
JOIN menuorder,foodtype
WHERE menu.`id`=menuorder.`menuList` AND foodtype.`id`=menuorder.`foodType`
ORDER BY foodlist;



SELECT * FROM view_stock