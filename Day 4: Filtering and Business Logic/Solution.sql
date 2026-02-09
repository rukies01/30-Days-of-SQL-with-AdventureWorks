
Day 4: Filtering and Business Logic

--1. Find orders placed in the last 12 months.
SELECT
	 Cast(OrderDate as Date) AS Date,
	 SalesOrderNumber,
	 SalesAmount
FROM FactInternetSales
WHERE OrderDate >= DATEADD(MONTH, -12,(SELECT MAX(OrderDate) from FactInternetSales))
 
--2. Identify customers who placed more than 5 orders.
SELECT 
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	COUNT(F.SalesOrderNumber) TotalOrder
FROM FactInternetSales F
LEFT JOIN DimCustomer C
ON F.CustomerKey = C.CustomerKey
GROUP BY  CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) 
HAVING COUNT(F.SalesOrderNumber) > 5
ORDER BY TotalOrder DESC
 
--3. Show products with price above the average product price.
WITH AvRate As
(Select 
	AVG(ListPrice) AS AveragePrice
from DimProduct
)
SELECT 
	P.EnglishProductName AS ProductName,
	P.ListPrice,
	A.AveragePrice                                   
	FROM DimProduct P
CROSS JOIN AvRate A  -- pair all rows with AvRate value
WHERE P.ListPrice > A.AveragePrice
ORDER BY P.ListPrice

--Show products whose price is above their category’s average price.
WITH AvRateE AS
(
SELECT 
	P.EnglishProductName AS ProductName,
	C.EnglishProductSubCategoryName,--
	P.ListPrice,
	AVG(P.ListPrice) OVER (PARTITION BY C.EnglishProductSubCategoryName) AS CategoryAverage                                
FROM DimProduct P
JOIN DimProductSubCategory C
ON P.ProductSubCategoryKey = C.ProductSubCategoryKey
)
SELECT * FROM AvRateE
WHERE ListPrice > CategoryAverage
