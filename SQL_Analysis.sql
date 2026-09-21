-- ============================================================
-- E-COMMERCE SALES & PROFITABILITY ANALYSIS
-- SQL Analysis using SQL Server
-- Database: EcommerceSalesAnalysis
-- ============================================================

USE EcommerceSalesAnalysis;
GO


-- ============================================================
-- 1. DATA VALIDATION
-- Purpose:
-- Check the number of records available in both tables.
-- ============================================================

SELECT COUNT(*) AS Total_Orders
FROM Orders;

SELECT COUNT(*) AS Total_Details
FROM Details;


-- ============================================================
-- 2. DATA JOIN
-- Purpose:
-- Combine Orders and Details tables using Order_ID.
-- This allows us to analyse customer, location, sales,
-- profit, quantity, category and payment information together.
-- ============================================================

SELECT TOP 10
    o.Order_ID,
    o.Order_Date,
    o.CustomerName,
    o.State,
    o.City,
    d.Amount,
    d.Profit,
    d.Quantity,
    d.Category,
    d.Sub_Category,
    d.PaymentMode
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID;


-- ============================================================
-- 3. OVERALL BUSINESS KPIs
-- Purpose:
-- Calculate key business metrics:
-- Total Sales, Total Profit, Total Quantity,
-- Total Orders and Total Customers.
-- ============================================================

SELECT
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    COUNT(DISTINCT o.CustomerName) AS Total_Customers
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID;


-- ============================================================
-- 4. MONTHLY SALES & PROFIT ANALYSIS
-- Purpose:
-- Analyse sales and profit month-wise to identify
-- monthly performance and loss-making months.
-- ============================================================

SELECT
    YEAR(o.Order_Date) AS Order_Year,
    MONTH(o.Order_Date) AS Order_Month,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    YEAR(o.Order_Date),
    MONTH(o.Order_Date)
ORDER BY
    Order_Year,
    Order_Month;


-- ============================================================
-- 5. CATEGORY PERFORMANCE ANALYSIS
-- Purpose:
-- Compare sales, profit and quantity across product categories.
-- ============================================================

SELECT
    d.Category,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    d.Category
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 6. SUB-CATEGORY PERFORMANCE ANALYSIS
-- Purpose:
-- Analyse sales, profit and quantity for each sub-category.
-- ============================================================

SELECT
    d.Sub_Category,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    d.Sub_Category
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 7. STATE-WISE SALES & PROFIT ANALYSIS
-- Purpose:
-- Analyse business performance across different states.
-- ============================================================

SELECT
    o.State,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    o.State
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 8. TOP 10 CUSTOMERS BY SALES
-- Purpose:
-- Identify customers generating the highest sales and profit.
-- ============================================================

SELECT TOP 10
    o.CustomerName,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    o.CustomerName
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 9. PAYMENT MODE ANALYSIS
-- Purpose:
-- Compare sales, profit, quantity and orders
-- across different payment methods.
-- ============================================================

SELECT
    d.PaymentMode,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    d.PaymentMode
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 10. CITY-WISE SALES ANALYSIS
-- Purpose:
-- Analyse sales, profit, quantity and order volume
-- across different cities.
-- ============================================================

SELECT
    o.City,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    SUM(d.Quantity) AS Total_Quantity,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    o.City
ORDER BY
    Total_Sales DESC;


-- ============================================================
-- 11. PROFITABILITY STATUS BY SUB-CATEGORY
-- Purpose:
-- Classify each sub-category as Profitable, Loss
-- or Break-even based on total profit.
-- ============================================================

SELECT
    d.Sub_Category,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    CASE
        WHEN SUM(d.Profit) > 0 THEN 'Profitable'
        WHEN SUM(d.Profit) < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS Profit_Status
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    d.Sub_Category
ORDER BY
    Total_Profit DESC;


-- ============================================================
-- 12. SUB-CATEGORY PROFIT RANKING
-- Concepts Used:
-- CTE + RANK() Window Function
--
-- Purpose:
-- Rank sub-categories by profit within each category.
-- ============================================================

WITH SubCategoryProfit AS
(
    SELECT
        d.Category,
        d.Sub_Category,
        SUM(d.Amount) AS Total_Sales,
        SUM(d.Profit) AS Total_Profit
    FROM Orders o
    INNER JOIN Details d
        ON o.Order_ID = d.Order_ID
    GROUP BY
        d.Category,
        d.Sub_Category
)

SELECT
    Category,
    Sub_Category,
    Total_Sales,
    Total_Profit,
    RANK() OVER (
        PARTITION BY Category
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank
FROM SubCategoryProfit
ORDER BY
    Category,
    Profit_Rank;


-- ============================================================
-- 13. CUSTOMER SALES RANKING
-- Concepts Used:
-- CTE + RANK() Window Function
--
-- Purpose:
-- Rank customers according to their total sales.
-- ============================================================

WITH CustomerSales AS
(
    SELECT
        o.CustomerName,
        SUM(d.Amount) AS Total_Sales,
        SUM(d.Profit) AS Total_Profit
    FROM Orders o
    INNER JOIN Details d
        ON o.Order_ID = d.Order_ID
    GROUP BY
        o.CustomerName
)

SELECT
    CustomerName,
    Total_Sales,
    Total_Profit,
    RANK() OVER (
        ORDER BY Total_Sales DESC
    ) AS Sales_Rank
FROM CustomerSales
ORDER BY
    Sales_Rank;


-- ============================================================
-- 14. CATEGORY PROFIT MARGIN ANALYSIS
-- Purpose:
-- Calculate profit margin percentage for each category.
--
-- Formula:
-- Profit Margin = (Total Profit / Total Sales) × 100
-- ============================================================

SELECT
    d.Category,
    SUM(d.Amount) AS Total_Sales,
    SUM(d.Profit) AS Total_Profit,
    ROUND(
        (SUM(d.Profit) * 100.0)
        / NULLIF(SUM(d.Amount), 0),
        2
    ) AS Profit_Margin_Percent
FROM Orders o
INNER JOIN Details d
    ON o.Order_ID = d.Order_ID
GROUP BY
    d.Category
ORDER BY
    Profit_Margin_Percent DESC;


-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================