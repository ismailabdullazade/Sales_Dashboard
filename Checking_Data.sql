SELECT 
'Dim_Products' AS table_name, COUNT(*) AS row_count FROM Dim_Products
UNION ALL SELECT 'Dim_Customers', COUNT(*) FROM Dim_Customers
UNION ALL SELECT 'Fact_Sales', COUNT(*) FROM Fact_Sales;

SELECT SUM(Total_Amount) AS total_revenue,
       SUM(Net_Profit)   AS total_profit
FROM Fact_Sales;

--checking the order_date data type
select column_name, data_type 
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'Fact_Sales'
	and COLUMN_NAME = 'Order_Date';

--ADJUSTING THE DATA TYPE
alter table Fact_Sales
alter column Order_Date Date not null;

--checking again
select 
  MIN(Order_Date) as first_order, 
  MAX(Order_Date) as last_order
from Fact_Sales;

--ADDING FOREIGN KEY
alter table Fact_Sales
add constraint FK_Sales_Customer
	foreign key (Customer_ID) References Dim_Customers(Customer_ID);

alter table Fact_Sales
add constraint FK_Sales_Product
	foreign key (Product_ID) References Dim_Products(Product_ID);

--checking
select name as foreign_key,
	OBJECT_NAME(parent_object_id) as child_table,
	OBJECT_NAME(referenced_object_id) as parent_table
from sys.foreign_keys;

--CHECKING NULL VALUES
SELECT
    SUM(CASE WHEN Order_ID IS NULL THEN 1 ELSE 0 END)     AS null_order_id,
    SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END)   AS null_order_date,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END)  AS null_customer_id,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END)   AS null_product_id,
    SUM(CASE WHEN Total_Amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
    SUM(CASE WHEN Net_Profit IS NULL THEN 1 ELSE 0 END)   AS null_net_profit
FROM Fact_Sales;

--CHECKING DUPES
SELECT Order_ID, COUNT(*) AS cnt
FROM Fact_Sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;

--ORPHAN IDS
SELECT COUNT(*) AS orphan_customers
from Fact_Sales f
left join Dim_Customers c
on f.Customer_ID = c.Customer_ID
where c.Customer_ID IS NULL;

select COUNT(*) as orphan_products
from Fact_Sales f
left join Dim_Products p
on f.Product_ID = p.Product_ID
where p.Product_ID IS NULL;

--CHECKING FORMULAS
select COUNT(*) as wrong_total_amount
from Fact_Sales
where Total_Amount <> Quantity * Unit_Price - Discount_Amount + Delivery_Fee + Gift_Wrap_Fee;

select count(*) as wrong_total_cost
from Fact_Sales
where Total_Cost <> Quantity * Unit_Cost;

select COUNT(*) as wrong_net_profit
from Fact_Sales
where Net_Profit <> Total_Amount - Total_Cost;

--CHECKING GENDER/NAME MATCHING
SELECT
    LEFT(Customer_Name, CHARINDEX(' ', Customer_Name) - 1) AS first_name,
    COUNT(DISTINCT Gender) AS gender_variants,
    COUNT(*) AS customers
FROM Dim_Customers
GROUP BY LEFT(Customer_Name, CHARINDEX(' ', Customer_Name) - 1)
HAVING COUNT(DISTINCT Gender) > 1
ORDER BY customers DESC;



