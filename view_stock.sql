/*Create a View to display the stock details*/
DROP VIEW view_stock

CREATE VIEW view_stock AS
SELECT food_list,TYPE,menuorder.`quantity` FROM menu
JOIN menuorder,foodtype
WHERE menu.`id`=menuorder.`menu_list` AND foodtype.`id`=menuorder.`food_type`
ORDER BY food_list;



SELECT * FROM view_stock