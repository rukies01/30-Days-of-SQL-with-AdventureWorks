1.
SELECT 
    DATEPART(YEAR, OrderDate) AS Year,
    SUM(SalesAmount) AS TotalSales
FROM FactInternetSales
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY Year;

2
/*2️⃣Running Total Per Year
Question:For each year:
Show total yearly sales
Show cumulative (running) total of sales over time

WITH TotalREV AS
(
SELECT 
	DATEPART(YEAR, OrderDate) AS YEAR,
	Sum(SalesAmount) AS TotalSales
FROM FactInternetSales
GROUP BY DATEPART(YEAR, OrderDate)
)

SELECT 
	YEAR,
	TotalSales,
	sum(TotalSales) over (ORDER BY YEAR) AS RunningTotal
FROM TotalREV
ORDER BY YEAR

3.
/*Top Region Per Year
Question:For each year:
Determine which region had the highest total sales
Output:Year,RegionName,TotalSales


WITH TotalREV2 AS
(
SELECT 
	DATEPART(YEAR, S.OrderDate) AS OrderYear,
	Sum(S.SalesAmount) AS TotalSales,
	G.EnglishCountryRegionName AS Region
FROM FactInternetSales S
LEFT JOIN DimGeography G
ON S.SalesTerritoryKey = G.SalesTerritoryKey
GROUP BY G.EnglishCountryRegionName,
DATEPART(Year, S.OrderDate)
),
TotalREV3 AS
(
SELECT 
	*,
	Rank() over (Partition BY OrderYear ORDER BY TotalSales) as Rank
FROM TotalREV2
)
SELECT 
	OrderYear,
	Region,
	TotalSales
FROM TotalREV3
WHERE Rank = 1


4. Customer lifetime Value
WITH OrderTotals AS
(
    SELECT 
        SalesOrderNumber,
        CustomerKey,
        SUM(SalesAmount) AS OrderTotal
    FROM FactInternetSales
    GROUP BY SalesOrderNumber, CustomerKey
)

SELECT 
    CustomerKey,
    SUM(OrderTotal) AS LifetimeSales,
    COUNT(SalesOrderNumber) AS TotalOrders,
    AVG(OrderTotal) AS AvgOrderValue
FROM OrderTotals
GROUP BY CustomerKey
ORDER BY LifetimeSales DESC;

5.  
--1Year-over-Year Growth %

Question:

For each year:

Calculate total sales

Calculate previous year's total sales

Compute the Year-over-Year (YoY) growth percentage

Output should include:

Year

TotalSales

PreviousYearSales

YoYGrowthPercent

WITH TotalREV AS
(
SELECT 
	DATEPART(YEAR, OrderDate) AS YEAR,
	Sum(SalesAmount) AS TotalSales
FROM FactInternetSales
GROUP BY DATEPART(YEAR, OrderDate)
),
YOY AS
(
SELECT YEAR,
	TotalSales,
	Lag(TotalSales) over (ORDER BY YEAR) AS LastYearSales
FROM TotalREV
)
SELECT 
	YEAR,
	TotalSales,
	LastYearSales,
	(TotalSales - LastYearSales)/
	NULLIF(LastYearSales, 0) * 100 AS YoYSales
FROM YOY
