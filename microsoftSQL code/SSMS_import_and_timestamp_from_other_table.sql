-- AUTHOR: Andrew Hitchcock 
-- Created on: 6/12/2020
-- PURPOSE: This code is intended to import and timestamp data from one table to another. 
--          The idea is that this can be used to copy and timestamp data from a linked server 
--          to a "historical records" table in a local server. 

-- NOTES:  adapt colomns and table names as necessary

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- create "people" table to start with and populate table  
-- (this will represent a table in a linked server)
-- (this will only work if data has already been loaded into the temp table.)
-- (loading data into temp is handled with the script: "SSMS_import_CSV_and_timestamp.sql" which should be in the same folder)
--DROP TABLE test.dbo.people
--CREATE TABLE test.dbo.people(
--	name	varchar(10), 
--	age	int, 
--	eye_color	varchar(10), 
--	gender	varchar(10)
--); 
--INSERT INTO test.dbo.people (name, age, eye_color, gender)
--	SELECT name, age, eye_color, gender
--	FROM test.dbo.temp
--SELECT * FROM test.dbo.people

-- clear  + create a table to copy data into
DROP TABLE test.dbo.temp
CREATE TABLE test.dbo.temp(
	name	varchar(10), 
	age	int, 
	eye_color	varchar(10), 
	gender	varchar(10)
); 

-- import data from the foreign table into a temporary table
INSERT INTO test.dbo.temp (name, age, eye_color, gender)
	SELECT name, age, eye_color, gender
	FROM test.dbo.people

-- timestamp the imported data 
ALTER TABLE test.dbo.temp
ADD 
[snapshot_date] date,
[snapshot_time]	time
UPDATE test.dbo.temp
SET 
[snapshot_date] = getdate(),
[snapshot_time] = CURRENT_TIMESTAMP

-- Copy the temp table into the historical_data table
INSERT INTO test.dbo.historical_data (name, age, eye_color, gender, snapshot_date, snapshot_time)
	SELECT name, age, eye_color, gender, snapshot_date, snapshot_time
	FROM test.dbo.temp;

-- show that the historical table is functioning
SELECT * 
FROM test.dbo.historical_data