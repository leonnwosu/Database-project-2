from tkinter import *
import mysql
import mysql.connector
#create tkinter window
root = Tk()
root.title('Library MS')
root.geometry("400x400")
#Connect to the DB and create a table
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Chukwuma@1231',
    database='library_MS'
)
add_book_c = conn.cursor()
def submit():
    submit_conn = mysql.connect('Library_MS')
    submit_cur = submit_conn.cursor()
    submit_conn.commit()
    submit_conn.close()
    #given city and state return first and last name


def input_query():
    iq_conn = mysql.connect('library_MS')
    iq_cur = iq_conn.cursor()
    
# add_book_c.execute('''CREATE TABLE ADDRESSES(FIRST_NAME TEXT,
# LAST_NAME TEXT,
# ADDRESS TEXT,
# CITY TEXT,
# STATE TEXT,
# ZIPCODE INT)
# ''')
#define all GUI components in the tkinter root window
#pack -- grid -- place
#define all textboxes
f_name = Entry(root, width = 30)
f_name.grid(row = 0, column = 1, padx = 20)
l_name = Entry(root, width = 30)
l_name.grid(row = 1, column =1)
street = Entry(root, width = 30)
street.grid(row = 2, column =1)
city = Entry(root, width = 30)
city.grid(row = 3, column =1)
state = Entry(root, width = 30)
state.grid(row = 4, column =1)
zcode = Entry(root, width = 30)
zcode.grid(row = 5, column =1)
#define labels
f_name_label = Label(root, text ='First Name: ')
f_name_label.grid(row = 0, column = 0)
l_name_label = Label(root, text = 'Last Name: ')
l_name_label.grid(row = 1, column = 0)
street_label = Label(root, text = 'Street: ')
street_label.grid(row = 2, column = 0)
city_label = Label(root, text = 'City: ')
city_label.grid(row = 3, column = 0, sticky = "w")
state_label = Label(root, text = 'State: ')
state_label.grid(row = 4, column = 0)
zcode_label = Label(root, text = 'Zipcode: ')
zcode_label.grid(row = 5, column = 0)
#create buttons to access db
submit_btn = Button(root, text = "Add Address", command = submit)
submit_btn.grid(row = 6, column = 0, columnspan = 2, pady = 10, padx = 10, ipadx =
100)
input_query_btn = Button(root, text = "Show Records", command = input_query)
input_query_btn.grid(row = 7, column = 0, columnspan = 2, pady = 10, padx = 10,
ipadx = 100)
root.mainloop()