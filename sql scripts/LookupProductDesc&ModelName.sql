SELECT pm.[ProductModelID]
      ,pm.[Name]
      ,pd.Description 
  FROM [AdventureWorks2019].[Production].[ProductModel] pm
  left join [AdventureWorks2019].Production.ProductModelProductDescriptionCulture pdc on
  pdc.ProductModelID = pm.ProductModelID
  left join [AdventureWorks2019].Production.ProductDescription pd
  on pd.ProductDescriptionID = pdc.ProductDescriptionID
  where pdc.CultureID = 'en' or pdc.CultureID is null
order by pm.[ProductModelID]

