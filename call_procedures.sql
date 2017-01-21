/*
PROCEDURES:
Place multiple orders------->CALL place_order(seatno,Items,items_quantity,CURRENT_TIME)
Place single order---------->CALL foodOrder(order_id,seatno,Items,items_quantity,CURRENT_TIME);
To cancel order---------->cancel_order(seatno,item)
To add new items-------->add_food(id,item,food_type)


FUNCTIONS:
Function to check seat------->check_seat(seatno)
Function to check item------->check_item(item)
Function to check quantity------->check_quantity(itemId,itemtype,item_quantity)
Function to check serving time------->check_serving(orderedTime)
Function to check item serving time------->check_serving_time(itemType,orderedTime)
Function to check seat status----------->seat_status(seatno)

VIEWS:
To view the stock details----------->SELECT * FROM view_stock
To view order details-------->SELECT * FROM view_order_details
EVENT:
To reset the stock-------->stock_reset event is used
*/

CALL place_order('seat8','Variety Rice,North Indian Thali','2,3',CURRENT_TIME)

CALL cancel_order(184,'seat8','Variety Rice')

CALL add_food(20,'Porattas','Dinner')

SELECT * FROM view_order_details

SELECT * FROM view_stock