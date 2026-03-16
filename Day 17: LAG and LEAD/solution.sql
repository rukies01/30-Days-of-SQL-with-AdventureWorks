Day 17: LAG and LEAD

1. Compare current month sales to previous month.
WITH BASETABLE AS
(
	SELECT 
	DATEPART(YEAR, OrderDate) AS OrderYear,
	DATEPART(MONTH, OrderDate) AS OrderMonth,
	Sum(SalesAmount) AS Revenue
	FROM FactInternetSales
	GROUP BY DATEPART(YEAR, OrderDate),
		DATEPART(MONTH, OrderDate)
),
LastMonthRevenue AS
(
	SELECT *,
	LAG(Revenue) OVER (ORDER BY OrderYear, OrderMonth) AS PreviousMonthRevenue
	FROM BASETABLE
),
REVENUE AS
(
	SELECT *,
	(Revenue - PreviousMonthRevenue)/NULLIF(PreviousMonthRevenue, 0)  AS RevenueGrowth
	FROM LastMonthRevenue
)
SELECT 
	OrderYear,
	OrderMonth,
	Revenue,
	PreviousMonthRevenue,
	RevenueGrowth
FROM REVENUE
Order By OrderYear,
		OrderMonth


2. Calculate month-over-month growth percentage.
WITH BASETABLE AS
(
	SELECT 
		DATEPART(YEAR, OrderDate) AS OrderYear,
		DATEPART(MONTH, OrderDate) AS OrderMonth,
		Sum(SalesAmount) AS Revenue
	FROM FactInternetSales
	GROUP BY DATEPART(YEAR, OrderDate),
		DATEPART(MONTH, OrderDate)
) 
	SELECT *,
		SUM(Revenue) over (Order By OrderYear ,OrderMonth ) CummulativeRevenue
	FROM BASETABLE;

WITH BASETABLE AS
( 
	SELECT 
		DATEPART(YEAR, OrderDate) AS OrderYear,
		DATEPART(MONTH, OrderDate) AS OrderMonth,
		Sum(SalesAmount) AS Revenue
	FROM FactInternetSales
	GROUP BY DATEPART(YEAR, OrderDate),
		DATEPART(MONTH, OrderDate)
),
PMR AS
(
	SELECT *,
	LAG(Revenue) OVER (ORDER BY OrderYear, OrderMonth) AS PreviousMonthRevenue
	FROM BASETABLE
)
	SELECT
		OrderYear,
		OrderMonth,
		Revenue,
		(Revenue - PreviousMonthRevenue)/NULLIF(PreviousMonthRevenue, 0) * 100 AS MoMRevenueGrowth
	FROM PMR
	ORDER BY OrderYear, OrderMonth

3. Identify months with sales decline.
WITH BASETABLE AS
( 
	SELECT 
		DATEPART(YEAR, OrderDate) AS OrderYear,
		DATEPART(MONTH, OrderDate) AS OrderMonth,
		Sum(SalesAmount) AS Revenue
	FROM FactInternetSales
	GROUP BY DATEPART(YEAR, OrderDate),
		DATEPART(MONTH, OrderDate)
),
PMR AS
(
	SELECT *,
	LAG(Revenue) OVER (ORDER BY OrderYear, OrderMonth) AS PreviousMonthRevenue
	FROM BASETABLE
)
	SELECT
		OrderYear,
		OrderMonth,
		Revenue,
		PreviousMonthRevenue
	FROM PMR
	WHERE Revenue< PreviousMonthRevenue
	ORDER BY OrderYear, OrderMonth
