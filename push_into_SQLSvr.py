# this file will push my data into mySQL svr

# NOTE: this code was modled after code found online at: https://datatofish.com/import-csv-sql-server-python/

# server type: Database Engine
# server name: ANDREWSDELL\SQLEXPRESS
# Authentication: Windows Auth
import pyodbc, pandas as pd, time
from datetime import date

data_location = 'output\\postgres_data.csv'
server_name = 'ANDREWSDELL\SQLEXPRESS'
# NOTE:: The connection string could contain credentials, but since this is a local server using windows authentication
# we can simply use: "Trusted_Connection=True"
connection_string = 'Driver={SQL Server};Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;'
database_name = 'test'
table_name = 'dbo.from_postgres'

#get time for log file
today = date.today()
# dd/mm/yy H:M:S
Current_date = today.strftime(' %d/%m/%Y ')
time = time.strftime(' %H:%M:%S ')

# convert the csv into a data frame
data = pd.read_csv (data_location)
df = pd.DataFrame( data, columns=['serial_no', 'function', 'operating_system', 'up_to_date', 'date'])
#print('-=-=-=-=-=-=-=-=-=-=-=-=-=-=- \n DEBUG\n ', df, '\n-=-=-=-=-=-=-=-=-=-=-=-=-=-\n')

# connect to the database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

for row in df.itertuples():
    cursor.execute('''
                INSERT INTO test.dbo.from_postgres (serial_no, role, operating_system, up_to_date, date)
                VALUES (?,?,?,?,?)
                ''',
                row.serial_no,
                row.function,
                row.operating_system,
                row.up_to_date,
                row.date,
                   )
conn.commit()

with open ('log\\push_to_SQL_Server_log.txt', 'a') as file:
    file.write('\npushed to server at: '+ Current_date + time)

