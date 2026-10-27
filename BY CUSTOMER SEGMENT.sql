--Q7: BY CUSTOMER SEGMENT
select
	c.Customer_Segment				as customer_segment,
	count(distinct f.Customer_ID)	as customer_amount,
	count(f.Order_ID)				as order_amount,
	sum(f.Total_Amount)				as total_revenue,
	ROUND(avg(f.Total_Amount),2)				as average_revenue,
	ROUND(sum(f.Total_Amount) / count(distinct f.Customer_ID),2)		as average_customer_revenue

from Fact_Sales f
join Dim_Customers c
on f.Customer_ID = c.Customer_ID
group by c.Customer_Segment
order by total_revenue DESC;