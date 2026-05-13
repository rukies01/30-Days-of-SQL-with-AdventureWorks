### Day 5: Aggregations

1. Total sales per year.
SELECT Datepart(Year, Orderdate) AS OrderYear,
	Sum(SalesAmount) AS Revenue
FROM FactInternetSales
GROUP BY Datepart(Year, Orderdate)
ORDER BY OrderYear ;

2. Average order value per customer.
SELECT F.CustomerKey,
	Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName) as CustomerFullName,
	SUM(SalesAmount) as Revenue,
	Sum(SalesAmount)/Count(Distinct SalesOrderNumber) As AverageOrderValuePerCustomer
From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
Group BY F.CustomerKey,
	Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName)
	
3. Count of orders per region.
SELECT G.EnglishCountryRegionName as Region,
		Count(Distinct F.SalesOrderNumber) AS OrderVolume
FROM FactInternetSales F
	LEFT JOIN DimGeography G
	ON F.SalesTerritoryKey = G.SalesTerritoryKey
	GROUP BY G.EnglishCountryRegionName
