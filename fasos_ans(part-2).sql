## 7. For each customer, how many delivered rolls had at least 1 change and how many had no changes ?
#for changes we will consider columns like not_include_items & extra_items_included
#also we need to do some data cleaning also like removing null & nan values & so on...
#we need to substitute the empty, nan & null values with 0 by creating a temprory table to do later queries

WITH temp_customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date) as 
( SELECT order_id,customer_id,roll_id, 
 CASE WHEN not_include_items IS null OR not_include_items='' THEN 0 ELSE not_include_items end as new_not_include_items, 
 CASE WHEN extra_items_included IS null OR extra_items_included=''or extra_items_included='NaN' THEN 0 ELSE extra_items_included end as new_extra_items_included, 
 order_date FROM customer_orders ) 
 SELECT * FROM temp_customer_orders;
 
 #also we are making some changes in driver order table to remove null values
# for now we are making changes in cancellation column of driver table
### 
WITH temp_driver_order(order_id,driver_id,pickup_time,distance,duration,cancellation) as 
( SELECT order_id,driver_id,pickup_time,distance,duration, 
CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation 
FROM driver_order ) 
SELECT * FROM temp_driver_order;

# as you can see that the order which is cancelled are marked as 0 & all the others are marked as 1
# now move on to our real question
#first of all we are finding the sucesuflly delivered orders
### 
WITH temp_driver_order(order_id,driver_id,pickup_time,distance,duration,new_cancellation) as ( SELECT order_id,driver_id,pickup_time,distance,duration, CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation FROM driver_order ) 

SELECT * FROM temp_driver_order WHERE new_cancellation!=0;

#now move on to further step, how many delivered rolls had at least 1 change
### 
WITH temp_customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date) as ( SELECT order_id,customer_id,roll_id, CASE WHEN not_include_items IS null OR not_include_items='' THEN 0 ELSE not_include_items end as new_not_include_items, CASE WHEN extra_items_included IS null OR extra_items_included=''or extra_items_included='NaN' THEN 0 ELSE extra_items_included end as new_extra_items_included, order_date FROM customer_orders ),

temp_driver_order(order_id,driver_id,pickup_time,distance,duration,new_cancellation) as ( SELECT order_id,driver_id,pickup_time,distance,duration, CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation FROM driver_order )

SELECT *,CASE WHEN not_include_items=0 AND extra_items_included=0 THEN 'no change' ELSE 'change' END chg_no_chg FROM temp_customer_orders WHERE order_id in(
SELECT order_id FROM temp_driver_order WHERE new_cancellation!=0);

# as we can see a new column of showing change, now we just need to count the column which had value change
### 
WITH temp_customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date) as ( SELECT order_id,customer_id,roll_id, CASE WHEN not_include_items IS null OR not_include_items='' THEN 0 ELSE not_include_items end as new_not_include_items, CASE WHEN extra_items_included IS null OR extra_items_included=''or extra_items_included='NaN' THEN 0 ELSE extra_items_included end as new_extra_items_included, order_date FROM customer_orders ),

temp_driver_order(order_id,driver_id,pickup_time,distance,duration,new_cancellation) as ( SELECT order_id,driver_id,pickup_time,distance,duration, CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation FROM driver_order )

SELECT customer_id, chg_no_chg,count(order_id) FROM(
SELECT *,CASE WHEN not_include_items=0 AND extra_items_included=0 THEN 'no change' ELSE 'change' END chg_no_chg FROM temp_customer_orders WHERE order_id in( SELECT order_id FROM temp_driver_order WHERE new_cancellation!=0))a
GROUP BY customer_id, chg_no_chg;

## 8. How many rolls were delivered that had both exculsions & extras ?
#as the question is somewhat similar to above question, we are using the same query, just making some changes at the ending part
### 
WITH temp_customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date) as ( SELECT order_id,customer_id,roll_id, CASE WHEN not_include_items IS null OR not_include_items='' THEN 0 ELSE not_include_items end as new_not_include_items, CASE WHEN extra_items_included IS null OR extra_items_included=''or extra_items_included='NaN' THEN 0 ELSE extra_items_included end as new_extra_items_included, order_date FROM customer_orders ),

temp_driver_order(order_id,driver_id,pickup_time,distance,duration,new_cancellation) as ( SELECT order_id,driver_id,pickup_time,distance,duration, CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation FROM driver_order )

 SELECT *,CASE WHEN not_include_items!=0 AND extra_items_included!=0 THEN 'both incl & excl' ELSE 'at least one of them incl or excl' END chg_no_chg FROM temp_customer_orders WHERE order_id in( SELECT order_id FROM temp_driver_order WHERE new_cancellation!=0);
 
 #now we just need to count the total number of data as shown below
 ### 
WITH temp_customer_orders(order_id,customer_id,roll_id,not_include_items,extra_items_included,order_date) as ( SELECT order_id,customer_id,roll_id, CASE WHEN not_include_items IS null OR not_include_items='' THEN 0 ELSE not_include_items end as new_not_include_items, CASE WHEN extra_items_included IS null OR extra_items_included=''or extra_items_included='NaN' THEN 0 ELSE extra_items_included end as new_extra_items_included, order_date FROM customer_orders ),

temp_driver_order(order_id,driver_id,pickup_time,distance,duration,new_cancellation) as ( SELECT order_id,driver_id,pickup_time,distance,duration, CASE WHEN cancellation in ('Cancellation','Customer Cancellation') THEN 0 ELSE 1 end AS new_cancellation FROM driver_order )

SELECT chg_no_chg,COUNT(chg_no_chg) FROM
(SELECT *,CASE WHEN not_include_items!=0 AND extra_items_included!=0 THEN 'both incl & excl' ELSE 'at least one of them incl or excl' END chg_no_chg FROM temp_customer_orders WHERE order_id in( SELECT order_id FROM temp_driver_order WHERE new_cancellation!=0))a
GROUP BY chg_no_chg;
 


 