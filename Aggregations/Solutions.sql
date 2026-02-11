1. Total sales per year.

SELECT 
	DATEPART(YEAR, OrderDate) AS YEAR,
	SUM(SalesAmount) TotalSalesByYear
From FactInternetSales
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY YEAR DESC

--2. Average order value per customer.
SELECT 
	C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	AVG(S.SalesAmount) AvrOrderValue
FROM FactInternetSales S
LEFT JOIN DimCustomer C
ON S.CustomerKey = C.CustomerKey
GROUP BY C.CustomerKey,
	 CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName)
Order BY AvrOrderValue DESC


3. Count of orders per region
SELECT 
	G.EnglishCountryRegionName,
	COUNT(S.SalesOrderNumber) AS TotalOrderByRegion
	FROM FactInternetSales S
LEFT JOIN DimGeography G
ON S.SalesTerritoryKey = G.SalesTerritoryKey
GROUP BY G.EnglishCountryRegionName
ORDER BY TotalOrderByRegion DESC
	
