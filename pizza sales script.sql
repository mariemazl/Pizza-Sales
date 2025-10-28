select * from [Pizza Sales Project]..[pizza_sales]
-- Number of rows in the table:
SELECT COUNT(*) AS nombre_lignes
FROM [Pizza Sales Project]..[pizza_sales]

-- Number of columns in the table
SELECT COUNT(*) AS nombre_colonnes
FROM [Pizza Sales Project].INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'pizza_sales';

-- total of revenue:

select SUM(total_price)AS Total_Revenue from [Pizza Sales Project]..[pizza_sales]

-- Averege order value
Select SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value
from [Pizza Sales Project]..[pizza_sales]

-- Total pizza sold
Select SUM(quantity) as Total_Pizza_Sold
from [Pizza Sales Project]..[pizza_sales]

-- Total order
select * from [Pizza Sales Project]..[pizza_sales]

select COUNT( Distinct order_id) as Total_Order
from [Pizza Sales Project]..[pizza_sales]

--Average pizza per order

select SUM(quantity) /COUNT( Distinct order_id) as Avg_Pizza_Per_Order
from [Pizza Sales Project]..[pizza_sales]

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM [Pizza Sales Project]..[pizza_sales]

--Daily trend for total orders : DW mean weekday 
select DATENAME(DW,order_date) as order_day, COUNT( Distinct order_id) as Total_Orders
from [Pizza Sales Project]..[pizza_sales]
group by DATENAME(DW,order_date),--DATEPART(DW, order_date)
--ORDER BY DATEPART(WEEKDAY, order_date)
-- we can order by totals_orders 
--ORDER BY Total_Orders DESC

-- Monthly trend for total orders
select DATENAME(MONTH,order_date) as order_month, COUNT( Distinct order_id) as Total_Orders
from [Pizza Sales Project]..[pizza_sales]
group by DATENAME(MONTH,order_date)--,DATEPART(MONTH, order_date)
--ORDER BY DATEPART(MONTH, order_date)
-- we can order by totals_orders 
ORDER BY Total_Orders DESC

-- trend for total orders by year(just for try the function)
select DATENAME(YEAR,order_date) as order_year, COUNT( Distinct order_id) as Total_Orders
from [Pizza Sales Project]..[pizza_sales]
group by DATENAME(YEAR,order_date)

-- sales by pizza category
select SUM(total_price),pizza_category
from [Pizza Sales Project]..[pizza_sales]
group by pizza_category

-- percentage of sales by pizza category 
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [Pizza Sales Project]..[pizza_sales]) AS DECIMAL(10,2)) AS PCT
FROM [Pizza Sales Project]..[pizza_sales]
GROUP BY pizza_category

--percentage of sales by pizza size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from [Pizza Sales Project]..[pizza_sales]) AS DECIMAL(10,2)) AS PST
FROM [Pizza Sales Project]..[pizza_sales]
GROUP BY pizza_size
ORDER BY PST DESC

-- Top 5 best sellers by total revenue 
select TOP 5 pizza_name, SUM(total_price)AS Total_Revenue
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_Revenue DESC

-- Top 5 best sellers by total quantity

select TOP 5 pizza_name, SUM(quantity)AS Total_quantity
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_quantity DESC

-- Top 5 best sellers by total order

select TOP 5 pizza_name, SUM(Distinct(order_id))AS Total_order
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_order DESC

-- Top 5 bottm sellers by total revenue 
select TOP 5 pizza_name, SUM(total_price)AS Total_Revenue
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_Revenue ASC

-- Top 5 bottm sellers by total quantity

select TOP 5 pizza_name, SUM(quantity)AS Total_quantity
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_quantity ASC

-- Top 5 bottm sellers by total order

select TOP 5 pizza_name, SUM(Distinct(order_id))AS Total_order
FROM [Pizza Sales Project]..[pizza_sales]
group by pizza_name
ORDER BY Total_order ASC