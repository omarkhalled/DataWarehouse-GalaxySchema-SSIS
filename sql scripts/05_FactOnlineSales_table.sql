USE DW_AdventureWorks
go


DROP TABLE if exists FactOnlineSales;
go
CREATE TABLE FactOnlineSales
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
     CreatedAt     DATETIME NOT NULL DEFAULT(Getdate()),
     CONSTRAINT PK_FactOnlineSales PRIMARY KEY CLUSTERED (SalesOrderId, SalesOrderLineNumber
     ),
     CONSTRAINT fk_FactOnlineSales_ProductDim FOREIGN KEY (ProductKey) REFERENCES
     ProductDim(ProductKey),
     CONSTRAINT fk_FactOnlineSales_CustomerDim FOREIGN KEY (CustomerKey) REFERENCES
     CustomerDim(CustomerKey),
     CONSTRAINT fk_FactOnlineSales_TerritoryDim FOREIGN KEY (TerritoryKey)
     REFERENCES TerritoryDim(TerritoryKey),
     CONSTRAINT fk_fact_FactOnlineSales_DateDim_OrderDateKey FOREIGN KEY (OrderDateKey) REFERENCES
     DateDim(DateKey),
	 CONSTRAINT fk_fact_FactOnlineSales_DateDim_DueDateKey FOREIGN KEY (DueDateKey) REFERENCES
     DateDim(DateKey),
	 CONSTRAINT fk_fact_FactOnlineSales_DateDim_ShipDateKey FOREIGN KEY (ShipDateKey) REFERENCES
     DateDim(DateKey)
  );

-- Create Indexes
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactOnlineSales_ProductDim'
                  AND object_id = Object_id('FactOnlineSales'))
  DROP INDEX FactOnlineSales.IX_FactOnlineSales_ProductDim;

CREATE INDEX IX_FactOnlineSales_ProductDim
  ON FactOnlineSales(ProductKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactOnlineSales_CustomerDim'
                  AND object_id = Object_id('FactOnlineSales'))
  DROP INDEX FactOnlineSales.IX_FactOnlineSales_CustomerDim;

CREATE INDEX IX_FactOnlineSales_CustomerDim
  ON FactOnlineSales(CustomerKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactOnlineSales_TerritoryDim'
                  AND object_id = Object_id('FactOnlineSales'))
  DROP INDEX FactOnlineSales.IX_FactOnlineSales_TerritoryDim;

CREATE INDEX IX_FactOnlineSales_TerritoryDim
  ON FactOnlineSales(TerritoryKey);

IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'IX_FactOnlineSales_DateDim'
                  AND object_id = Object_id('FactOnlineSales'))
  DROP INDEX FactOnlineSales.IX_FactOnlineSales_DateDim;

CREATE INDEX IX_FactOnlineSales_DateDim
  ON FactOnlineSales(OrderDateKey); 