USE DW_AdventureWorks
go
-- Dropping the foreign keys from FactInStoreSales
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactInStoreSales_TerritoryDim'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_FactInStoreSales_TerritoryDim;
go

-- Dropping the foreign keys from FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactOnlineSales_TerritoryDim'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_FactOnlineSales_TerritoryDim;
go


-- Drop CustomerDim table

DROP TABLE IF EXISTS TerritoryDim
go

-- Creating CustomerDim table

CREATE TABLE TerritoryDim
  (
     TerritoryKey      INT NOT NULL IDENTITY(1, 1) primary key,
     TerritoryID       INT NOT NULL,
     TerritoryName     NVARCHAR(50),
     TerritoryCountry  NVARCHAR(100),
     TerritoryGroup    NVARCHAR(50),
	 -- SCD
     StartDate        DATETIME NOT NULL DEFAULT (Getdate()),
     EndDate           DATETIME,
     Status         NVARCHAR(10) NOT NULL DEFAULT ('Current')
  
  );

go
 -- Creating foreign key in FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactInStoreSales')
  ALTER TABLE FactInStoreSales
    ADD CONSTRAINT fk_FactInStoreSales_TerritoryDim FOREIGN KEY (TerritoryKey)
    REFERENCES
    TerritoryDim(TerritoryKey);

go
 -- Creating foreign key in FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactOnlineSales')
  ALTER TABLE FactOnlineSales
    ADD CONSTRAINT fk_FactOnlineSales_TerritoryDim FOREIGN KEY (TerritoryKey)
    REFERENCES
    TerritoryDim(TerritoryKey);

 -- Creating indexes
 go
IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_TerritoryDim_TerritoryName' AND object_id = OBJECT_ID('Schema.TerritoryDim'))
DROP INDEX TerritoryDim.IX_TerritoryDim_TerritoryName

CREATE INDEX  IX_TerritoryDim_TerritoryName
ON TerritoryDim(TerritoryName)
go

IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_TerritoryDim_TerritoryCountry' AND object_id = OBJECT_ID('Schema.TerritoryDim'))
DROP INDEX TerritoryDim.IX_TerritoryDim_TerritoryCountry

CREATE INDEX  IX_TerritoryDim_TerritoryCountry
ON TerritoryDim(TerritoryCountry)

go 
--This script Inserts a dummy row:

--It uses SET IDENTITY_INSERT to allow explicit values in the identity column.
--Inserts a row with 0 in numeric or money columns, "Unknown" in NVARCHAR columns.
--Sets "Current" in the Status column, sets EndDate to NULL, and sets StartDate to "1900-01-01".
-- Before insert values 
SET IDENTITY_INSERT TerritoryDim ON;

-- Inserting a dummy row
INSERT INTO TerritoryDim (
    TerritoryKey,
    TerritoryID,
    TerritoryName,
    TerritoryCountry,
    TerritoryGroup,
    StartDate,
    EndDate,
    Status
) VALUES (
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
SET IDENTITY_INSERT TerritoryDim OFF;
