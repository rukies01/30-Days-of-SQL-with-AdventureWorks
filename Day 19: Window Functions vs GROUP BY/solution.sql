1. Show total sales per customer without losing row detail.
SELECT Cast(OrderDate as Date) as Date, 
	CustomerKey, 
	SalesOrderNumber, 
	SalesAmount, 
	sum(SalesAmount) over (Partition by CustomerKey Order by Cast(OrderDate as Date), SalesOrderNumber) as RunningTotal, 
	sum(SalesAmount) over (Partition by CustomerKey) as TotalSalesPerCustomer 
FROM FactInternetSales

2. Compare order value to customer’s average order value.

WITH BASETABLE AS
(
	Select CustomerKey as Customer, 
		SalesOrderNumber AS SalesOrderNumber,
		Sum(SalesAmount) as OrderValue
	FROM FactInternetSales
	GROUP BY CustomerKey, 
	SalesOrderNumber),
CAOValue AS
(
	SELECT *,
		AVG(OrderValue) over (Partition by Customer) As CustomerAverageOrderValue
	FROM BASETABLE
) 
	SELECT
		Customer,
		SalesOrderNumber,
		OrderValue,
		CustomerAverageOrderValue,
		(OrderValue-CustomerAverageOrderValue) * 100.0/CustomerAverageOrderValue as ComparisimPercent
FROM CAOValue
	

3. Explain when window functions are better than aggregation.
  Window functions are better than aggregation when we want to calculate totals, averages, rankings, or comparisons without losing row-level detail.

Aggregation using GROUP BY summarizes data and reduces the number of rows, while window functions allow us to keep the original rows and still perform calculations across related records.

For example, window functions can show a customer’s total sales while still displaying each individual order that contributed to that total.
