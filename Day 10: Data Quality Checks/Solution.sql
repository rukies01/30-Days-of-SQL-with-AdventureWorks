
1. Find orders with missing customer information.
SELECT 
	C.CustomerKey,
	CONCAT(C.FirstName,' ', COALESCE(C.MiddleName+' ', ''), C.LastName) AS CustomerFullName,
	F.SalesOrderNumber,
	F.SalesOrderLineNumber
From FactInternetSales F
LEFT JOIN DimCustomer C
ON F.CustomerKey = C.CustomerKey
Where C.CustomerKey is Null


2. Detect duplicate records.
SELECT 
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS RecordCount
FROM FactInternetSales
GROUP BY 
    SalesOrderNumber,
    SalesOrderLineNumber
HAVING COUNT(*) > 1

3. Identify negative or zero values where they shouldn’t exist.
SELECT 
	SalesAmount,
	UnitPrice,
	OrderQuantity
FROM FactInternetSales
Where SalesAmount <= 0
	OR UnitPrice <= 0
	OR OrderQuantity <= 0
