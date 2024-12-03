from tkinter import *
import mysql.connector

# Create tkinter window
root = Tk()
root.title('Library Management System')
root.geometry("800x700")

# Connect to the DB and create a table
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Chukwuma@1231',
    database='library_MS'
)

cursor  = conn.cursor()

# Function to check out a book
def checkout_book():
    # Get values from entry fields
    cardNo = entry_cardNo.get()
    bookId = entry_bookId.get()
    branchId = entry_branchId.get()
    
    cursor.execute("""
        INSERT INTO book_loans (bookId, branchId, cardNo, dateOut, dueDate)
        VALUES (%s, %s, %s, NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY))
    """, (bookId, branchId, cardNo))
    conn.commit()
    
    print("Checked out book successfully")
    
    cursor.execute("""
        SELECT * FROM book_copies WHERE bookId = %s
    """, (bookId,))
    book_copies = cursor.fetchone()
    print("Updated book copies:", book_copies)

    # Show success message in the GUI
    result_label.config(text="Book checked out successfully!", fg="green")


# Function to add a new borrower
def new_borrower():
    # Get values from entry fields
    name = entry_name.get()
    address = entry_address.get()
    phone = entry_phone.get()
    
    cursor.execute("""
        INSERT INTO borrower (name, address, phone)
        VALUES (%s, %s, %s)
    """, (name, address, phone))
    conn.commit()
    
    print("New customer added successfully")
    
    # Retrieve the card number of the new borrower
    cursor.execute("""
        SELECT card_no FROM borrower WHERE name = %s
    """, (name,))
    new_customer = cursor.fetchone()
    card_no = new_customer[0] if new_customer else None
    
    # Show the new card number in the GUI
    result_label.config(text=f"New Borrower added! Card No: {card_no}", fg="blue")

def Add_book():
    title = entry_bookTitle.get()
    author = entry_bookAuthor.get()
    publisher = entry_bookpublisher.get()

    try:
        # Insert into the book table
        cursor.execute(""" 
            INSERT INTO book (title, book_publisher) 
            VALUES (%s, %s)
        """, (title, publisher))
        conn.commit()

        # Retrieve the last inserted book_id (AUTO_INCREMENT)
        cursor.execute("SELECT LAST_INSERT_ID()")
        bookId_result = cursor.fetchone()
        if not bookId_result:
            raise ValueError("Failed to retrieve book_id after insertion.")

        bookId = bookId_result[0]

        # Insert the author information
        cursor.execute(""" 
            INSERT INTO book_authors (book_id, author_name) 
            VALUES (%s, %s)
        """, (bookId, author))
        conn.commit()

        # Insert the book copies for all 3 branches
        cursor.execute(""" 
            INSERT INTO book_copies (book_id, branch_id, no_of_copies)
            VALUES 
            (%s, 1, 5), 
            (%s, 2, 5), 
            (%s, 3, 5)
        """, (bookId, bookId, bookId))
        conn.commit()

        print("Book added successfully with 5 copies in each of the 3 branches!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")
    except ValueError as ve:
        print(f"Validation Error: {ve}")
    finally:
        # Clear unread results
        while cursor.nextset():
            pass

def book_loans_per_branch():
    
    title = entry_bookTitle.get()

    cursor.execute(""" SELECT b.title, bc.branch_id, COUNT(bl.book_id) AS copies_loaned
                    FROM book_loans bl
                    JOIN book b ON bl.book_id = b.book_id
                    JOIN book_copies bc ON bl.book_id = bc.book_id AND bl.branch_id = bc.branch_id
                    WHERE b.title = %s 
                    GROUP BY bc.branch_id
                    ORDER BY bc.branch_id""", (title,))
    
    output = cursor.fetchall()

    if output:
        result_text = "Book Loans per Branch:\n"
        for row in output:
            result_text += f"Branch {row[1]}: {row[2]} copies loaned out\n"
        
        result_label.config(text=result_text, fg="blue")
    else:
        result_label.config(text="No loans found for this book title.", fg="red")

    print("query successful")

    
def get_late_book_loans():
    start_date = entry_Start_date.get()  # User inputs start date (format: YYYY-MM-DD)
    end_date = entry_end_date.get()      # User inputs end date (format: YYYY-MM-DD)

    
    # Execute the query with user-provided date range
    cursor.execute("""
        SELECT 
            bl.book_id , bl.branch_id, bl.card_no, bl.date_out, bl.due_date, bl.Returned_date,
            DATEDIFF(bl.Returned_date, bl.due_date) AS days_late
        FROM 
            book_loans bl
        WHERE 
            bl.due_date BETWEEN %s AND %s
            AND bl.Returned_date > bl.due_date
        ORDER BY 
            days_late DESC;
    """, (start_date, end_date))

    # Fetch results
    output = cursor.fetchall()

    # Process and display results
    if output:
        result_text = "Late Book Loans:\n"
        for row in output:
            result_text += (
                f" Book ID: {row[0]}, Branch ID: {row[1]}, "
                f"Card No: {row[2]}, date out: {row[3]}, due date: {row[4]}, "
                f"Date returned: {row[5]},Days Late: {row[6]}\n"
            )
        result_label.config(text=result_text, fg="blue")
    else:
        result_label.config(text="No late loans found within the given date range.", fg="red")

    print("Query executed successfully.")

   






# Create labels and entry fields for the 'New Borrower' section
Label(root, text="Name: ").grid(row=0, column=0, padx=10, pady=5)
entry_name = Entry(root, width=30)
entry_name.grid(row=0, column=1, padx=10, pady=5)

Label(root, text="Address: ").grid(row=1, column=0, padx=10, pady=5)
entry_address = Entry(root, width=30)
entry_address.grid(row=1, column=1, padx=10, pady=5)

Label(root, text="Phone: ").grid(row=2, column=0, padx=10, pady=5)
entry_phone = Entry(root, width=30)
entry_phone.grid(row=2, column=1, padx=10, pady=5)

# Create labels and entry fields for the 'Checkout Book' section
Label(root, text="Card No: ").grid(row=3, column=0, padx=10, pady=5)
entry_cardNo = Entry(root, width=30)
entry_cardNo.grid(row=3, column=1, padx=10, pady=5)

Label(root, text="Book ID: ").grid(row=4, column=0, padx=10, pady=5)
entry_bookId = Entry(root, width=30)
entry_bookId.grid(row=4, column=1, padx=10, pady=5)

Label(root, text="Branch ID: ").grid(row=5, column=0, padx=10, pady=5)
entry_branchId = Entry(root, width=30)
entry_branchId.grid(row=5, column=1, padx=10, pady=5)

Label(root, text="Book Title: ").grid(row=6, column=0, padx=10, pady=5)
entry_bookTitle = Entry(root, width=30)
entry_bookTitle.grid(row=6, column=1, padx=10, pady=5)


Label(root, text="publisher: ").grid(row=7, column=0, padx=10, pady=5)
entry_bookpublisher = Entry(root, width=30)
entry_bookpublisher.grid(row=7, column=1, padx=10, pady=5)

Label(root, text="Book Author: ").grid(row=8, column=0, padx=10, pady=5)
entry_bookAuthor = Entry(root, width=30)
entry_bookAuthor.grid(row=8, column=1, padx=10, pady=5)

Label(root, text="Start Date (format YYYY-MM-DD): ").grid(row=9, column=0, padx=10, pady=5)
entry_Start_date = Entry(root, width=30)
entry_Start_date.grid(row=9, column=1, padx=10, pady=5)

Label(root, text="End Date (format YYYY-MM-DD): ").grid(row=10, column=0, padx=10, pady=5)
entry_end_date = Entry(root, width=30)
entry_end_date.grid(row=10, column=1, padx=10, pady=5)


# Create buttons to trigger the functions
Button(root, text="Add Borrower", command=new_borrower).grid(row=11, column=0, columnspan=2, pady=10, padx=10, ipadx=100)
Button(root, text="Checkout Book", command=checkout_book).grid(row=12, column=0, columnspan=2, pady=10, padx=10, ipadx=100)
Button(root, text="Add New Book", command=Add_book).grid(row=13, column=0, columnspan=2, pady=10, padx=10, ipadx=100)
Button(root, text="list book per branch", command=book_loans_per_branch).grid(row=14, column=0, columnspan=2, pady=10, padx=10, ipadx=100)
Button(root, text="late returns", command=get_late_book_loans).grid(row=15, column=0, columnspan=2, pady=10, padx=10, ipadx=100)



# Label to display result message
result_label = Label(root, text="", font=("Arial", 12))
result_label.grid(row=12, column=0, columnspan=2, pady=10)

# Start the main loop for the GUI
root.mainloop()

# Close the DB connection after the GUI is closed
conn.close()