use DW_AdventureWorks
go

-- drop foreign keys FactOnlineSales
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactOnlineSales_DateDim_OrderDateKey'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_fact_FactOnlineSales_DateDim_OrderDateKey;
go

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactOnlineSales_DateDim_DueDateKey'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_fact_FactOnlineSales_DateDim_DueDateKey;
go

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactOnlineSales_DateDim_ShipDateKey'
                  AND parent_object_id = Object_id('FactOnlineSales'))
  ALTER TABLE FactOnlineSales
    DROP CONSTRAINT fk_fact_FactOnlineSales_DateDim_ShipDateKey;


go
-- drop foreign keys FactInStoreSales

-- drop foreign keys
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactInStoreSales_DateDim_OrderDateKey'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_fact_FactInStoreSales_DateDim_OrderDateKey;
go

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactInStoreSales_DateDim_DueDateKey'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_fact_FactInStoreSales_DateDim_DueDateKey;
go

IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_FactInStoreSales_DateDim_ShipDateKey'
                  AND parent_object_id = Object_id('FactInStoreSales'))
  ALTER TABLE FactInStoreSales
    DROP CONSTRAINT fk_fact_FactInStoreSales_DateDim_ShipDateKey;

go
drop table if exists DateDim
go
CREATE TABLE DateDim (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    DayOfWeek INT,
    DayOfYear INT,
    Weekday BIT,
    MonthName NVARCHAR(15),
    MonthShortName NVARCHAR(3),
    DayOfWeekName NVARCHAR(15),
    DayOfWeekShortName NVARCHAR(3),
    CONSTRAINT CK_ValidDate CHECK (FullDate >= '2004-01-01' AND FullDate <= '2025-01-01')
);

DECLARE @StartDate DATE = '2004-01-01';
DECLARE @EndDate DATE = '2025-01-01';

DECLARE @DateKey INT = 0;

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DateDim (DateKey, FullDate, Day, Month, Year, Quarter, DayOfWeek, DayOfYear, Weekday, MonthName, MonthShortName, DayOfWeekName, DayOfWeekShortName)
    VALUES (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        DATEPART(WEEKDAY, @StartDate),
        DATEPART(DAYOFYEAR, @StartDate),
        CASE WHEN DATEPART(WEEKDAY, @StartDate) BETWEEN 2 AND 6 THEN 1 ELSE 0 END,
        FORMAT(@StartDate, 'MMMM'),
        FORMAT(@StartDate, 'MMM'),
        DATENAME(WEEKDAY, @StartDate),
        LEFT(DATENAME(WEEKDAY, @StartDate), 3)
    );

    SET @DateKey = @DateKey + 1;
    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

