# This will connect to a local postgres server to pull data
# Server: [localhost]
# database: [postgres]
# port: [5432]
# uname: [postgres]
# passwd_file: secrets.py
# db name: sample_1
# table name:  public.inventory
# --------------------------------------------------------------------
import os, sys, psycopg2, secretspostgres, pandas as pd, time
from datetime import date
path = os.getcwd()
sys.path.insert(0,path)

server = 'localhost'
database_name = 'postgres'
port_number = '5432'
db_name = 'sample_1'
table_name = 'public.inventory'
username = secretspostgres.uname()
password1 = secretspostgres.passwd()

#get date to timestamp data
today = date.today()
# dd/mm/yy H:M:S
date = today.strftime(' %d/%m/%Y ')
time = time.strftime(' %H:%M:%S ')

#print('DEBUG --- current Date and time: ', date, time )

cnxn = psycopg2.connect(user=username,
                        password=password1,
                        host=server,
                        port=port_number,
                        database=db_name)

cursor = cnxn.cursor()

postgreSQL_selection_query = pd.read_sql_query('SELECT * FROM ' + table_name, cnxn)
print('as a dataframe: \n')
print(postgreSQL_selection_query)

#timestamp the data
postgreSQL_selection_query['date'] = date + time
print('\n\n Now with a date column')
print(postgreSQL_selection_query)
postgreSQL_selection_query.to_csv('output\postgres_data.csv')

with open('log\pull_from_postgres_completed_log.txt', 'a+') as file:
    file.write("\ncompleted at: "+date+time)
