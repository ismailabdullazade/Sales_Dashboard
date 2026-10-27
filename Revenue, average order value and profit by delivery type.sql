--Q9: Revenue, average order value and profit by delivery type
select
	Delivery_Type,
	COUNT(*)	as order_amount,
	CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() as decimal(10,2))	as order_share,
	SUM(Total_Amount)								as total_revenue,
	CAST(AVG(Total_Amount) as decimal(10,2))		as average_revenue,
	SUM(Net_Profit)									as total_profit,
	CAST(avg(Net_Profit)as decimal(10,2))			as average_profit,
	SUM(Delivery_Fee)								as total_delivery_fee

from Fact_Sales
group by Delivery_Type
order by total_revenue DESC;