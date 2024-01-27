*/ Explore Pizza Restaurant Sales Dataset */

-- Total Revenue

SELECT SUM(total_price) AS Total_Revenue
FROM PizzaSales

-- Average Order Value

SELECT 
MAX(order_id) AS Total_Orders, SUM(total_price) AS Total_Revenue, SUM(total_price) / max(order_id) AS Avg_Order_Value
FROM PizzaSales

-- Total Pizzas Sold

SELECT SUM(quantity) AS TotalSold
FROM PizzaSales

-- Average Pizzas per Order

SELECT 
CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(MAX(order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Ordered
FROM PizzaSales

-- Daily Trend for Total Orders

SELECT DATENAME(Weekday, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY DATENAME(Weekday, order_date)
ORDER BY total_orders DESC

-- Monthly Trend for Total Orders

SELECT DATENAME(Month, order_date) as order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY DATENAME(Month, order_date)
ORDER BY Total_Orders DESC

-- Percentage of Sales by Pizza Category

SELECT pizza_category, 
SUM(total_price) AS total_sales, Sum(total_price) * 100 / 
(SELECT SUM(total_price) 
FROM PizzaSales
WHERE MONTH(order_date) = 1) AS 'Percent'
FROM PizzaSales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size

SELECT pizza_size, 
SUM(total_price) AS total_sales, SUM(total_price) * 100 / 
(SELECT SUM(total_price) 
FROM PizzaSales) AS 'Percent'
FROM PizzaSales
GROUP BY pizza_size
ORDER BY 'Percent' DESC

-- Total Pizzas Sold by Category

SELECT pizza_category, COUNT(quantity) AS Pizzas_Sold
FROM PizzaSales
GROUP BY pizza_category
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Revenue DESC

-- Bottom 5 Best Sellers by Revenue

SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Revenue ASC

-- Top 5 Best Sellers by Total Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

-- Bottom 5 Best Sellers by Total Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

-- Top 5 Best Sellers by Total Orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 Best Sellers by Total Orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders DESC