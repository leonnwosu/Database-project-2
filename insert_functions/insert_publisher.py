import pandas as pd
import mysql.connector

# Load the CSV file into a DataFrame
df = pd.read_csv('C:/Users/nwosu/Database project 2/publisher_table.csv')

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
        "INSERT INTO publisher (publisher_name, phone_number, P_address) VALUES (%s, %s, %s)",
        ((row['publisher_name']), row['phone_number'], row['P_address'])
    )

conn.commit()
cursor.close()
conn.close()
