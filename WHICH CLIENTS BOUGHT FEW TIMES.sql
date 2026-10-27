--Q12 WHICH CLIENTS BOUGHT FEW TIMES
with cte as (
	select
		Customer_ID				as customer,
		COUNT(Order_ID)			as order_count
	from Fact_Sales
	group by Customer_ID
)
select 
	COUNT(customer)				as customer_amount,
	order_count
from cte
group by order_count
order by order_count desc;