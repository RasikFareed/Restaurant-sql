CREATE TABLE menu (
  id SMALLINT(6) NOT NULL,
  foodList VARCHAR(20) UNIQUE NOT NULL ,
  PRIMARY KEY (id)
)

CREATE TABLE menuorder (
  id SMALLINT(6) NOT NULL AUTO_INCREMENT,
  menuList SMALLINT(11) NOT NULL,
  foodType SMALLINT(11) NOT NULL,
  quantity INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_foodtype FOREIGN KEY (foodType) REFERENCES foodtype (id),
  CONSTRAINT fk_menulist FOREIGN KEY (menuList) REFERENCES menu (id)
)


CREATE TABLE seat (
  id SMALLINT(6) NOT NULL,
  Seats VARCHAR(20) UNIQUE NOT NULL,
  PRIMARY KEY (id)
)

CREATE TABLE seat_status (
  id SMALLINT(6) NOT NULL,
  seat_id SMALLINT(6) NOT NULL,
  state VARCHAR(20) NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`id`),
  CONSTRAINT fk_seatstatus FOREIGN KEY (seat_id) REFERENCES seat (id)
)

CREATE TABLE foodtype (
  id SMALLINT(6) NOT NULL,
  TYPE VARCHAR(200) UNIQUE NOT NULL,
  FromTime TIME NOT NULL,
  ToTime TIME NOT NULL,
  quantity INT(11) NOT NULL,
  PRIMARY KEY (`id`)
)

CREATE TABLE food_stock (
  id SMALLINT(6) NOT NULL,
  menu_list SMALLINT(6) NOT NULL,
  food_type SMALLINT(6) NOT NULL,
  quantity INT(11) NOT NULL,
  PRIMARY KEY (id)
)

CREATE TABLE food_transaction (
  id SMALLINT(6) NOT NULL AUTO_INCREMENT,
  seat_no VARCHAR(20) NOT NULL,
  ordered_item VARCHAR(20) NOT NULL,
  quantity INT(11) NOT NULL,
  ordered_time VARCHAR(20) NOT NULL,
  state VARCHAR(20) NOT NULL
)

CREATE TABLE orderlimit (
  id SMALLINT(6) NOT NULL,
  order_limit SMALLINT(6) NOT NULL,
  PRIMARY KEY (id)
)


INSERT INTO foodtype(id,TYPE,FromTime,ToTime,quantity) VALUES(1,'Breakfast','08:00:00','11:00:00',100);
INSERT INTO foodtype(id,TYPE,FromTime,ToTime,quantity) VALUES(1,'Lunch','11:15:00','15:00:00',100);
INSERT INTO foodtype(id,TYPE,FromTime,ToTime,quantity) VALUES(1,'Refreshment','15:15:00','23:00:00',100);
INSERT INTO foodtype(id,TYPE,FromTime,ToTime,quantity) VALUES(1,'Dinner','19:00:00','23:00:00',100);




INSERT INTO menu(id,foodList)VALUES(1,'Idly');
INSERT INTO menu(id,foodList)VALUES(2,'Vada');
INSERT INTO menu(id,foodList)VALUES(3,'Dosa');
INSERT INTO menu(id,foodList)VALUES(4,'Poori');
INSERT INTO menu(id,foodList)VALUES(5,'Pongal');
INSERT INTO menu(id,foodList)VALUES(6,'Coffee');
INSERT INTO menu(id,foodList)VALUES(7,'Tea');
INSERT INTO menu(id,foodList)VALUES(8,'South Indian Meals');
INSERT INTO menu(id,foodList)VALUES(9,'North Indian Thali');
INSERT INTO menu(id,foodList)VALUES(10,'Variety Rice');
INSERT INTO menu(id,foodList)VALUES(11,'Snacks');
INSERT INTO menu(id,foodList)VALUES(12,'Fried Rice');
INSERT INTO menu(id,foodList)VALUES(13,'Chapatti');
INSERT INTO menu(id,foodList)VALUES(14,'Chat Items');


INSERT INTO menuorder(menuList,foodType,quantity)VALUES(1,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(2,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(3,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(4,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(5,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(6,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(7,1,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(8,2,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(9,2,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(10,2,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(11,3,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(12,3,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(13,3,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(14,4,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(15,4,100);
INSERT INTO menuorder(menuList,foodType,quantity)VALUES(16,4,100);


INSERT INTO seat(id,Seats)VALUES(1,'seat1');
INSERT INTO seat(id,Seats)VALUES(2,'seat1');
INSERT INTO seat(id,Seats)VALUES(3,'seat1');
INSERT INTO seat(id,Seats)VALUES(4,'seat1');
INSERT INTO seat(id,Seats)VALUES(5,'seat1');
INSERT INTO seat(id,Seats)VALUES(6,'seat1');
INSERT INTO seat(id,Seats)VALUES(7,'seat1');
INSERT INTO seat(id,Seats)VALUES(8,'seat1');
INSERT INTO seat(id,Seats)VALUES(9,'seat1');
INSERT INTO seat(id,Seats)VALUES(10,'seat1');


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


INSERT INTO orderlimit(id,order_limit)VALUES(1,5);