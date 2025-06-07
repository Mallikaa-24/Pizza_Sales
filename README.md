# Pizza Sales Dashboard (Tableau + SQL Project)

![SQL + Tableu](https://github.com/Mallikaa-24/Pizza_Sales/blob/main/SQL%2BTableau.jpg)

## Overview
This project involves a comprehensive analysis of pizza sales data using PostgreSQL and Tableau. The goal is to extract meaningful business insights by first performing data cleaning and transformation using SQL, followed by dynamic visualization in Tableau. The project demonstrates the end-to-end process of data preparation, analysis, and dashboard creation to support informed business decision-making.The following README provides a detailed account of the project's objectives, business problems, SQL queries, Tableau dashboards, findings, and conclusions.

## Objectives
- Understand customer ordering patterns by day and time.
- Identify best- and worst-performing pizzas.
- Analyze sales by category and size.
- Track monthly revenue trends.
- Support decision-making for inventory and marketing strategies.

## Schema

```sql
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
```

## Key Metrics
The objective is to analyze key performance indicators within the pizza sales data to derive actionable insights into overall business performance.

### 1. The sum of the total price of all pizza orders

```sql
Select Sum(total_price) as "Total Revenue"
from pizza;
```

### 2. The average amount spent per order

```sql
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS "Average Order Value"
FROM pizza;
```

### 3. The sum of the quantities of all pizzas sold.

```sql
SELECT SUM(quantity) AS "Total Pizzas Sold" 
FROM pizza;
```

### 4. The total number of orders placed.

```sql
SELECT COUNT(DISTINCT order_id) AS "Total Orders" 
FROM pizza;
```

### 5.The average number of pizzas sold per order

```sql
Select Cast(Cast(Sum(quantity) as decimal (10,2))/Cast(Count(distinct order_id)as decimal(10,2)) as decimal(10,2)) as "Average Pizzas Sold"
from pizza;
```

## Key Trends
The goal is to visualize various aspects of the pizza sales data to uncover insights and identify key trends.

### 6. Hourly Trend of Total Pizzas Sold

```sql
SELECT Extract(HOUR from order_time) as "Order Hours", SUM(quantity) as "Total Pizzas Sold"
from pizza
group by Extract(HOUR from order_time)
order by 1;
```

### 7. Weekly Trend for Orders

```sql
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
```

### 8. Percentage of Sales by Pizza Category

```sql
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as "Total Revenue",
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) as "Percentage"
FROM pizza
GROUP BY pizza_category;
```

### 9. Percentage of Sales by Pizza Size

```sql
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as "Total Revenue",
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza) AS DECIMAL(10,2)) as "Percentage"
FROM pizza
GROUP BY pizza_size
ORDER BY pizza_size;
```

### 10. Total Pizzas Sold by Pizza Category

```sql
SELECT pizza_category, SUM(quantity) as "Total Quantity Sold"
FROM pizza
GROUP BY pizza_category
ORDER BY 2 DESC;
```

### 11. Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

```sql
SELECT pizza_name,SUM(total_price) AS "Total Revenue"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;
```

### 12. Bottom 5 Pizzas by Revenue

```sql
SELECT pizza_name, SUM(total_price) AS "Total Revenue"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;
```

### 13. Top 5 Pizzas by Quantity

```sql
SELECT pizza_name, SUM(quantity) as "Total Pizza Sold"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;
```

### 14. Bottom 5 Pizzas by Quantity

```sql
SELECT pizza_name, SUM(quantity) as "Total Pizza Sold"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;
```

### 15. Top 5 Pizzas by Total Orders

```sql
SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC limit 5;
```

### 16. Bottom 5 Pizzas by Total Orders

```sql
SELECT pizza_name, COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza
GROUP BY pizza_name
ORDER BY 2 ASC limit 5;
```

## Dashboard Features
![Dashboard1](https://github.com/Mallikaa-24/Pizza_Sales/blob/main/Dashboard1.png)) ![Dashboard2](https://github.com/Mallikaa-24/Pizza_Sales/blob/main/Dashboard2.png))

- Key Metrics (Total Revenue, Total Orders, Avg Order Value)
- Hourly Orders (Line chart showing peak order times)
- Weekday Sales Distribution
- Monthly Sales Trend
- Sales by Pizza Category & Size
- Top 5 and Bottom 5 Pizzas

## Findings and Conclusions 
- Peak order times are during the evening (6 PM – 8 PM), ideal for promotions.
- Weekends show higher sales, especially Saturdays.
- Classic and Supreme categories generate the most revenue.
- Certain pizza types (e.g., Brie Carre) consistently underperform and could be re-evaluated.
- Order value and sales volume tend to peak in November and December, suggesting seasonal trends.

This analysis offers a comprehensive overview of pizza sales performance and can support data-driven decision-making in areas such as inventory management, marketing strategy, and operational efficiency.


