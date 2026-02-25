
### Day 15: ROW_NUMBER, RANK, DENSE_RANK

1. Rank customers by total sales.
2. Rank products within each category.
3. Identify top 3 products per category.

WITH BaseTable AS
(
SELECT 
	C.CustomerKey AS CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerName,
	SUM(F.SalesAmount) AS Revenue
From FactInternetSales F
Left Join DimCustomer C
ON F.CustomerKey = C.CustomerKey
Group By C.CustomerKey, CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) 
)
SELECT *,
	Rank() over (Order BY Revenue  DESC) As CustomerRank,
	Dense_Rank() over (Order BY Revenue  DESC) CustomerRank2
From BaseTable


2. Rank products within each category
WITH BASETABLE AS
(
SELECT 
	P.EnglishProductName AS ProductName,
	C.EnglishProductCategoryName AS ProductCategory,
	 S.EnglishProductSubCategoryName AS ProductSubCategory,
	Sum(F.SalesAmount) AS Revenue
 from FactInternetSales F
 Left JOIN DimProduct P
 ON F.ProductKey = P.ProductKey
 Left JOIN DimProductSubCategory S
 ON P.ProductSubCategoryKey = S.ProductSubCategoryKey
 LEFT JOIN DimProductCategory C
 ON S.ProductCategoryKey = C.ProductCategoryKey
 Group BY P.EnglishProductName ,
	C.EnglishProductCategoryName ,
	 S.EnglishProductSubCategoryName
)
SELECT
	ProductName,
	ProductCategory,
	Revenue,
	RANK() OVER (PARTITION BY ProductCategory ORDER BY Revenue desc) as ProductRank
FROM BASETABLE

3. Identify top 3 products per category
WITH BASETABLE AS
(
SELECT 
	P.EnglishProductName AS ProductName,
	C.EnglishProductCategoryName AS ProductCategory,
	 S.EnglishProductSubCategoryName AS ProductSubCategory,
	Sum(F.SalesAmount) AS Revenue
 from FactInternetSales F
 Left JOIN DimProduct P
 ON F.ProductKey = P.ProductKey
 Left JOIN DimProductSubCategory S
 ON P.ProductSubCategoryKey = S.ProductSubCategoryKey
 LEFT JOIN DimProductCategory C
 ON S.ProductCategoryKey = C.ProductCategoryKey
 Group BY P.EnglishProductName ,
	C.EnglishProductCategoryName ,
	 S.EnglishProductSubCategoryName
),
RankProduct AS
(
SELECT 
	ProductName,
	ProductCategory,
	Revenue,
	RANK() OVER (PARTITION BY ProductCategory ORDER BY Revenue desc) as ProductRank
FROM BASETABLE
)
SELECT *
FROM RankProduct
Where ProductRank <= 3
