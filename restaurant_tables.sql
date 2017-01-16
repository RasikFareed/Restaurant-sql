CREATE TABLE `menu` (
  `id` SMALLINT(6) NOT NULL,
  `foodList` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `list` (`foodList`)
)

CREATE TABLE `menuorder` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `menuList` SMALLINT(11) NOT NULL,
  `foodType` SMALLINT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_menulist` (`menuList`),
  KEY `fk_foodtype` (`foodType`),
  CONSTRAINT `fk_foodtype` FOREIGN KEY (`foodType`) REFERENCES `foodtype` (`id`),
  CONSTRAINT `fk_menulist` FOREIGN KEY (`menuList`) REFERENCES `menu` (`id`)
)


CREATE TABLE `seat` (
  `id` SMALLINT(6) NOT NULL,
  `Seats` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Seats` (`Seats`)
)

CREATE TABLE `seat_status` (
  `id` SMALLINT(6) NOT NULL,
  `seat_id` SMALLINT(6) NOT NULL,
  `state` VARCHAR(20) NOT NULL DEFAULT 'Available',
  PRIMARY KEY (`id`),
  KEY `fk_seatstatus` (`seat_id`),
  CONSTRAINT `fk_seatstatus` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`id`)
)

CREATE TABLE `foodtype` (
  `id` SMALLINT(6) NOT NULL,
  `Type` VARCHAR(200) NOT NULL,
  `FromTime` TIME NOT NULL,
  `ToTime` TIME NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Type` (`Type`)
)

CREATE TABLE `food_stock` (
  `id` SMALLINT(6) NOT NULL,
  `menu_list` SMALLINT(6) NOT NULL,
  `food_type` SMALLINT(6) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stock` (`food_type`),
  KEY `fk_menu` (`menu_list`)
)

CREATE TABLE `food_transaction` (
  `id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `seat_no` VARCHAR(20) NOT NULL,
  `ordered_item` VARCHAR(20) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `ordered_time` VARCHAR(20) NOT NULL,
  `state` VARCHAR(20) NOT NULL,
  KEY `id` (`id`)
)

CREATE TABLE `orderlimit` (
  `id` SMALLINT(6) NOT NULL,
  `order_limit` SMALLINT(6) NOT NULL,
  PRIMARY KEY (`id`)
)