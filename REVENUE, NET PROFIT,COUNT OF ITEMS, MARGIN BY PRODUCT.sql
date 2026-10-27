--Q3: REVENUE, NET PROFIT,COUNT OF ITEMS, MARGIN BY PRODUCT
with by_product as(
	select 
		p.Category,
		SUM(fs.Net_Profit)	as total_net,
		SUM(fs.Total_Amount) as total_revenue,
		COUNT(*)			as total_order,
		SUM(fs.Quantity)	as total_item
	from Fact_Sales		fs
	join Dim_Products	p
	on fs.Product_ID = p.Product_ID
	group by p.Category
)
select *,
	   	ROUND(total_net/total_revenue * 100.0,2)	as profit_margin
from by_product
order by profit_margin desc;