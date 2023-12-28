USE DW_AdventureWorks
GO
DROP TABLE if exists MetaControlData
CREATE TABLE MetaControlData (
	id int IDENTITY (1, 1),
	LastLoadDate datetime
);


INSERT INTO MetaControlData (LastLoadDate)
	VALUES ('1/1/1800')