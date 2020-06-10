# This will pull from SQL Svr and create a cvs file

# Author: Andrew Hitchcock
# Created on date: 6/10/2020

# --------------------------------------------------------------------------------------
import pyodbc, pandas as pd, time
from datetime import date

# Variables to connect to database1

server_name = 'ANDREWSDELL\SQLEXPRESS'
connection_string = 'Driver={SQL Server};Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;'
database_name = 'test.'
table_name = 'dbo.from_postgres'
code_location = 'microsoftSQL code\\test_sql.sql'

# This will be to read sql from a file rather than typing it into the IDE
with open (code_location, 'r') as file:
    contents = file.read()
print(contents)

# make the connection to the database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

# execute a query against the database
query = pd.read_sql_query(contents, conn)
print(query)



