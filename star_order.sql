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
          SET counter=0;
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
 /*
 */              SET counter=counter+1;
                IF(counter>5)
                THEN
                SELECT 'You can choose only 5 items' AS message;
                ELSE
		CALL foodOrder(seatno,_next1,_next2,order_time);
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

CALL to_insert('seat4','Chapatti','3',CURRENT_TIME)
