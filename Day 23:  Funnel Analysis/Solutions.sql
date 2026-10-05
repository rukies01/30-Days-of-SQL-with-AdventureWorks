Funnel Analysis
	
	Select COUNT( Distinct SalesOrderNumber) as TotalOrders,
		 Count 
			(Distinct CASE
			When ShipDate is NOT NULL Then SalesOrderNumber End) as TotalOrdersShipped,
			Count
			(Distinct CASE
				WHEN Shipdate <= DueDate THEN SalesOrderNumber End) as OrdersShippedonTime
	From FactInternetSales
	                  
	 Dropoff Analysis
	 
	 WITH Orders as
	 (
		Select COUNT( Distinct SalesOrderNumber) as TotalOrders,
		 Count 
			(Distinct CASE
			When ShipDate is NOT NULL Then SalesOrderNumber End) as TotalOrdersShipped,
			Count
			(Distinct CASE
				WHEN Shipdate <= DueDate THEN SalesOrderNumber End) as OrdersShippedonTime
	From FactInternetSales
	)
	Select ((TotalOrders - TotalOrdersShipped) * 100.0)/ (Nullif(TotalOrders, 0)) as DropOffPercentage_of_Orders,
			((TotalOrdersShipped-OrdersShippedonTime) *100.0) / Nullif(TotalOrdersShipped,0) as DropoffPercentage_of_Orders_Shipped
	From Orders
