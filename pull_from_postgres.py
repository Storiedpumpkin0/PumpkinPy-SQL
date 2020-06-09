# This will connect to a local postgres server to pull data
# Server: [localhost]
# database: [postgres]
# port: [5432]
# uname: [postgres]
# passwd_file: secrets.py
# db name: sample_1
# table name:  public.inventory
# --------------------------------------------------------------------

import psycopg2, pandas, secrets

server = 'localhost'
database_name = 'postgres'
port_number = '5432'
db_name = 'sample_1'
table_name = 'public.inventory'
username = secrets.uname()
password1 = secrets.passwd()

cnxn = psycopg2.connect(user=username,
                        password=password1,
                        host=server,
                        port=port_number,
                        database=db_name)

cursor = cnxn.cursor()

postgreSQL_selection_query = 'SELECT * FROM ' + table_name

cursor.execute(postgreSQL_selection_query)

print("Selecting rows from", table_name)
rows_in_table = cursor.fetchall()

for row in rows_in_table:
        print(row)