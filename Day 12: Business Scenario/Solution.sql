
### Day 13: Business Scenario

1. Which products are declining in sales?


With YearlySales AS
(SELECT 
	Datepart(year, F.OrderDate) as OrderYear,
	P.EnglishProductName As ProductName,
	Max(F.UnitPrice) as ProductPrice,
	COUNT(Distinct F.SalesOrderNumber) AS NumberOfOrders,
	Sum(OrderQuantity) as TotalQuantity,
	Sum(F.SalesAmount) AS TotalSales
	FROM FactInternetSales F
LEFT JOIN DimProduct P
ON F.ProductKey = p.ProductKey
Group BY P.EnglishProductName, Datepart(year, F.OrderDate)
) ,
LastYearSales AS
(
SELECT *,
	LAG(TotalSales) OVER (Partition BY ProductName Order By OrderYear) as PreviousYearSales
From YearlySales
)
SELECT 
	OrderYear,
	ProductName,
	TotalQuantity,
	TotalSales,
	(TotalSales - PreviousYearSales)  / NullIF(PreviousYearSales, 0) AS YoYGrowth,
	CASE
		WHEN PreviousYearSales IS NULL THEN 'First Year'
        WHEN TotalSales < PreviousYearSales THEN 'Declining'
        WHEN TotalSales > PreviousYearSales THEN 'Growing'
        ELSE 'Stable'
    END AS SalesTrend
FROM LastYearSales



Customer life cycle
WITH BaseTabLE AS
(
SELECT 
	CustomerKey,
	Min(Cast(OrderDate as Date)) as FirstOrder,
	Max(Cast(OrderDate as Date)) as LastOrder
From FactInternetSales
Group By CustomerKey
), Intervals AS
(
Select
	*,
	Datediff(Day, FirstOrder, LastOrder) AS DaysInterval
From BaseTabLE
),
CustomerFlag AS 
(
SELECT *, 
	CASE
		WHEN DaysInterval = 0 THEN 'New Customer'
		WHEN DaysInterval >=901 THEN 'InActive'
		WHEN DaysInterval >=501 THEN 'Semi-Active'
		WHEN DaysInterval >=101 THEN 'Active'
		Else 'Very Active'
		End AS CustomerActivityFlag
FROM Intervals
)
SELECT
	CustomerKey,
	FirstOrder,
	LastOrder,
	DaysInterval,
	CustomerActivityFlag
FROM CustomerFlag
Where CustomerActivityFlag = 'InActive'


--Which customers are becoming inactive?
	
WITH LastOrder AS
(
SELECT 
	CustomerKey,
	Max(Cast(OrderDate as Date)) as LastOrderDate  --(I used the last order date in the data as a benchmark for customer recency the farther the customer last order is from this date the inactive they become)
From FactInternetSales
Group By CustomerKey
),
MaxOrderDate AS
(Select 
	Max(Cast(OrderDate as Date)) as MaxOrderDate
From FactInternetSales
)
SELECT
	L.CustomerKey,
	L.LastOrderDate,
	Datediff(Day,  L.LastOrderDate, M.MaxOrderDate) as Intervals,
	CASE
		WHEN Datediff(Day, L.LastOrderDate, M.MaxOrderDate) >= 365 THEN 'InActive'
		WHEN Datediff(Day, L.LastOrderDate, M.MaxOrderDate) >= 180 THEN 'At Risk'
		WHEN Datediff(Day, L.LastOrderDate, M.MaxOrderDate) >= 90 THEN 'Needs Attension'
		ELSE 'Active'
		END AS CustomerActivityFlag
FROM MaxOrderDate M
CROSS JOIN LastOrder L
WHERE Datediff(Day, L.LastOrderDate, M.MaxOrderDate) >= 365


3. Which regions generate high revenue but low order volume?
With BaseTable as
(
SELECT
	G.EnglishCountryRegionName AS Region,
	SUM(F.SalesAmount) AS Revenue,
	Count(Distinct F.SalesOrderNumber) AS OrderVolume
From FactInternetSales F
LEFT JOIN DimGeography G
ON F.SalesTerritoryKey = G.SalesTerritoryKey
Group by G.EnglishCountryRegionName
),
BenchMark AS
(
SELECT  
	AVG(Revenue) AS AverageSales,
	AVG(OrderVolume) AS AverageOrderVolume
From BaseTable
)
Select 
	B.Region,
	B.Revenue,
	B.OrderVolume
From  BaseTable B
cross join BenchMark M
Where B.Revenue > M.AverageSales  AND
   B.OrderVolume < M.AverageOrderVolume
