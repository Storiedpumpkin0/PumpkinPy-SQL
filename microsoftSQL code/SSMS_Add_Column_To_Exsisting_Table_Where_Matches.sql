/*---------------------------------------------------------------------------------------------------------------------------------------
	AUTHOR: Andrew Hitchcock 
	Created on: 6/23/2020
	
	PURPOSE:	This code is intended to import data from a csv file 
				and combine it with specific rows within a pre-exsisting table. 

	NOTES:		
		--	Adapt colomns, file locations, and table names as necessary
		--	This example relies on a pre-esxisting "Origin" table
	
						
WARNING ! ! ! ! WARNING! ! ! ! ! WARNING ! ! ! ! WARNING! ! ! ! ! WARNING ! ! ! ! WARNING! ! ! ! ! WARNING ! ! ! ! WARNING! ! ! ! ! WARNING 
	
					-- This script will DROP anything at :
							test.dbo.temp
							test.dbo.csv_temp
 
----------------------------------------------------------------------------------------------------------------------------------------*/ 

-- create a csv_temp table

CREATE TABLE test.dbo.csv_temp(	
	ID varchar(50), 
	new_column varchar(50)   
	)

-- load data from csv into csv_temp table
BULK INSERT test.dbo.csv_temp 
FROM 'path/to/file.csv'
WITH(
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0A' /* <-- this is unicode for "LF" (line feed) */  
	)

--create temp table to join data from the two tables
DROP TABLE test.dbo.temp
CREATE TABLE test.dbo.temp(
	ID	varchar(10),
	old_column1	varchar(10),
	old_column2	varchar(10),
	new_column	varchar(10)
	) 

-- combine the data from the csv_temp table and the origin 
INSERT INTO test.dbo.temp (ID, old_column1, old_column2, new_column)
	SELECT DISTINCT 
	FROM	test.dbo.csv_temp c
	JOIN	test.dbo.orin o on o.ID = c.ID 

-- do some cleanup 
DROP TABLE test.dbo.csv_temp