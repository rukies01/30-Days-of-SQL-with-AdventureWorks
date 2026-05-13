### Day 20: Advanced Analytics

1. Identify repeat customers.

	SELECT F.CustomerKey,
	CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName) AS CustomerFullName,
	Count(Distinct F.SalesOrderNumber)  AS OrderVolume
	From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
	GROUP BY F.CustomerKey,
	CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName)
	HAVING Count(Distinct F.SalesOrderNumber) > 1

-----Solving same issue another way
WITH BASETABLE AS
(
	SELECT F.CustomerKey,
	CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName) AS CustomerFullName,
	Count(Distinct F.SalesOrderNumber)  AS OrderVolume
	From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
	GROUP BY F.CustomerKey,
	CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName)
),
ACTIVITYFLAG AS
(
	SELECT *,
		CASE
			WHEN OrderVolume > 1 THEN 'Active'
			ELSE 'Inactive'
			End as ActivityFlag
	FROM BASETABLE
)
SELECT * FROM ACTIVITYFLAG
Where ActivityFlag = 'Active'

2. Time between customer purchases.
WITH BASETABLE AS
(
	SELECT CustomerKey,
		SalesOrderNumber AS SalesOrderNumber,
		Cast(OrderDate as Date) as CurrentOrderDate
		from FactInternetSales
),
INTERVAL AS
(
	SELECT *,
	LAG(CurrentOrderDate,1) OVER (Partition By CustomerKey Order By CurrentOrderDate,SalesOrderNumber) AS PreviousOrderDate
	FROM BASETABLE  ---added salesorderNumber for a more stable purchase sequence.
)
SELECT CustomerKey,
	SalesOrderNumber,
	CurrentOrderDate,
	PreviousOrderDate,
	DATEDIFF(DAY, PreviousOrderDate, CurrentOrderDate) AS TimeBetweenPurchases
FROM INTERVAL


3. Customer lifespan approximation.
WITH BASETABLE AS
(
	SELECT F.CustomerKey,
		CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName) AS CustomerFullName,
		Min(CAST(F.OrderDate as Date)) AS FirstPurchaseDate,
		Max(CAST(F.OrderDate as Date)) AS LastPurchaseDate
	From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
	GROUP BY F.CustomerKey,
		CONCAT(C.FirstName, ' ', ISNULL(C.MiddleName + ' ', ''), C.LastName) 
)
SELECT *,
	DATEDIFF(DAY, FirstPurchaseDate, LastPurchaseDate) AS CustomerLifeSpan
FROM BASETABLE

4.Customer lifetime value approximation

  SELECT F.CustomerKey,
	Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName) as CustomerFullName,
	SUM(SalesAmount) as CustomerLiftimeValue
From FactInternetSales F
	LEFT JOIN DimCustomer C
	ON F.CustomerKey = C.CustomerKey
Group BY F.CustomerKey,
	Concat(C.FirstName,' ',C.MiddleName, ' ', C.LastName)
Order by CustomerLiftimeValue desc
