--Q2: MOM REVENUE GROWTH
with monthly as (
	select
		MONTH(Order_Date)	as month_num,
		SUM(Total_Amount)	as revenue
	from Fact_Sales
	group by MONTH(Order_Date)
)
select 
	month_num,
	revenue,
	LAG(revenue) over(order by month_num) as previous_month,
	ROUND(
		(revenue - LAG(revenue) over(order by month_num))*100.0 / LAG(revenue) over(order by month_num),
		1) as mom_growth
from monthly
order by month_num;