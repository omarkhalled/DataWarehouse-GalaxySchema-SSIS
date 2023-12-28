SELECT ps.[ProductSubcategoryID]
      ,ps.Name as ProductSubcategory
      ,pc.Name as ProductCategory
  FROM [AdventureWorks2019].[Production].[ProductSubcategory] ps
  join [AdventureWorks2019].[Production].ProductCategory pc
  on ps.ProductCategoryID = pc.ProductCategoryID
union all
select null,null,null