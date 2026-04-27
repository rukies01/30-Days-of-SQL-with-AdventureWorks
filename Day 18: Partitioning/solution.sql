1. Rank customers within each region.
WITH BASETABLE AS
(
SELECT F.CustomerKey,
	D.EnglishCountryRegionName AS Region,
	SUM(F.SalesAmount) as TotalRevenue
FROM FactInternetSales F
LEFT JOIN DimGeography D
on F.SalesTerritoryKey = D.SalesTerritoryKey
GROUP BY  F.CustomerKey,
	D.EnglishCountryRegionName
)
SELECT *,
	RANK() over (Partition by Region order by TotalRevenue desc) as CustomerRankWithinRegion
from BASETABLE

	-- can use Rank, Dense_Rank or row_Number as he case maybe



  Calculate average order value per customer compared to regional average.

  WITH BASETABLE AS
(
SELECT F.CustomerKey,
	D.EnglishCountryRegionName AS Region,
	SUM(F.SalesAmount) AS CustomerRevenue,
	SUM(F.SalesAmount) / COUNT(DISTINCT F.SalesOrderNumber) AS AvgOrderValuePerCustomer
FROM FactInternetSales F
LEFT JOIN DimGeography D
on F.SalesTerritoryKey = D.SalesTerritoryKey
GROUP BY  F.CustomerKey,
	D.EnglishCountryRegionName
),
RegionalAvg AS
(
 SELECT *,
        AVG(AvgOrderValuePerCustomer) OVER (PARTITION BY Region) AS RegionalAvgOrderValue
    FROM BaseTable
)
SELECT*,
    CASE
        WHEN AvgOrderValuePerCustomer > RegionalAvgOrderValue THEN 'High'
        WHEN AvgOrderValuePerCustomer < RegionalAvgOrderValue THEN 'Low'
        ELSE 'Equal'
    END AS Comparison
FROM RegionalAvg



  
  3. Compare product performance within categories.
WITH BASETABLE AS
(SELECT P.EnglishProductName AS ProductName,
	S.EnglishProductSubCategoryName AS ProductSubCategoryName,
	C.EnglishProductCategoryName AS ProductCategoryName,
	Sum(F.SalesAmount) AS Revenue
FROM FactInternetSales F
LEFT JOIN DimProduct P
on P.ProductKey = F.ProductKey
LEFT JOIN DimProductSubCategory S
on S.ProductSubcategoryKey = P.ProductSubcategoryKey
LEFT JOIN DimProductCategory C
ON C.ProductCategoryKey = S.ProductCategoryKey
Group by P.EnglishProductName,
	S.EnglishProductSubCategoryName,
	C.EnglishProductCategoryName
)
SELECT ProductName,
	ProductSubCategoryName,
	ProductCategoryName,
	Revenue,
	RANK() OVER (PARTITION BY ProductCategoryName ORDER BY Revenue DESC) AS ProductRankWithinCategory
FROM BASETABLE
