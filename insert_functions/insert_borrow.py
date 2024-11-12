import pandas as pd
import mysql.connector

# Load the CSV file into a DataFrame
df = pd.read_csv('C:/Users/nwosu/Database project 2/book_loans.csv', parse_dates=['date_check_out', 'due_date', 'returned_date'])

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
        "INSERT INTO borrow (card_no, IdNo, branch_id, date_check_out, due_date, returned_date) VALUES (%s, %s, %s, %s, %s, %s)",
        (int(row['card_no']), int(row['IdNo']), int(row['branch_id']), row['date_check_out'], row['due_date'], row['returned_date'] )
    )

conn.commit()
cursor.close()
conn.close()