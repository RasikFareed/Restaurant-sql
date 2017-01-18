DROP PROCEDURE add_food;
DELIMITER $$
CREATE PROCEDURE add_food(id SMALLINT,item VARCHAR(20),food_type VARCHAR(20))
BEGIN

DECLARE new_foodtype INT;
DECLARE new_menulist INT;
SET autocommit=0;
START TRANSACTION;
INSERT INTO menu VALUES(id,item);

SET new_menulist=(SELECT id FROM menu WHERE foodList=item);
SET new_foodtype=(SELECT foodtype.`id` FROM foodtype WHERE foodtype.`Type`=food_type);

INSERT INTO menuorder(menuList,foodType,quantity)VALUES(new_menulist,new_foodtype,(SELECT quantity FROM foodtype WHERE foodtype.`id`=new_foodtype));
INSERT INTO foodstock(menu_list,food_type,quantity)VALUES(new_menulist,new_foodtype,(SELECT quantity FROM foodtype WHERE foodtype.`id`=new_foodtype));
COMMIT;
END$$
DELIMITER ;

