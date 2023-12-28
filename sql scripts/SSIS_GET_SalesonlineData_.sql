SELECT
	[AdventureWorks2019].[Sales].[SalesOrderDetail].SalesOrderID,
	SalesOrderDetailID,
	OrderQty,
	ProductID,
	UnitPrice,
	UnitPriceDiscount,
	LineTotal,
	SalesOrderNumber,
	CONVERT(date, [AdventureWorks2019].[Sales].[SalesOrderHeader].OrderDate) AS OrderDate,
	CONVERT(date, [AdventureWorks2019].[Sales].[SalesOrderHeader].ShipDate) AS ShipDate,
	CONVERT(date, [AdventureWorks2019].[Sales].[SalesOrderHeader].DueDate) AS DueDate,
	CustomerID,
	TerritoryID,
	TaxAmt,
	Freight,
	OnlineOrderFlag
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
 join [AdventureWorks2019].[Sales].[SalesOrderDetail] 
 on [AdventureWorks2019].[Sales].[SalesOrderDetail].SalesOrderID = [AdventureWorks2019].[Sales].[SalesOrderHeader].SalesOrderID
where OnlineOrderFlag = 1
ORDER BY 1


