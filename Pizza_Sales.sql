DROP TABLE IF EXISTS pizza;
CREATE TABLE pizza
(
    pizza_id	int,
	order_id	int,
	pizza_name_id	varchar(100),
	quantity	int,
	order_date	date,
	order_time	time,
	unit_price	decimal(5,3),
	total_price	decimal(5,3),
	pizza_size	varchar(5),
	pizza_category	varchar(100),
	pizza_ingredients	varchar(200),
	pizza_name varchar(200)
);

select * from pizza;

-- 1. The sum of the total price of all pizza orders

Select Sum(total_price) as "Total Revenue"
from pizza;

-- 2. The average amount spent per order

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS "Average Order Value"
FROM pizza;

--3. The sum of the quantities of all pizzas sold.

SELECT SUM(quantity) AS "Total Pizzas Sold" 
FROM pizza;

--4. The total number of orders placed.

SELECT COUNT(DISTINCT order_id) AS "Total Orders" 
FROM pizza;

--5.The average number of pizzas sold per order

Select Cast(Cast(Sum(quantity) as decimal (10,2))/Cast(Count(distinct order_id)as decimal(10,2)) as decimal(10,2)) as "Average Pizzas Sold"
from pizza;

--6. Hourly Trend of Total Pizzas Sold

SELECT Extract(HOUR from order_time) as "Order Hours", SUM(quantity) as "Total Pizzas Sold"
from pizza
group by Extract(HOUR from order_time)
order by 1;

--7. Weekly Trend for Orders

SELECT 
    Extract(WEEK FROM order_date)::INT as "week_number",
    Extract(YEAR FROM order_date)::INT as "year",
    COUNT(DISTINCT order_id) as "total_orders"
from 
    pizza
group by 
    Extract(WEEK FROM order_date),
    Extract(YEAR FROM order_date)
order by 
    year, week_number;

-- 8. Percentage of Sales by Pizza Category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as "Total Revenue",
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) as "Percentage"
FROM pizza
GROUP BY pizza_category;

-- 9. Percentage of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as "Total Revenue",
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) as "Percentage"
FROM pizza
GROUP BY pizza_size
ORDER BY pizza_size;

-- 10. Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as "Total Quantity Sold"
FROM pizza
GROUP BY pizza_category
ORDER BY 2 DESC;

--11. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT pizza_name,SUM(total_price) AS "Total Revenue"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;

--12. Bottom 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS "Total Revenue"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;

--13. Top 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) as "Total Pizza Sold"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;

--14. Bottom 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) as "Total Pizza Sold"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;

-- 15. Top 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;

-- 16. Bottom 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;
