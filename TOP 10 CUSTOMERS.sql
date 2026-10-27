--Q5: TOP 10 CUSTOMER
select top 10
	f.Customer_ID,
	c.Customer_Name,
	c.City,
	c.Customer_Segment,
	count(f.Order_ID)	as order_amount,
	sum(f.Total_Amount)	as total_revenue,
	sum(f.Net_Profit)	as total_profit

from Fact_Sales f
join Dim_Customers c
on f.Customer_ID = c.Customer_ID
group by 
	f.Customer_ID,
	c.Customer_Name,
	c.City,
	c.Customer_Segment
order by total_revenue desc;