/*
========================================================
Customer Performance & Revenue Analysis
Database: PostgreSQL

Purpose:
Analyze customer purchasing behavior, revenue,
high-value orders, and regional performance.

Final grain:
One row per customer.

Key techniques:
- CTEs
- JOINs
- Conditional aggregation
- Window functions
- NTILE
- NULL handling
- Revenue segmentation
========================================================
*/

-- 1. Order-level metrics
-- Grain: one row per order
with order_level_cte as(
	select
		o.orderid,
		sum(od.quantity) as units_purchased,
		coalesce(sum(od.quantity*od.unitprice), 0) as order_revenue	
	from orders as o
	left join order_details as od
		on od.orderid = o.orderid
	group by o.orderid
	),
-- 2. Customer-level product diversity
-- Grain: one row per customer
customer_product_cte as (
	select
		c.customerid,
		count(distinct od.productid) as different_products_purchased
	from customers as c
	left join orders as o
		on o.customerid = c.customerid
	left join order_details as od
		on od.orderid = o.orderid
	group by c.customerid
	),
-- 3. Customer performance metrics
-- Grain: one row per customer
customer_level_cte as(	
	select
		c.customerid,
		c.city,
		c.region,
		count(ol.orderid) as order_count,
		sum(ol.units_purchased) as total_units_purchased,
		cp.different_products_purchased as total_unique_purchases,
		sum(ol.order_revenue) as total_revenue,
		sum(ol.order_revenue)/nullif(count(ol.orderid), 0) as 
			average_order_value,
		count(ol.orderid) filter(where ol.order_revenue > 500) as 
			high_value_order_count,
		round
			(count(ol.orderid) filter(where ol.order_revenue > 500)::numeric/nullif(count(ol.orderid), 0)*100, 
			2) as percentage_of_high_value_orders
	from customers as c
	left join orders as o
		on o.customerid = c.customerid
	left join order_level_cte as ol
		on ol.orderid = o.orderid
	left join customer_product_cte as cp
		on cp.customerid = c.customerid
	group by
		c.customerid,
		c.city,
		c.region,
		cp.different_products_purchased
	)	
select
	customerid,
	city,
	region,
	order_count,
	round(average_order_value, 2) as average_order_value,
	total_units_purchased,
	total_unique_purchases,
	high_value_order_count,
	total_revenue,
	percentage_of_high_value_orders,
	round(
		avg(total_revenue) over(partition by region), 2) as 
		regional_average,
	round(
		total_revenue - avg(total_revenue) over(partition by region), 2) as 
		difference,
	round(
		total_revenue/sum(total_revenue) over(partition by region)*100,
		2) as customer_percentage_contribution,
	ntile(4) over(partition by region order by total_revenue desc) as quartiles,
	(case 
		when total_revenue = 0 then 'no_revenue'
		when total_revenue > 1000 then 'high_value'
		else 'regular'
	end) as customer_status
from customer_level_cte 

