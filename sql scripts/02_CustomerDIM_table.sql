USE DW_AdventureWorks
go
-- Dropping the foreign keys from FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactInStoreSales_CustomerDim'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_FactInStoreSales_CustomerDim;
go

-- Dropping the foreign keys from FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactOnlineSales_CustomerDim'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_FactOnlineSales_CustomerDim;
go



-- Drop CustomerDim table

DROP TABLE IF EXISTS CustomerDim
go

-- Creating CustomerDim table

CREATE TABLE CustomerDim
  (
     CustomerKey      INT NOT NULL IDENTITY(1, 1) primary key,
     CustomerAlternateKey       INT NOT NULL,
     CustomerName      NVARCHAR(100),
     Address           NVARCHAR(100),
     City               NVARCHAR(30),
     PhoneNumber              NVARCHAR(25),
     StartDate         DATETIME NOT NULL DEFAULT (Getdate()),
     EndDate           DATETIME NULL,
     Status         NVARCHAR(10) DEFAULT ('Current'),
  
  );

go
 -- Creating foreign key in FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactInStoreSales')
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_FactInStoreSales_CustomerDim')
  ALTER TABLE FactInStoreSales
    ADD CONSTRAINT fk_FactInStoreSales_CustomerDim FOREIGN KEY (CustomerKey)
    REFERENCES
    CustomerDim(CustomerKey);

go
 -- Creating foreign key in FactOnlineSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactOnlineSales')
  ALTER TABLE FactOnlineSales
    ADD CONSTRAINT fk_FactOnlineSales_CustomerDim FOREIGN KEY (CustomerKey)
    REFERENCES
    CustomerDim(CustomerKey);


 -- Creating foreign key in FactInStoreSales

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'FactInStoreSales')
  ALTER TABLE FactInStoreSales
    ADD CONSTRAINT fk_FactInStoreSales_CustomerDim FOREIGN KEY (CustomerKey)
    REFERENCES
    CustomerDim(CustomerKey);

 -- Creating indexes
 go
IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_CustomerDim_CustomerAlternateKey' AND object_id = OBJECT_ID('Schema.CustomerDim'))
DROP INDEX CustomerDim.IX_CustomerDim_CustomerAlternateKey

CREATE INDEX  IX_CustomerDim_CustomerAlternateKey
ON CustomerDim(CustomerAlternateKey)
go
IF EXISTS (SELECT * 
			FROM sys.indexes 
			WHERE name='IX_CustomerDim_PhoneNumber' AND object_id = OBJECT_ID('Schema.CustomerDim'))
DROP INDEX CustomerDim.IX_CustomerDim_PhoneNumber
go
CREATE INDEX  IX_CustomerDim_PhoneNumber
ON CustomerDim(PhoneNumber)


go
--This script Inserts a dummy row:

--It uses SET IDENTITY_INSERT to allow explicit values in the identity column.
--Inserts a row with 0 in numeric or money columns, "Unknown" in NVARCHAR columns.
--Sets "Current" in the Status column, sets EndDate to NULL, and sets StartDate to "1900-01-01".

-- Before insert values 
SET IDENTITY_INSERT CustomerDim ON;

-- Inserting a dummy row
INSERT INTO CustomerDim (
    CustomerKey,
    CustomerAlternateKey,
    CustomerName,
    Address,
    City,
    PhoneNumber,
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
    '1900-01-01',
    NULL,
    'Current'
);

-- After insert values 
SET IDENTITY_INSERT CustomerDim OFF;
