SELECT * 
FROM test.dbo.from_postgres

-- drop the test database 
DROP TABLE test.dbo.from_postgres
DROP DATABASE test


-- create the test database and add a composite primary key 
CREATE DATABASE test  
CREATE TABLE test.dbo.from_postgres(
	serial_no	varchar(5) NOT NULL,
	role	varchar(15) NOT NULL, 
	operating_system	varchar(10) NOT NULL, 
	up_to_date	varchar(3) NOT NULL,
	date date NOT NULL
	)
ALTER TABLE test.dbo.from_postgres
ADD CONSTRAINT PK_from_postgres
PRIMARY KEY (serial_no, date) 


CREATE TABLE test.dbo.junk(
num1	int	NOT NULL, 
num2	int	NOT NULL, 
num3	int NOT NULL
)