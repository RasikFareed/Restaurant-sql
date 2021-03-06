CREATE TABLE menu (
  id SMALLINT NOT NULL,AUTO_INCREMENT,
  food_list VARCHAR(20) UNIQUE NOT NULL ,
  PRIMARY KEY (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE menuorder (
  id SMALLINT NOT NULL AUTO_INCREMENT,
  menu_list SMALLINT NOT NULL,
  food_type SMALLINT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_foodtype FOREIGN KEY (food_type) REFERENCES foodtype (id),
  CONSTRAINT fk_menulist FOREIGN KEY (menu_list) REFERENCES menu (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE seat (
  id SMALLINT NOT NULL,
  Seats VARCHAR(20) UNIQUE NOT NULL,
  PRIMARY KEY (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE seat_status (
  id SMALLINT NOT NULL,
  seat_id SMALLINT NOT NULL,
  state VARCHAR(20) NOT NULL DEFAULT 'Available',
  concurrent_user_state TINYINT NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  CONSTRAINT fk_seatstatus FOREIGN KEY (seat_id) REFERENCES seat (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE foodtype (
  id SMALLINT NOT NULL,
  TYPE VARCHAR(20) UNIQUE NOT NULL,
  From_time TIME NOT NULL,
  To_time TIME NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE food_stock (
  id SMALLINT NOT NULL,
  menu_list SMALLINT NOT NULL,
  food_type SMALLINT NOT NULL,
  quantity INT NOT NULL,
  PRIMARY KEY (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE food_transaction (
  id SMALLINT NOT NULL AUTO_INCREMENT,
  ordered_id INT NOT NULL,
  seat_no VARCHAR(20) NOT NULL,
  ordered_item VARCHAR(20) NOT NULL,
  quantity INT NOT NULL,
  ordered_time VARCHAR(20) NOT NULL,
  ordered_date DATE NOT NULL,
  state VARCHAR(20) NOT NULL,
) 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE orderlimit (
  id SMALLINT NOT NULL,
  order_limit SMALLINT NOT NULL,
  PRIMARY KEY (id)
)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE order_details (
  id SMALLINT() NOT NULL AUTO_INCREMENT,
  order_id INT() NOT NULL,
  seat_id SMALLINT() NOT NULL,
  order_item SMALLINT() NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_orderid FOREIGN KEY (order_item) REFERENCES menu (id),
  CONSTRAINT fk_seatid FOREIGN KEY (seat_id) REFERENCES seat (id)
)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO foodtype(id,TYPE,From_time,To_time,quantity) VALUES(1,'Breakfast','08:00:00','11:00:00',100);
INSERT INTO foodtype(id,TYPE,From_time,To_time,quantity) VALUES(1,'Lunch','11:15:00','15:00:00',100);
INSERT INTO foodtype(id,TYPE,From_time,To_time,quantity) VALUES(1,'Refreshment','15:15:00','23:00:00',100);
INSERT INTO foodtype(id,TYPE,From_time,To_time,quantity)VALUES(1,'Dinner','19:00:00','23:00:00',100);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO menu(food_list)VALUES('Idly');
INSERT INTO menu(food_list)VALUES('Vada');
INSERT INTO menu(food_list)VALUES('Dosa');
INSERT INTO menu(food_list)VALUES('Poori');
INSERT INTO menu(food_list)VALUES('Pongal');
INSERT INTO menu(food_list)VALUES('Coffee');
INSERT INTO menu(food_list)VALUES('Tea');
INSERT INTO menu(food_list)VALUES('South Indian Meals');
INSERT INTO menu(food_list)VALUES('North Indian Thali');
INSERT INTO menu(food_list)VALUES('Variety Rice');
INSERT INTO menu(food_list)VALUES('Snacks');
INSERT INTO menu(food_list)VALUES('Fried Rice');
INSERT INTO menu(food_list)VALUES('Chapatti');
INSERT INTO menu(food_list)VALUES('Chat Items');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(1,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(2,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(3,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(4,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(5,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(6,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(7,1,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(8,2,75);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(9,2,75);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(10,2,75);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(11,3,200);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(12,3,200);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(13,3,200);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(14,4,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(15,4,100);
INSERT INTO menuorder(menu_list,food_type,quantity)VALUES(16,4,100);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO seat(id,Seats)VALUES(1,'seat1');
INSERT INTO seat(id,Seats)VALUES(2,'seat2');
INSERT INTO seat(id,Seats)VALUES(3,'seat3');
INSERT INTO seat(id,Seats)VALUES(4,'seat4');
INSERT INTO seat(id,Seats)VALUES(5,'seat5');
INSERT INTO seat(id,Seats)VALUES(6,'seat6');
INSERT INTO seat(id,Seats)VALUES(7,'seat7');
INSERT INTO seat(id,Seats)VALUES(8,'seat8');
INSERT INTO seat(id,Seats)VALUES(9,'seat9');
INSERT INTO seat(id,Seats)VALUES(10,'seat10');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO seat_status(id,seat_id,state)VALUES(1,1,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(2,2,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(3,3,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(4,4,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(5,5,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(6,6,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(7,7,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(8,8,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(9,9,'Available');
INSERT INTO seat_status(id,seat_id,state)VALUES(10,10,'Available');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO orderlimit(id,order_limit)VALUES(1,5);