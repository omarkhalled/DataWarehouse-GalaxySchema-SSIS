update [AdventureWorks2019].[Person].[Address] 
set [AdventureWorks2019].[Person].[Address].AddressLine1 = 'Shoubra' 
where [AdventureWorks2019].[Person].[Address].AddressID= 1


go
update [AdventureWorks2019].[Person].[Person]
set [AdventureWorks2019].[Person].[Person].FirstName = 'Omar'
where [AdventureWorks2019].[Person].[Person].BusinessEntityID = 2

