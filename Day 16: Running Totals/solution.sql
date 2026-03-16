### Day 16: Running Totals

1. Calculate cumulative sales by month.
WITH BaseTable AS
(
    SELECT 
        DATEPART(YEAR, OrderDate) AS OrderYear,
        DATEPART(MONTH, OrderDate) AS MonthNumber,
        SUM(SalesAmount) AS Revenue
    FROM FactInternetSales
    GROUP BY 
        DATEPART(YEAR, OrderDate),
        DATEPART(MONTH, OrderDate)
)
SELECT
    OrderYear,
    MonthNumber,
    Revenue,
    SUM(Revenue) OVER (
        ORDER BY OrderYear, MonthNumber
    ) AS CumulativeRevenue
FROM BaseTable
ORDER BY OrderYear, MonthNumber;



2. Running total of sales per customer.
WITH BaseTable AS
(
SELECT 
	C.CustomerKey AS CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerName,
	Cast(OrderDate AS Date) as OrderDate,
	SUM(SalesAmount) AS Revenue
From FactInternetSales F
Left Join DimCustomer C
ON F.CustomerKey = C.CustomerKey
Group By C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName),
	Cast(OrderDate AS Date)
)
SELECT *,
	SUM(Revenue) over (Partition By CustomerKey Order By OrderDate)
FROM BaseTable

3. Identify when cumulative sales crossed a threshold.   

WITH BASETABLE AS
(
SELECT
	P.ProductKey,
	P.EnglishProductName AS ProductName,
	C.EnglishProductCategoryName AS ProductCategory,
	 S.EnglishProductSubCategoryName AS ProductSubCategory,
	 Cast(F.OrderDate AS Date) as OrderDate,
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
	 S.EnglishProductSubCategoryName,
	 P.ProductKey,
	 Cast(F.OrderDate AS Date)
),
SalesByProduct AS
	(SELECT *,
	Sum(Revenue) over (Partition By ProductCategory Order by OrderDate) AS CummulativeRevenue,
	Sum(Revenue) Over (Partition By ProductCategory) * 0.5 as BenchMark
	FROM BASETABLE
	),
FilterRow AS
	(SELECT *,
	ROW_NUMBER() OVER (PARTITION BY ProductCategory ORDER BY OrderDate) AS FLAG
	FROM SalesByProduct
	WHERE CummulativeRevenue >= BenchMark
	)
SELECT
	OrderDate,
	ProductKey,
	ProductName,
	ProductCategory,
	BenchMark,
	FLAG,
	CummulativeRevenue
FROM FilterRow
Where FLAG = 1
