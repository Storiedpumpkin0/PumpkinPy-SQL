# This will pull from SQL Svr and create a cvs file

# Author: Andrew Hitchcock
# Created on date: 6/10/2020

# --------------------------------------------------------------------------------------
import pyodbc, pandas as pd, time
from datetime import date

# Variables to connect to database1

server_name = 'ANDREWSDELL\SQLEXPRESS'
connection_string = 'Driver={SQL Server};Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;'
database_name = 'dnd.'
table_name = 'dbo.monsters'
code_location = 'microsoftSQL code\\test_sql.sql'

# this is the query to grab the entire table
contents = 'SELECT  * FROM ' + database_name + table_name

# This will get a date so stamp the data with
today = date.today()
# dd/mm/yy
date = today.strftime(' %d/%m/%Y ')
time = time.strftime(' %H:%M:%S ')

# make the connection to the database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

# execute a query against the database and add timestamp to data
query = pd.read_sql_query(contents, conn)
query['date'] = date
# print("\n-=-=-=-=-=-=-=-=-=-=-=- DEBUG: data as a data frame: \n", query, '\n =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=')

# this will save the results to a csv file
query.to_csv('output\SQLSvr'+database_name+table_name+'_data.csv')

# write to log to show completed process
with open('log\pull_from_SQLSvr_log.txt', 'a+') as file:
    file.write("\ncompleted at: "+date+time)

# close the connection to the database
conn.commit()