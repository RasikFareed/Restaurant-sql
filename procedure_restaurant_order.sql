DROP PROCEDURE place_order; 


DELIMITER $$
CREATE PROCEDURE place_order(seatno VARCHAR(20),IN _list1 MEDIUMTEXT,IN _list2 MEDIUMTEXT,order_time TIME,OUT message VARCHAR(200))
  
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
          SELECT rand_no() INTO order_id; 
					

START TRANSACTION;
SET autocommit=0;
          IF LENGTH(TRIM(_list1)) = 0 OR _list1 IS NULL OR LENGTH(TRIM(_list2)) = 0 OR _list2 IS NULL
          THEN
             SELECT 'Invalid Order' INTO message;
             SELECT message;
          ELSE
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
                SELECT 'You can choose only 5 items' INTO message;
                SELECT message;
                ELSE
  /*Call the procedure foodOrder to order the items for requested seats*/ 
		CALL foodOrder(order_id,seatno,_next1,_next2,CURRENT_TIME,@out_message);
		SELECT @out_message INTO message;
		SELECT message;
		
		
                END IF;           
                   SET _list1 = INSERT(_list1,1,_nextlen1 + 1,'');
                   SET _list2 = INSERT(_list2,1,_nextlen2 + 1,'');
                  

         END LOOP; 
       ELSE
       SELECT 'Seat UnAvailable' INTO message;
       SELECT message;
        
	END IF;
	
         UPDATE seat_status
         SET state='Available',concurrent_user_state=FALSE
         WHERE seat_id=(SELECT id FROM seat WHERE Seats=seatno);
       END IF;  
        
  COMMIT;   
    
    
 END $$
DELIMITER ;




