 use supply_db;
 
 
 /* 1. Get the number of orders by the Type of Transaction. Please exclude orders shipped from Sangli and Srinagar. 
 Also, exclude the SUSPECTED_FRAUD cases based on the Order Status. 
 Sort the result in the descending order based on the number of orders.
*/
SELECT 
        type,
        count(Order_Id) AS no_orders
FROM    
	orders
WHERE      
	Order_City NOT IN ('SANGLI','SRINAGAR')
       AND 
	Order_Status NOT IN ('SUSPECTED_FRAUD')
GROUP BY   
       type
ORDER BY   
      no_orders   DESC;

/* 2. Get the order count by the Shipping Mode and the Department Name. 
Consider departments with at least 40 closed/completed orders.
*/
SELECT 
      ID,
      First_Name,
      City,
      State,
      COUNT(o.order_id) AS no_comp_orders,
      SUM(sales) AS Total_sales
FROM  
     customer_info c
JOIN  
     Orders o
ON    
    c.ID = o.Customer_Id
JOIN  
	ordered_items oi
ON    
    o.order_id = oi.order_id
WHERE 
    order_status = 'Complete'
GROUP BY 
         Id,
		 First_Name,
         City,
         STATE
ORDER BY 
		no_comp_orders DESC,
		Total_sales DESC LIMIT 3;
         
         
 /* 3. Get the order count by the Shipping Mode and the Department Name. 
 Consider departments with at least 40 closed/completed orders.*/
 
 SELECT 
        Shipping_Mode, 
        d.Name as Department,
         COUNT(distinct o.Order_Id) as no_of_orders
FROM    
     orders o
JOIN    
     ordered_items oi
ON      
     o.Order_Id = oi.Order_Id
JOIN    
     product_info pi
ON   
     oi.Item_id = pi.Product_Id
JOIN    
     department d
ON      
     pi.Department_Id = d.ID
WHERE
	 order_status in ('Complete', 'Closed') 	  
GROUP BY 
		Shipping_Mode, 
        d.Name
HAVING 
      no_of_orders > 40 
ORDER BY 
       no_of_orders desc;
       

/* 4. Create a new field as shipment compliance based on Real_Shipping_Days and Scheduled_Shipping_Days. 
It should have the following values:
Cancelled shipment - If the Order Status is SUSPECTED_FRAUD or CANCELED
Within schedule - If shipped within the scheduled number of days 
On time - If shipped exactly as per schedule
Upto 2 days of delay - If shipped beyond schedule but delay upto 2 days
Beyond 2 days of delay - If shipped beyond schedule with delay beyond 2 days

Which shipping mode was observed to have the greatest number of delayed orders?
*/

  WITH ship_compliance  AS 
  ( SELECT 
       order_id,
    CASE 
        WHEN Order_Status IN ('SUSPECTED_FRAUD', 'CANCELED') THEN 'Cancelled shipment'
        WHEN Real_Shipping_Days = Scheduled_Shipping_Days THEN 'On time'
        WHEN Real_Shipping_Days < Scheduled_Shipping_Days THEN 'Within schedule'
        WHEN Real_Shipping_Days > Scheduled_Shipping_Days AND Real_Shipping_Days - Scheduled_Shipping_Days <= 2 THEN 'Upto 2 days of delay'
        WHEN Real_Shipping_Days - Scheduled_Shipping_Days > 2 THEN 'Beyond 2 days of delay'
        ELSE 'Unknown' 
    END AS 
          shipment_compliance
    
FROM 
    orders) 

SELECT 
       shipping_mode,
       COUNT(s.order_id) AS DELAYED_ORDERS
	FROM 
         ship_compliance s
    JOIN  
         orders o
    ON 
	   s.order_id = o.order_id
    Where 
          shipment_compliance IN ('Upto 2 days of delay', 'Beyond 2 days of delay' )
    GROUP BY 
            shipping_mode
    ORDER BY 
           DELAYED_ORDERS DESC;
       



/* 5.An order is cancelled when the status of the order is either cancelled or SUSPECTED_FRAUD.
 Obtain the list of states by the order cancellation % and sort them in the descending order of the cancellation % 
Definition: Cancellation % = Cancelled orders / Total Orders
*/
SELECT 
    Order_State, 
    COUNT(CASE WHEN Order_Status IN ('CANCELED', 'SUSPECTED_FRAUD') THEN Order_Id END) AS Cancelled_Orders,
    COUNT(Order_Id) AS Total_Orders,
    (COUNT(CASE WHEN Order_Status IN ('CANCELED', 'SUSPECTED_FRAUD') THEN Order_Id END) / COUNT(Order_Id) * 100) AS Cancellation_Percentage
FROM 
    orders 
GROUP BY 
    Order_State
ORDER BY 
    Cancellation_Percentage DESC;
   
