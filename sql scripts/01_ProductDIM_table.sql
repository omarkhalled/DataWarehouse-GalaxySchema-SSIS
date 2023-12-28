USE DW_AdventureWorks
go
-- Dropping the foreign keys from FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactInStoreSales_ProductDim'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_FactInStoreSales_ProductDim;
go

-- Dropping the foreign keys from FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactOnlineSales_ProductDim'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_FactOnlineSales_ProductDim;
go
-- Drop ProductDim table

DROP TABLE IF EXISTS ProductDim
go
-- Creating ProductDim table

CREATE TABLE ProductDim (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate key,
    ProductAlternateKey INT,  -- Alternate Key , Business key
	ProductNumber NVARCHAR(50) not null ,
    ProductName NVARCHAR(50),
	ProductDescription NVARCHAR(400),
    Color NVARCHAR(15),
	Size NVARCHAR(10),
    SizeUnitMeasureCode NVARCHAR(3),
    WeightUnitMeasureCode NVARCHAR(3),
    Weight DECIMAL(8,2),
    ReorderPoint SMALLINT,
    StandardCost MONEY,
    ListPrice MONEY,
	ProductCategory NVARCHAR(50),
    ProductSubcategory NVARCHAR(50),
    ProductModelName NVARCHAR(50),
	-- SCD
	StartDate DATETIME NOT NULL,
    EndDate   DATETIME,
    Status    NVARCHAR(10) DEFAULT('Current')
  )
go

 -- Creating foreign key in FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactInStoreSales')
  ALTER TABLE FactInStoreSales
    ADD CONSTRAINT fk_FactInStoreSales_ProductDim FOREIGN KEY (ProductKey)
    REFERENCES
    ProductDim(ProductKey);


 -- Creating foreign key in FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactOnlineSales')
  ALTER TABLE FactOnlineSales
    ADD CONSTRAINT fk_FactOnlineSales_ProductDim FOREIGN KEY (ProductKey)
    REFERENCES
    ProductDim(ProductKey);


 -- Creating indexes

IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_ProductDim_ProductKey' AND object_id = OBJECT_ID('Schema.ProductDim'))
DROP INDEX ProductDim.IX_ProductDim_ProductAlternateKey

CREATE INDEX  IX_ProductDim_ProductAlternateKey
ON ProductDim(ProductAlternateKey)

IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_ProductDim_ProductCategory' AND object_id = OBJECT_ID('Schema.ProductDim'))
DROP INDEX ProductDim.IX_ProductDim_ProductCategory
go
CREATE INDEX  IX_ProductDim_ProductCategory
ON ProductDim(ProductCategory)

go
--This script Inserts a dummy row:

--It uses SET IDENTITY_INSERT to allow explicit values in the identity column.
--Inserts a row with 0 in numeric or money columns, "Unknown" in NVARCHAR columns.
--Sets "Current" in the Status column, sets EndDate to NULL, and sets StartDate to "1900-01-01".

-- Before insert values 
SET IDENTITY_INSERT ProductDim ON;

-- Inserting a dummy row
INSERT INTO ProductDim (
    ProductKey,
    ProductAlternateKey,
	ProductNumber,
    ProductName,
    ProductDescription,
    Color,
    Size,
    SizeUnitMeasureCode,
    WeightUnitMeasureCode,
    Weight,
    ReorderPoint,
    StandardCost,
    ListPrice,
    ProductCategory,
    ProductSubcategory,
    ProductModelName,
    StartDate,
    EndDate,
    Status
) VALUES (
    0,
    0,
	'Unknown',
    'Unknown',
    'Unknown',
    'Unknown',
    'Unknown',
    'n',
    'n',
    0,
    0,
    0,
    0,
    'Unknown',
    'Unknown',
    'Unknown',
    '1900-01-01',
    NULL,
    'Current'
);

-- After insert values 
SET IDENTITY_INSERT ProductDim OFF;
