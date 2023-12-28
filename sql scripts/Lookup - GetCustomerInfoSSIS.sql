SELECT p.BusinessEntityID as PersonId,
CAST(
(isnull(p.FirstName,'') +' ' + isnull(p.MiddleName,'')+ ' ' + isnull(p.LastName,'')) as NVARCHAR(100)) as CustomerName
  , pa.City ,  pa.AddressLine1 , pp.PhoneNumber 
  FROM [AdventureWorks2019].[Person].[Person] p
  left join [AdventureWorks2019].[Person].[BusinessEntityAddress] pb
  on pb.BusinessEntityID = p.BusinessEntityID and pb.AddressTypeID = 2
  left join [AdventureWorks2019].[Person].[Address] pa
  on pa.AddressID = pb.AddressID  
  left join [AdventureWorks2019].[Person].[PersonPhone] pp
  on pp.BusinessEntityID = p.BusinessEntityID 
