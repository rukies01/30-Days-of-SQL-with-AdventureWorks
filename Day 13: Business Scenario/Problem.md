### Day 13: Business Scenario

1. Which products are declining in sales?

WITH BASETABLE AS 
(
	SELECT Datepart(Year, F.Orderdate) as OrderYear,
		Datepart(Month, F.Orderdate) as OrderMonth,
		P.EnglishProductName AS ProductName,
		Sum(F.SalesAmount) AS CurrentMonthRevenue
	FROM FactInternetSales F
	LEFT JOIN DimProduct P
	ON F.ProductKey = P.ProductKey
	GROUP BY Datepart(Year, F.Orderdate),
		Datepart(Month, F.Orderdate),
		P.EnglishProductName
),
MonthlyOrder As
(
	SELECT *,
		LAG(CurrentMonthRevenue,1,0) over (Partition by ProductName  Order by OrderYear,OrderMonth) as PreviousMonthsOrder,
		LEAD(CurrentMonthRevenue,1,0) over(Partition by ProductName Order by OrderYear,OrderMonth) as NextMonthsOrder
	FROM BASETABLE
)
SELECT
	OrderYear,
	OrderMonth,
	ProductName,
	PreviousMonthsOrder,
	CurrentMonthRevenue,
	NextMonthsOrder
FROM MonthlyOrder
	WHERE CurrentMonthRevenue>NextMonthsOrder
	ORDER BY OrderYear,OrderMonth

2. Which customers are becoming inactive?

WITH CLastOrderDate AS
(
	SELECT F.CustomerKey AS CustomerKey,
		Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName) as CustomerFullName,
		Max(CAST (OrderDate AS Date)) as CustomerLastOrderDate
	From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
	GROUP BY  F.CustomerKey,
		Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName)
),
MAXORDERDATE AS
(
	SELECT *,
	MAX(CustomerLastOrderDate) OVER () AS MaxOrderDate,
	Datediff(DAY,  CustomerLastOrderDate, MAX(CustomerLastOrderDate)OVER ()) AS InActivePeriod
	FROM  CLastOrderDate
),
FLAG AS
(
	SELECT *,
		CASE
			WHEN InActivePeriod > 180 THEN 'INACTIVE'
			WHEN InActivePeriod > 90 THEN 'SEMI-ACTIVE'
			ELSE 'ACTIVE'
		END AS Flag
FROM MAXORDERDATE
)
SELECT CustomerKey,
	CustomerFullName,
	MaxOrderDate,
	CustomerLastOrderDate,
	InActivePeriod,
	Flag
FROM FLAG
Where Flag = 'Inactive'

3. Which regions generate high revenue but low order volume?
WITH BASETABLE AS
(
	SELECT G.EnglishCountryRegionName as Region,
		Count(Distinct F.SalesOrderNumber) AS OrderVolume,
		Sum(F.SalesAmount) AS Revenue
	FROM FactInternetSales F
	LEFT JOIN DimGeography G
	ON F.SalesTerritoryKey = G.SalesTerritoryKey
	GROUP BY EnglishCountryRegionName
),
RankRevOrd AS
(
	SELECT *,
		Rank() over (Order by Revenue DESC) as RevenueRank,
		Rank() over (Order By OrderVolume DESC) as OrderVolumeRank
	FROM BASETABLE
)
SELECT Region,
	OrderVolume,
	Revenue,
	RevenueRank,
	OrderVolumeRank
FROM RankRevOrd
Where RevenueRank = (Select min(RevenueRank) from RankRevOrd) and  OrderVolumeRank =(Select Max(OrderVolumeRank) from RankRevOrd)



