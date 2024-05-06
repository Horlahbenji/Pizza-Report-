USE [Pizza DB]

SELECT *
FROM pizza_sales

---- TOTAL REVENUE
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

---- AVERAGE ORDER VALUE
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Average_Order
FROM pizza_sales

---- TOTAL PIZZA SOLD
SELECT SUM(quantity) AS Total_pizza_sold
FROM pizza_sales

---- TOTAL ORDERS
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales

---- AVERAGE PIZZA PER ORDER
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_Per_Order
FROM pizza_sales

---- DAILY TRENDS
SELECT DATENAME(DW, order_date) AS Order_day, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date) 


---- MONTHLY TRENDS
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)  



---- PERCENTAGE PIZZA CATEGORY PER TOTAL SALES
SELECT pizza_category, SUM(total_price) * 100 
/ (SELECT SUM(total_price) FROM pizza_sales)  AS Per_Category_Total_sales
FROM pizza_sales
GROUP BY pizza_category

---- EACH PIZZA CATEGORY TOTAL SALES
SELECT pizza_category, SUM(total_price) AS Total_price, SUM(total_price) * 100 
/ (SELECT SUM(total_price) FROM pizza_sales)  AS Per_Category_Total_sales
FROM pizza_sales
GROUP BY pizza_category

--- ---- EACH PIZZA CATEGORY TOTAL SALES WITH TOTAL SALES FOR JANUARY
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_price, CAST(SUM(total_price) * 100 
/ (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) =1 ) AS DECIMAL (10,2))  AS Per_Category_Total_sales
FROM pizza_sales
WHERE MONTH(order_date) =1
GROUP BY pizza_category

------- EACH PIZZA CATEGORY TOTAL SALES WITH TOTAL SALES
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Per_Category_Total_sales
FROM pizza_sales
GROUP BY pizza_category

---- PERCENTAGE OF SALES PER PIZZA SIZES
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue, CAST(SUM(total_price)  * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Perc_Pizza_Sizes
FROM pizza_sales
GROUP BY pizza_size

---- PERCENTAGE OF SALES PER PIZZA SIZES FOR JANUARY
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue, CAST(SUM(total_price)  * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART (MONTH, order_date)=1) AS DECIMAL(10,2)) AS Perc_Pizza_Sizes
FROM pizza_sales
WHERE DATEPART (MONTH, order_date)=1
GROUP BY pizza_size

---- PERCENTAGE OF SALES PER PIZZA SIZES FOR THE FIRST QUARTER
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue, CAST(SUM(total_price)  * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART (QUARTER, order_date)=1) AS DECIMAL(10,2)) AS Perc_Pizza_Sizes
FROM pizza_sales
WHERE DATEPART (QUARTER, order_date)=1
GROUP BY pizza_size


----- TOP 5 BEST SELLING PIZZA WHEN THE TOTAL REVENUE ARE COMPARED
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_Revenue DESC

----- BOTTOM 5 BEST SELLING PIZZA WHEN THE TOTAL REVENUE ARE COMPARED
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY  Total_Revenue 

----- TOP 5 BEST SELLING PIZZA WHEN THE  TOTAL QUANTITY ARE COMPARED
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC

----- BOTTOM 5 BEST SELLING PIZZA WHEN THE  TOTAL QUANTITY ARE COMPARED
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity

----- TOP 5 BEST SELLING PIZZA WHEN THE  TOTAL ORDER ARE COMPARED
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC

----- BOTTOM 5 BEST SELLING PIZZA WHEN THE  TOTAL ORDER ARE COMPARED
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders 

