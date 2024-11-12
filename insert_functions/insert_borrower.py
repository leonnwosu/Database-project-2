import pandas as pd
import mysql.connector

# Load the CSV file into a DataFrame
df = pd.read_csv('C:/Users/nwosu/Database project 2/borrower.csv')

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
        "INSERT INTO borrower (card_no, Bo_name, adress, phone_number) VALUES (%s, %s, %s, %s)",
        (int(row['card_no']), row['Bo_name'], row['adress'], row['phone_number'])
    )

conn.commit()
cursor.close()
conn.close()
