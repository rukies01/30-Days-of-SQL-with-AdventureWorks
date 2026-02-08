1. Show order number, product name, category, and subcategory.

SELECT 
	S.SalesOrderNumber,
	P.EnglishProductName,
	C.EnglishProductCategoryName,
	E.EnglishProductSubcategoryName
FROM FactInternetSales S
LEFT JOIN DimProduct P
ON S.ProductKey = P.ProductKey
LEFT JOIN DimProductSubcategory E
ON P.ProductSubcategoryKey = E.ProductSubcategoryKey
LEFT JOIN DimProductCategory C
ON E.ProductCategoryKey = C.ProductCategoryKey



--2. Find total sales amount per customer.
SELECT 
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	SUM(S.SalesAmount) AS TotalSales
FROM FactInternetSales S
LEFT JOIN DimCustomer C
ON S.CustomerKey = C.CustomerKey
GROUP BY CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName)  
ORDER BY SUM(S.SalesAmount) desc

--Nichole Nara has the highest total sales

--3. Identify top 10 customers by total sales value
WITH TSales AS
(
SELECT
	C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	SUM(S.SalesAmount) AS TotalSales
FROM FactInternetSales S
LEFT JOIN DimCustomer C
ON S.CustomerKey = C.CustomerKey
GROUP BY 
	C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) 
)
SELECT TOP 10 *
FROM TSales
ORDER BY TotalSales DESC
