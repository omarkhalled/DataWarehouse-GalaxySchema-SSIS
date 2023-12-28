USE DW_AdventureWorks
go

IF EXISTS (SELECT * 
           FROM   sys.tables 
           WHERE  NAME = 'lookup_country') 
  DROP TABLE lookup_country; 

CREATE TABLE lookup_country 
  ( 
     CountryId     INT NOT NULL IDENTITY(1, 1), 
     CountryName  NVARCHAR(50) NOT NULL, 
     CountryCode   NVARCHAR(2) NOT NULL, 
     CountryRegion NVARCHAR(50) 
  ); 

INSERT INTO lookup_country 
            (CountryName , 
             CountryCode, 
             CountryRegion) 
VALUES      ('United States', 'US', 'North America'), 
            ('Canada', 'CA', 'North America'), 
            ('France', 'FR', 'Europe'), 
            ('Germany', 'DE', 'Europe'), 
            ('Australia', 'AU', 'Pacific'), 
            ('United Kingdom', 'GB', 'Europe'); 