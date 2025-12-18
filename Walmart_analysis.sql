-- =========================================================
-- WALMART SALES & ECONOMIC IMPACT ANALYSIS
-- Author: Ishika Dhoble
-- Tools Used: SQL (Joins, Window Functions, Case Statements)
-- =========================================================

-- STEP 1: Identifying the "Powerhouse" Stores
-- Goal: Find the Top 5 Stores by total revenue to prioritize resources.
SELECT 
    Store, 
    ROUND(SUM(Weekly_Sales), 2) AS Total_Revenue
FROM walmart_sales 
GROUP BY Store 
ORDER BY Total_Revenue DESC 
LIMIT 5;


-- STEP 2: The Holiday Impact Analysis
-- Goal: Determine if holidays drive significantly higher sales.
SELECT 
    CASE 
        WHEN Holiday_Flag = 1 THEN 'Holiday Week'
        ELSE 'Normal Week'
    END AS Week_Type,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Revenue
FROM walmart_sales
GROUP BY Holiday_Flag
ORDER BY Average_Weekly_Revenue DESC;


-- STEP 3: Economic Crisis Correlation
-- Goal: Analyze sales during the highest periods of unemployment.
SELECT 
    Date, 
    Store,
    Unemployment, 
    ROUND(Weekly_Sales, 2) AS Sales_During_High_Unemployment
FROM walmart_sales 
ORDER BY Unemployment DESC 
LIMIT 10;


-- STEP 4: Cumulative Revenue Growth (Window Function)
-- Goal: Track the running total of revenue for Store 1 to see growth over time.
-- This demonstrates advanced SQL proficiency (OVER/PARTITION BY).
SELECT 
    Store,
    Date,
    Weekly_Sales,
    ROUND(SUM(Weekly_Sales) OVER(PARTITION BY Store ORDER BY Date), 2) AS Running_Total_Revenue
FROM walmart_sales
WHERE Store = 1;
