--Q14 COMPARISON OF QUARTER BY SALES AND CATEGORIES
SELECT
    YEAR(Order_Date) AS Sales_Year,
    SUM(CASE WHEN MONTH(Order_Date) BETWEEN 1  AND 3  THEN Total_Amount ELSE 0 END) AS Q1_Sales,
    SUM(CASE WHEN MONTH(Order_Date) BETWEEN 4  AND 6  THEN Total_Amount ELSE 0 END) AS Q2_Sales,
    SUM(CASE WHEN MONTH(Order_Date) BETWEEN 7  AND 9  THEN Total_Amount ELSE 0 END) AS Q3_Sales,
    SUM(CASE WHEN MONTH(Order_Date) BETWEEN 10 AND 12 THEN Total_Amount ELSE 0 END) AS Q4_Sales
FROM Fact_Sales
GROUP BY YEAR(Order_Date)
ORDER BY Sales_Year;

SELECT
    p.Category,
    SUM(CASE WHEN MONTH(f.Order_Date) BETWEEN 1  AND 3  THEN f.Net_Profit ELSE 0 END) AS Q1_Profit,
    SUM(CASE WHEN MONTH(f.Order_Date) BETWEEN 4  AND 6  THEN f.Net_Profit ELSE 0 END) AS Q2_Profit,
    SUM(CASE WHEN MONTH(f.Order_Date) BETWEEN 7  AND 9  THEN f.Net_Profit ELSE 0 END) AS Q3_Profit,
    SUM(CASE WHEN MONTH(f.Order_Date) BETWEEN 10 AND 12 THEN f.Net_Profit ELSE 0 END) AS Q4_Profit
FROM Fact_Sales f
JOIN Dim_Products p ON f.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY p.Category;