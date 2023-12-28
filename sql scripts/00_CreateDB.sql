USE master
go
IF Db_id('DW_AdventureWorks') IS NOT NULL
  DROP DATABASE DW_AdventureWorks;

CREATE DATABASE DW_AdventureWorks
go 