USE DW_AdventureWorks;
GO

DROP TABLE IF EXISTS FactInStoreSales;
GO

CREATE TABLE FactInStoreSales
  (
     ProductKey    INT NOT NULL,
     CustomerKey   INT NOT NULL,
     TerritoryKey  INT NOT NULL,
     OrderDateKey INT NOT NULL,
	 DueDateKey INT NOT NULL,
	 ShipDateKey INT NOT NULL,

     SalesOrderId VARCHAR(50) NOT NULL,
     SalesOrderLineNumber   INT NOT NULL,

     Quantity       INT,
     UnitPrice     MONEY,
     UnitCost      MONEY,
     TaxAmount     MONEY,
     Freight      MONEY,
     ExtendedSales MONEY,
     ExtenedCost   MONEY,
     CreatedAt     DATETIME NOT NULL DEFAULT(GETDATE()),
     CONSTRAINT PK_FactInStoreSales PRIMARY KEY CLUSTERED (SalesOrderId, SalesOrderLineNumber),
     CONSTRAINT fk_FactInStoreSales_ProductDim FOREIGN KEY (ProductKey) REFERENCES ProductDim(ProductKey),
     CONSTRAINT fk_FactInStoreSales_CustomerDim FOREIGN KEY (CustomerKey) REFERENCES CustomerDim(CustomerKey),
     CONSTRAINT fk_FactInStoreSales_TerritoryDim FOREIGN KEY (TerritoryKey) REFERENCES TerritoryDim(TerritoryKey),
     CONSTRAINT fk_fact_FactInStoreSales_DateDim_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES DateDim(DateKey),
	 CONSTRAINT fk_fact_FactInStoreSales_DateDim_DueDateKey FOREIGN KEY (DueDateKey) REFERENCES DateDim(DateKey),
	 CONSTRAINT fk_fact_FactInStoreSales_DateDim_ShipDateKey FOREIGN KEY (ShipDateKey) REFERENCES DateDim(DateKey)
  );

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactInStoreSales_ProductDim'
                  AND object_id = OBJECT_ID('FactInStoreSales'))
  DROP INDEX FactInStoreSales.IX_FactInStoreSales_ProductDim;

CREATE INDEX IX_FactInStoreSales_ProductDim
  ON FactInStoreSales(ProductKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactInStoreSales_CustomerDim'
                  AND object_id = OBJECT_ID('FactInStoreSales'))
  DROP INDEX FactInStoreSales.IX_FactInStoreSales_CustomerDim;

CREATE INDEX IX_FactInStoreSales_CustomerDim
  ON FactInStoreSales(CustomerKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactInStoreSales_TerritoryDim'
                  AND object_id = OBJECT_ID('FactInStoreSales'))
  DROP INDEX FactInStoreSales.IX_FactInStoreSales_TerritoryDim;

CREATE INDEX IX_FactInStoreSales_TerritoryDim
  ON FactInStoreSales(TerritoryKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactInStoreSales_DateDim'
                  AND object_id = OBJECT_ID('FactInStoreSales'))
  DROP INDEX FactInStoreSales.IX_FactInStoreSales_DateDim;

CREATE INDEX IX_FactInStoreSales_DateDim
  ON FactInStoreSales(OrderDateKey);
