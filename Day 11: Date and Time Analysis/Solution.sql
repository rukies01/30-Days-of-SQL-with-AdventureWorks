
--1. Sales by month and year.

SELECT 	
	DatePart(Year, OrderDate) AS OrderYear,
	DatePart(Month, OrderDate) AS OrderMonth,
	Sum(SalesAmount) As Revenue
FROM FactInternetSales
Group By 
	DatePart(Year, OrderDate) ,
	DatePart(Month, OrderDate)
Order By OrderYear, OrderMonth 

--2. Month-over-month sales growth.

WITH BaseTable AS
(SELECT 	
	DatePart(Year, OrderDate) AS OrderYear,
	DatePart(Month, OrderDate) AS OrderMonth,
	Sum(SalesAmount) As Revenue
FROM FactInternetSales
Group By 
	DatePart(Year, OrderDate) ,
	DatePart(Month, OrderDate)
),
Growth AS
(
Select *,
	SUM(Revenue) over (PARTITION BY OrderYear ORDER BY OrderYear) AS YoYRunningTotal,
	SUM(Revenue) over (PARTITION BY OrderMonth ORDER BY OrderMonth) AS MoMRunningTotal,
	LAG(Revenue) OVER (ORDER BY OrderYear, OrderMonth) AS PreviousMonthRevenue
	From
	BaseTable
	)
SELECT
	OrderYear,
	OrderMonth,
	Revenue,
	PreviousMonthRevenue,
	(Revenue-PreviousMonthRevenue) * 1.0/Nullif(PreviousMonthRevenue,0) as MoMGrowth
FROM Growth
Order By OrderYear,
		OrderMonth


--3. Identify seasonal trends.
WITH BaseTable AS
(SELECT 	
	DatePart(Year, OrderDate) AS OrderYear,
	DatePart(Month, OrderDate) AS OrderMonth,
	Sum(SalesAmount) As Revenue
FROM FactInternetSales
Group By 
	DatePart(Year, OrderDate) ,
	DatePart(Month, OrderDate)
)
SELECT 
	OrderMonth,
	AVG(Revenue) AS AverageMonthlyRevenue
FROM BaseTable
GROUP BY 
	OrderMonth
ORDER BY
	OrderMonth
