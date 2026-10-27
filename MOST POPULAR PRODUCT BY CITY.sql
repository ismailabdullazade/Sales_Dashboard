--Q13 MOST POPULAR PRODUCT BY CITY
WITH city_product_sales AS (
    SELECT
        c.City,
        p.Product_ID,
        p.Category,
        SUM(f.Quantity) AS Total_Quantity
    FROM Fact_Sales f
    JOIN Dim_Customers c ON f.Customer_ID = c.Customer_ID
    JOIN Dim_Products  p ON f.Product_ID  = p.Product_ID
    GROUP BY c.City, p.Product_ID, p.Category
),
ranked AS (
    SELECT
        City,
        Product_ID,
        Category,
        Total_Quantity,
        ROW_NUMBER() OVER (PARTITION BY City ORDER BY Total_Quantity DESC) AS rn
    FROM city_product_sales
)
SELECT City, Product_ID, Category, Total_Quantity
FROM ranked
WHERE rn = 1
ORDER BY City;