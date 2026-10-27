--Q10: Gift wrap share and its effect on order value
WITH wrap_groups AS (
    SELECT
        CASE WHEN Gift_Wrap = 'Yes' THEN 'Gift wrap' ELSE 'No gift wrap' END AS wrap_group,
        Total_Amount,
        Delivery_Fee,
        Gift_Wrap_Fee,
        Net_Profit
    FROM Fact_Sales
)
SELECT
    wrap_group,
    COUNT(*)                                                                  AS order_count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(10,2))           AS order_share_pct,
    CAST(AVG(Total_Amount) AS DECIMAL(10,2))                                  AS avg_order_value,
    CAST(AVG(Total_Amount - Gift_Wrap_Fee - Delivery_Fee) AS DECIMAL(10,2))   AS avg_order_value_without_fees,
    CAST(AVG(Net_Profit) AS DECIMAL(10,2))                                    AS avg_order_profit,
    SUM(Gift_Wrap_Fee)                                                        AS total_gift_wrap_fee
FROM wrap_groups
GROUP BY wrap_group
ORDER BY CASE WHEN wrap_group = 'Gift wrap' THEN 0 ELSE 1 END;