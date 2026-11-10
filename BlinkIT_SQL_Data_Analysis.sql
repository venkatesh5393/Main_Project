--------------------  CREATE DATABASE AND PERFORM INITIAL DATA CHECKS ----------------------
-- CREATE DATABASE BlinkIT_DB;
USE BlinkIT_DB;
-- Check table structure
DESCRIBE blinkit_grocery_data;
-- Check total records
SELECT COUNT(*) AS Total_Rows
From blinkit_grocery_data;
----------- Total Sales Analysis
SELECT
    COUNT(*) AS Total_Items,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(AVG(Total_Sales), 2) AS Average_Sales
FROM blinkit_grocery_clean;

----- Item Performance Analysis
SELECT
    Item_Type,
    COUNT(*) AS Total_Items,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM blinkit_grocery_clean
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

----- Outlet Performance Analysis
SELECT
    Outlet_Type,
    COUNT(*) AS Total_Items,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM blinkit_grocery_clean
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

-------- Outlet Location Analysis
SELECT
    Outlet_Location_Type,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM blinkit_grocery_clean
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

----- Outlet Size Analysis
SELECT
    Outlet_Size,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM blinkit_grocery_clean
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-------- Average Rating Analysis
SELECT
    Outlet_Type,
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM blinkit_grocery_clean
GROUP BY Outlet_Type
ORDER BY Average_Rating DESC;

-------- Fat Content Analysis
SELECT
    Item_Fat_Content,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales,
    ROUND(AVG(Rating), 2) AS Average_Rating
FROM blinkit_grocery_clean
GROUP BY Item_Fat_Content;

-------- Year-wise Outlet Analysis
SELECT
    Outlet_Establishment_Year,
    ROUND(SUM(Total_Sales), 2) AS Total_Sales
FROM blinkit_grocery_clean
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year;






