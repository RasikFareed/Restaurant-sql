DELIMITER $$

CREATE PROCEDURE to_insert(seatno VARCHAR(20),IN _list1 MEDIUMTEXT,IN _list2 MEDIUMTEXT,order_time TIME)
    
    BEGIN
          DECLARE _next1 TEXT DEFAULT NULL ;
          DECLARE _nextlen1 INT DEFAULT NULL;
          DECLARE _value1 TEXT DEFAULT NULL;
          DECLARE _next2 TEXT DEFAULT NULL ;
          DECLARE _nextlen2 INT DEFAULT NULL;
          DECLARE _value2 TEXT DEFAULT NULL;
          DECLARE counter INT;
          DECLARE order_id INT;
          SET counter=0;
          SET order_id=(FLOOR(100+RAND()*(900)));
/*Check for seat Availability*/
          IF(seat_status(seatno)=1)
          THEN
          
         UPDATE seat_status
         SET state='UnAvailable'
         WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno);
         
         iterator :
         LOOP    
            IF LENGTH(TRIM(_list1)) = 0 OR _list1 IS NULL OR LENGTH(TRIM(_list2)) = 0 OR _list2 IS NULL THEN
              LEAVE iterator;
              END IF;
  
   
                 SET _next1 = SUBSTRING_INDEX(_list1,',',1);
                 SET _nextlen1 = LENGTH(_next1);
                 SET _value1 = TRIM(_next1);
                 
                 SET _next2 = SUBSTRING_INDEX(_list2,',',1);
                 SET _nextlen2 = LENGTH(_next2);
                 SET _value2 = TRIM(_next2);
  /*Check whether the ordered item is less than 5*/                 
		SET counter=counter+1;
                IF(counter>(SELECT order_limit FROM orderlimit))
                THEN
                SELECT 'You can choose only 5 items' AS message;
                ELSE
  /*Call the procedure foodOrder to order the items for requested seats*/ 
		CALL foodOrder(order_id,seatno,_next1,_next2,CURRENT_TIME);
		DO SLEEP(10);
		SELECT * FROM food_transaction;
		
                END IF;           
                   SET _list1 = INSERT(_list1,1,_nextlen1 + 1,'');
                   SET _list2 = INSERT(_list2,1,_nextlen2 + 1,'');

         END LOOP; 
       ELSE
       SELECT 'Seat UnAvailable' AS message;
        
	END IF;
	
         UPDATE seat_status
         SET state='Available'
         WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno);
              
    END$$
DELIMITER ;

DROP PROCEDURE to_insert

CALL to_insert('seat4','Chapatti,Coffee','3,4',CURRENT_TIME)
