import pandas as pd
import mysql.connector

# Load the CSV file into a DataFrame
df = pd.read_csv('C:/Users/nwosu/Database project 2/book_library_db.csv')

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
        "INSERT INTO book (IdNo, title, publisher_name) VALUES (%s, %s, %s)",
        (int(row['IdNo']), row['title'], row['publisher_name'])
    )

conn.commit()
cursor.close()
conn.close()
