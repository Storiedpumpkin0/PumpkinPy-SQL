-- AUTHOR: Andrew Hitchcock 
-- Created on: 6/12/2020
-- PURPOSE: This code is intended to import and timestamp data from a csv file

-- NOTES:  adapt colomns, file locations, and table names as necessary

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- variables 
DECLARE @file VARCHAR(max) = 'C:\Users\Andrew\Documents\Python_playground\python_and_sql\PumpkinPy-SQL\microsoftSQL code\monsters\sample.csv'

-- clear table to get things started
DROP TABLE test.dbo.temp

-- Create a tabe to import the csv 
CREATE TABLE test.dbo.temp(
	name	varchar(10), 
	age	int, 
	eye_color	varchar(10), 
	gender	varchar(10)
); 

-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 -- The Following code will set up a historical data table. 
 -- This only has to be done once, so it can stay commented out when not necessary 

--DROP TABLE test.dbo.historical_data
--CREATE TABLE test.dbo.historical_data(
--	name	varchar(10) NOT NULL, 
--	age	int, 
--	eye_color	varchar(10), 
--	gender	varchar(10),
--	snapshot_date	date NOT NULL, 
--	snapshot_time	time NOT NULL, 
--	CONSTRAINT PK_historical_data_sample_csv PRIMARY KEY (name, snapshot_date, snapshot_time)
--);
-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

-- This will use the variable file name and import the file into the temp table
DECLARE @SQL_BULK VARCHAR(max)
SET @SQL_BULK = 'BULK INSERT test.dbo.temp
	FROM ''' + @file + '''
	WITH 
	(
	FIRSTROW = 0,
	FIELDTERMINATOR = '','', 
	ROWTERMINATOR =''\n''
	);
'
EXEC (@SQL_BULK)

-- timestamp the imported data 
ALTER TABLE test.dbo.temp
ADD 
[snapshot_date] date,
[snapshot_time]	time
UPDATE test.dbo.temp
SET 
[snapshot_date] = getdate(),
[snapshot_time] = CURRENT_TIMESTAMP


-- Copy the csv table into the historical_data table
INSERT INTO test.dbo.historical_data (name, age, eye_color, gender, snapshot_date, snapshot_time)
	SELECT name, age, eye_color, gender, snapshot_date, snapshot_time
	FROM test.dbo.temp

-- show that the historical table is functioning
SELECT * 
FROM test.dbo.historical_data
ORDER BY snapshot_date, snapshot_time