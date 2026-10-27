--Q8: AVERAGE NET PROFIT BY DISCOUNT
--order_count	order_share_pct	avg_order_revenue	avg_order_profit	avg_quantity	profit_margin_pct
with cte as (
	select 
		Total_Amount,
		Net_Profit,
		Quantity,
		case
			when Discount_Amount <> 0 then 1
			else 0
		end as is_discount
	from Fact_Sales
)
select
	cte.is_discount,
	COUNT(*),
	CAST(AVG(Quantity * 1.0 ) as decimal(10,2))	as average_quantity,
	CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as DECIMAL(10,2))		as order_share,
	ROUND(SUM(cte.Net_Profit) / SUM(cte.Total_Amount) * 100,2)	as profit_share,
	ROUND(avg(cte.Total_Amount),2) as average_revenue,
	ROUND(avg(cte.Net_Profit),2)	as average_profit
from cte
group by cte.is_discount;