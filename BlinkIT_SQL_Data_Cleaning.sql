--------------------  CREATE DATABASE AND PERFORM INITIAL DATA CHECKS ----------------------
CREATE DATABASE BlinkIT_DB;
USE BlinkIT_DB;
-- Check table structure
DESCRIBE blinkit_grocery_data;
-- Check total records
SELECT COUNT(*) AS Total_Rows
From blinkit_grocery_data;

-------------------------------- CREATE A CLEANED TABLE ------------------------------------
CREATE TABLE blinkit_grocery_clean AS
SELECT * FROM blinkit_grocery_data;

------------------- Check NULL Values in All Columns ----------------------------------------
SELECT
    COUNT(*) AS Total_Rows,
    SUM(Item_Fat_Content IS NULL) AS Null_Fat_Content,
    SUM(Item_Identifier IS NULL) AS Null_Item_ID,
    SUM(Item_Type IS NULL) AS Null_Item_Type,
    SUM(Outlet_Establishment_Year IS NULL) AS Null_Year,
    SUM(Outlet_Identifier IS NULL) AS Null_Outlet_ID,
    SUM(Outlet_Location_Type IS NULL) AS Null_Location,
    SUM(Outlet_Size IS NULL) AS Null_Outlet_Size,
    SUM(Outlet_Type IS NULL) AS Null_Outlet_Type,
    SUM(Item_Visibility IS NULL) AS Null_Visibility,
    SUM(Item_Weight IS NULL) AS Null_Weight,
    SUM(Total_Sales IS NULL) AS Null_Sales,
	SUM(Rating IS NULL) AS Null_Rating
FROM blinkit_grocery_clean;
--------------------------  Check duplicate records -------------------------------------
SELECT
    Item_Fat_Content, Item_Identifier, Item_Type,
    Outlet_Establishment_Year, Outlet_Identifier,
    Outlet_Location_Type, Outlet_Size, Outlet_Type,
    Item_Visibility, Item_Weight, Total_Sales, Rating,
    COUNT(*) AS Duplicate_Count
FROM blinkit_grocery_clean
GROUP BY
    Item_Fat_Content, Item_Identifier, Item_Type,
    Outlet_Establishment_Year, Outlet_Identifier,
    Outlet_Location_Type, Outlet_Size, Outlet_Type,
    Item_Visibility, Item_Weight, Total_Sales, Rating
HAVING COUNT(*) > 1;

-------------------------------- Check Distinct Categorical Values (identify unique)-------------------
SELECT DISTINCT Item_Fat_Content FROM blinkit_grocery_clean;
SELECT DISTINCT Item_Type FROM blinkit_grocery_clean;
SELECT DISTINCT Outlet_Size FROM blinkit_grocery_clean;
SELECT DISTINCT Outlet_Type FROM blinkit_grocery_clean;
SELECT DISTINCT Outlet_Location_Type FROM blinkit_grocery_clean;

-------------- Standardize Inconsistent Values in Item_Fat_Content Column -----------------------------
UPDATE blinkit_grocery_clean
SET Item_Fat_Content =
    CASE
        WHEN LOWER(TRIM(Item_Fat_Content))
             IN ('lf', 'low fat') THEN 'Low Fat'
        WHEN LOWER(TRIM(Item_Fat_Content))
             IN ('reg', 'regular') THEN 'Regular'
        ELSE Item_Fat_Content
    END;

SELECT Item_Fat_Content, COUNT(*) AS Total_Records
FROM blinkit_grocery_clean
GROUP BY Item_Fat_Content;

------------------------------ Remove Extra Spaces and Unwanted Spaces(Trim) ------------------------------------
--   SELECT * FROM blinkit_grocery_clean
--  WHERE Item_Fat_Content <> TRIM(Item_Fat_Content)

UPDATE blinkit_grocery_clean
SET
    Item_Fat_Content = TRIM(Item_Fat_Content),
    Item_Identifier = TRIM(Item_Identifier),
    Item_Type = TRIM(Item_Type),
    Outlet_Identifier = TRIM(Outlet_Identifier),
    Outlet_Location_Type = TRIM(Outlet_Location_Type),
    Outlet_Size = TRIM(Outlet_Size),
    Outlet_Type = TRIM(Outlet_Type);
    
    ----------------------- Final Validation ------------------------------------------------------
-- Check final row count
SELECT COUNT(*) AS Final_Total_Rows
FROM blinkit_grocery_clean;

-- Check NULLs again (all 12 columns)
SELECT
    SUM(Item_Fat_Content IS NULL) AS Null_Fat_Content,
    SUM(Item_Identifier IS NULL) AS Null_Item_ID,
    SUM(Item_Type IS NULL) AS Null_Item_Type,
    SUM(Outlet_Establishment_Year IS NULL) AS Null_Year,
    SUM(Outlet_Identifier IS NULL) AS Null_Outlet_ID,
    SUM(Outlet_Location_Type IS NULL) AS Null_Location,
    SUM(Outlet_Size IS NULL) AS Null_Outlet_Size,
    SUM(Outlet_Type IS NULL) AS Null_Outlet_Type,
    SUM(Item_Visibility IS NULL) AS Null_Visibility,
    SUM(Item_Weight IS NULL) AS Null_Weight,
    SUM(Total_Sales IS NULL) AS Null_Sales,
    SUM(Rating IS NULL) AS Null_Rating
FROM blinkit_grocery_clean;

-- Preview cleaned data
SELECT *
FROM blinkit_grocery_clean
LIMIT 20;





