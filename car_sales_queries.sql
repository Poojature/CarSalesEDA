-- ================================================
-- EDA on Car Sales Dataset - SQL Queries
-- Tool: MySQL | Author: Pooja Ture
-- ================================================

USE car_sales_db;

-- ------------------------------------------------
-- Query 1: Top 5 Best Selling Manufacturers
-- Concepts: GROUP BY, SUM, ORDER BY, LIMIT
-- ------------------------------------------------
SELECT Manufacturer, ROUND(SUM(Sales_in_thousands),2) AS Total_Sales
FROM car_sales
GROUP BY Manufacturer
ORDER BY Total_Sales DESC
LIMIT 5;

-- ------------------------------------------------
-- Query 2: Average Price by Vehicle Type
-- Concepts: GROUP BY, AVG, HAVING
-- ------------------------------------------------
SELECT Vehicle_type, ROUND(AVG(Price_in_thousands),2) AS Avg_Price
FROM car_sales
GROUP BY Vehicle_type
HAVING Avg_Price > 20;

-- ------------------------------------------------
-- Query 3: Most Fuel Efficient Car
-- Concepts: Subquery, MAX
-- ------------------------------------------------
SELECT Manufacturer, Model, Fuel_efficiency
FROM car_sales
WHERE Fuel_efficiency = (SELECT MAX(Fuel_efficiency) FROM car_sales);

-- ------------------------------------------------
-- Query 4: Rank Cars by Sales Within Each Manufacturer
-- Concepts: Window Function, RANK(), PARTITION BY
-- ------------------------------------------------
SELECT Manufacturer, Model, Sales_in_thousands,
       RANK() OVER (PARTITION BY Manufacturer 
       ORDER BY Sales_in_thousands DESC) AS Sales_Rank
FROM car_sales;

-- ------------------------------------------------
-- Query 5: Cars Priced Above Average
-- Concepts: Subquery, AVG
-- ------------------------------------------------
SELECT Manufacturer, Model, Price_in_thousands
FROM car_sales
WHERE Price_in_thousands > (SELECT AVG(Price_in_thousands) FROM car_sales)
ORDER BY Price_in_thousands DESC;

-- ------------------------------------------------
-- Query 6: Value Retention by Car (Price vs Resale)
-- Concepts: Calculated Column, WHERE, ORDER BY
-- ------------------------------------------------
SELECT Manufacturer, Model,
       Price_in_thousands,
       Year_resale_value,
       ROUND((Year_resale_value / Price_in_thousands) * 100, 1) AS Retention_Pct
FROM car_sales
WHERE Year_resale_value IS NOT NULL
ORDER BY Retention_Pct DESC;