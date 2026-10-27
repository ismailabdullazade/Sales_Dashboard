--Q6: REVENUE BY CITY
select
	c.City,
	count(f.Order_ID)		as order_amount,
	count(distinct c.Customer_ID)	as customer_amount,
	SUM(f.Total_Amount)		as Total_Revenue,
	ROUND(AVG(f.Total_Amount),2) as average_order_price
from Fact_Sales  f
join Dim_Customers c
on f.Customer_ID = c.Customer_ID
group by c.City
order by Total_Revenue DESC;