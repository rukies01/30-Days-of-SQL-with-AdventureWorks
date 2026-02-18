### Day 9: Common Table Expressions (CTEs)

1. Use a CTE to calculate total sales per customer.



WITH CustomerSpend as
(SELECT C.CustomerKey AS CustomerKey,
	Sum(F.SalesAmount) AS TotalSales
From FactInternetSales F
LEFT JOIN DimCustomer C
on F.CustomerKey = C.CustomerKey
GROUP BY C.CustomerKey
)
SELECT CustomerKey,
	TotalSales
FROM CustomerSpend
ORDER BY TotalSales DESC

2. From that result, rank customers by spend.

WITH CustomerSpend as
(SELECT C.CustomerKey AS CustomerKey,
	Sum(F.SalesAmount) AS TotalSales
From FactInternetSales F
LEFT JOIN DimCustomer C
on F.CustomerKey = C.CustomerKey
GROUP BY C.CustomerKey
)
SELECT CustomerKey,
	TotalSales,
	Rank() over (Order by TotalSales desc) as CustomerRank,
	Dense_Rank() over (Order by TotalSales desc) as CustomerRank2
FROM CustomerSpend
ORDER BY TotalSales DESC

3. Identify customers above the 75th percentile.
  
WITH CustomerSpend as
(SELECT C.CustomerKey AS CustomerKey,
	Sum(F.SalesAmount) AS TotalSales
From FactInternetSales F
LEFT JOIN DimCustomer C
on F.CustomerKey = C.CustomerKey
GROUP BY C.CustomerKey
),
CustomerTile as
(
SELECT CustomerKey,
	TotalSales,
	Rank() over (Order by TotalSales) as CustomerRank,
	NTile(4) over (Order by TotalSales) as CustomerRank2
FROM CustomerSpend)
SELECT CustomerKey,
	TotalSales,
	CustomerRank2
FROM CustomerTile
where CustomerRank2 = 4  --I.E Top 25% above 75%
ORDER BY TotalSales DESC


