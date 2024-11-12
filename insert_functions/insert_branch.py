import pandas as pd
import mysql.connector

# Load the CSV file into a DataFrame
df = pd.read_csv('C:/Users/nwosu/Database project 2/library_branch.csv')

# Connect to the MySQL database
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Chukwuma@1231',
    database='library_db_management'
)
cursor = conn.cursor()

# Insert each row into the MySQL table
for index, row in df.iterrows():
     cursor.execute(
        "INSERT INTO library_branch (branch_id, branch_name, LB_address) VALUES (%s, %s, %s)",
        (int(row['branch_id']), row['branch_name'], row['LB_address'])
    )

conn.commit()
cursor.close()
conn.close()