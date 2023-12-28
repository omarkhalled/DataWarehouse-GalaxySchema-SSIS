use AdventureWorks2019

-- update product color
UPDATE AdventureWorks2019.Production.Product SET Product.Color = 'Fo7lo2y' 
WHERE Product.ProductNumber = 'GL-H102-M'
go
-- update product category
UPDATE AdventureWorks2019.Production.ProductSubcategory  SET ProductSubcategory.Name= 'Tlagat' 
WHERE ProductSubcategory.ProductSubcategoryID =20
