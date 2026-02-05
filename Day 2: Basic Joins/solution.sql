--1. Retrieve all sales orders with customer name and order date.

 SELECT
	CAST(F.OrderDate AS DATE) OrderDate,
	C.FirstName,
	COALESCE(C.MiddleName, 'Unknown') AS MiddleName,
	C.LastName,
	F.SalesOrderNumber,
	F.SalesAmount
 FROM FactInternetSales F
 LEFT JOIN DimCustomer C 
 ON C.CustomerKey = f.CustomerKey
 
--2. Show customer name, city, and country for each order.--
SELECT 
	F.SalesOrderNumber,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	G.City,
	G.CountryRegionCode
	FROM FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
	LEFT JOIN DimGeography G
	ON G.GeographyKey  =C.GeographyKey 
	ORDER BY CustomerFullName

--3. Find products that have never been sold.
SELECT
	P.ProductKey,
	EnglishProductName,
	F.SalesOrderNumber
FROM DimProduct P
left join FactInternetSales F
ON P.ProductKey = F.ProductKey
WHERE F.ProductKey IS NULL
