--Q11: Sales by color and size
select
	Color		as color,
	SUM(Quantity)	as Unit_sold,
	CAST(SUM(Quantity) * 100.0 / SUM(SUM(Quantity)) OVER() as decimal(10,2))    as unit_share,
	COUNT(*)			as order_amount,
	SUM(Total_Amount)	as total_revenue
from Fact_Sales
group by Color
order by Unit_sold DESC;

select
	Size		as size,
	SUM(Quantity)	as Unit_sold,
	CAST(SUM(Quantity) * 100.0 / SUM(SUM(Quantity)) OVER() as decimal(10,2))    as unit_share,
	COUNT(*)			as order_amount,
	SUM(Total_Amount)	as total_revenue,
	CASE
		when size = 'S' then 1
		when size = 'M' then 2
		when size = 'L' then 3
		when size = 'XL' then 4
		when size = 'XXL' then 5
	END as size_number
from Fact_Sales
group by Size
order by size_number;