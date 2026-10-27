--Q4: SHARES PERCENTAGE
SELECT
    p.Category,
    SUM(fs.Total_Amount) AS revenue,
    ROUND(SUM(fs.Total_Amount) * 100.0 / SUM(SUM(fs.Total_Amount)) OVER (), 1) AS revenue_share_pct,
    SUM(fs.Net_Profit)   AS profit,
    ROUND(SUM(fs.Net_Profit) * 100.0 / SUM(SUM(fs.Net_Profit)) OVER (), 1)     AS profit_share_pct
FROM Fact_Sales fs
JOIN Dim_Products p ON fs.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY revenue DESC;