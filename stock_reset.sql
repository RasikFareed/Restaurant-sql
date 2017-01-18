SET GLOBAL event_scheduler = ON ;

/*Create an event to reset the stock every 24 hours*/
DELIMITER $$
CREATE EVENT stock_reset
 ON SCHEDULE  EVERY 1 DAY
 DO BEGIN

UPDATE  menuorder
SET quantity=(CASE
			WHEN foodType=(SELECT id FROM foodtype WHERE TYPE='Breakfast') THEN 100
			WHEN foodType=(SELECT id FROM foodtype WHERE TYPE='Lunch') THEN 75
			WHEN foodType=(SELECT id FROM foodtype WHERE TYPE='Refreshment') THEN 200
			WHEN foodType=(SELECT id FROM foodtype WHERE TYPE='Dinner') THEN 100
			END)
WHERE menuorder.`foodType`IN(1,2,3,4);
 END $$
 
DELIMITER ;
 


 SHOW EVENTS
 SHOW PROCESSLIST
