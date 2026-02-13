--1. Find customers who spent more than the average customer spend.--
SELECT * FROM(
	SELECT *,
	AVG(totalSales) OVER () AS AverageSales2
FROM(
SELECT
	C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	SUM(S.SalesAmount) as totalSales
	
FROM FactInternetSales S
LEFT JOIN DimCustomer C
ON S.CustomerKey = C.CustomerKey
GROUP BY C.CustomerKey, 
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) 
) A)B
WHERE totalSales > AverageSales2
ORDER BY totalSales DESC

--2. Identify products priced higher than the average price in their category
Select
	ProductName,
	Price,
	AvgPrice,
	ProductCategory
From
(
SELECT 
	*,
	AVG(Price) over (Partition By ProductCategory) AS AvgPrice
FROM
(SELECT 
	P.EnglishProductName AS ProductName,
	S.EnglishProductSubcategoryName AS ProductSubcategory,
	C.EnglishProductCategoryName AS ProductCategory,
	P.ListPrice AS Price
FROM DimProduct P
LEFT JOIN DimProductSubcategory S
ON P.ProductSubCategoryKey = S.ProductSubCategoryKey
Left JOIN DimProductCategory C
ON S.ProductCategoryKey = C.ProductCategoryKey
) A
) B
Where Price > AvgPrice


--3. Get orders that contain the most expensive product
SELECT DISTINCT S.SalesOrderNumber
FROM FactInternetSales S
JOIN DimProduct P
    ON S.ProductKey = P.ProductKey
WHERE P.ListPrice = (
    SELECT MAX(ListPrice)
    FROM DimProduct
);


	--COHORT ANALYSIS
WITH FirstOrderD AS
	(SELECT C.CustomerKey AS CustomerKey,
	MIN(OrderDate) AS FirstOrderDate
	From FactInternetSales S
	LEFT JOIN DimCustomer C
	ON 
	S.CustomerKey = C.CustomerKey
	GROUP BY C.CustomerKey
	),
Cohort AS
	(SELECT 
	CustomerKey,
	FirstOrderDate,
	YEAR(FirstOrderDate) AS CohortYear
	From FirstOrderD
	)
SELECT
		A.CohortYear,
		SUM(B.SalesAmount) AS TotalRevenue,
		Count(Distinct A.CustomerKey) TotalCustomer,
		SUM(B.SalesAmount)/Count(Distinct A.CustomerKey) AS AvgRevenue
FROM Cohort A
LEFT JOIN FactInternetSales B
ON A.CustomerKey = B.CustomerKey
GROUP BY A.CohortYear
ORDER BY A.CohortYear
