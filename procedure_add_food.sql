DROP PROCEDURE add_food;
DELIMITER $$
CREATE PROCEDURE add_food(id SMALLINT,item VARCHAR(20),foodtype VARCHAR(20))
BEGIN

DECLARE new_foodtype INT;
DECLARE new_menulist INT;
SET autocommit=0;
START TRANSACTION;
INSERT INTO menu VALUES(id,item);

SET new_menulist=(SELECT id FROM menu WHERE food_list=item);
SET new_foodtype=(SELECT foodtype.`id` FROM foodtype WHERE foodtype.`Type`=foodtype);

INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(new_menulist,new_foodtype,(SELECT quantity FROM foodtype WHERE foodtype.`id`=new_foodtype));
INSERT INTO food_stock(id,menu_list,food_type,quantity)VALUES(id,new_menulist,new_foodtype,(SELECT quantity FROM foodtype WHERE foodtype.`id`=new_foodtype));
COMMIT;
END$$
DELIMITER ;

