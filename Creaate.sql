CREATE Database LMS;
USE LMS;

CREATE TABLE Book (
	book_id INT PRIMARY KEY,
	title VARCHAR(255),
	book_publisher VARCHAR (255)
);
CREATE TABLE Library_Branch (
	branch_id INT PRIMARY KEY,
	branch_name VARCHAR(255),
	branch_address VARCHAR(255)
);
CREATE TABLE Book_Authors (
	book_id INT,
	author_name VARCHAR (255),
	FOREIGN KEY (book_id) REFERENCES Book(book_id)
);
CREATE TABLE Book_Copies (
	book_id INT ,
	branch_id INT,
	no_of_copies INT,
	FOREIGN KEY(book_id) REFERENCES Book(book_id),
	FOREIGN KEY (branch_id) REFERENCES Library_Branch (branch_id)
);
CREATE TABLE Book_Loans (
    	book_id INT,
    	branch_id INT,
   	card_no INT,
    	date_out DATE,
	due_date DATE,
	Returned_date DATE,
	FOREIGN KEY(book_id) REFERENCES Book(book_id)
);
CREATE TABLE Borrower (
	card_no INT,
	name VARCHAR(255),
	address VARCHAR (255),
	phone VARCHAR(255)
);
CREATE TABLE Publisher (
	publisher_name VARCHAR(255) PRIMARY KEY,
	phone VARCHAR(255),
	address VARCHAR(255)
);

INSERT INTO Book (book_id,title,book_publisher)
VALUES
(1,'To Kill a Mockingbird','HarperCollins'),
(2,'1984','Penguin Books'),
(3,'Pride and Prejudice','Penguin Classics'),
(4,'The Great Gatsby','Scribner'),
(5,'One Hundred Years of Solitude','Harper & Row'),
(6,'Animal Farm','Penguin Books'),
(7,'The Catcher in the Rye','"Little, Brown and Company"'),
(8,'Lord of the Flies','Faber and Faber'),
(9,'Brave New World','Chatto & Windus'),
(10,'The Picture of Dorian Gray','"Ward, Lock and Co."'),
(11,'The Alchemist','HarperCollins'),
(12,'The God of Small Things','Random House India'),
(13,'Wuthering Heights','Thomas Cautley Newby'),
(14,'The Hobbit','Allen & Unwin'),
(15,'The Lord of the Rings','Allen & Unwin'),
(16,'The Hitchhiker''s Guide to the Galaxy','Pan Books'),
(17,'The Diary of a Young Girl','Bantam Books'),
(18,'The Da Vinci Code','Doubleday'),
(19,'The Adventures of Huckleberry Finn','Penguin Classics'),
(20,'The Adventures of Tom Sawyer','American Publishing Company'),
(21,'A Tale of Two Cities','Chapman and Hall');

INSERT INTO Book_Authors(book_id,author_name)
VALUES
(1,'Harper Lee'),
(2,'George Orwell'),
(3,'Jane Austen'),
(4,'F. Scott Fitzgerald'),
(5,'Gabriel Garcia Marquez'),
(6,'George Orwell'),
(7,'J.D. Salinger'),
(8,'William Golding'),
(9,'Aldous Huxley'),
(10,'Oscar Wilde'),
(11,'Paulo Coelho'),
(12,'Arundhati Roy'),
(13,'Emily Bronte'),
(14,'J.R.R. Tolkien'),
(15,'J.R.R. Tolkien'),
(16,'Douglas Adams'),
(17,'Anne Frank'),
(18,'Dan Brown'),
(19,'Mark Twain'),
(20,'Mark Twain'),
(21,'Charles Dickens');

INSERT INTO Library_Branch(branch_id,branch_name,branch_address)
VALUES
(1,'Main Branch','123 Main St, New York, NY 10003'),
(2,'West Branch','456 West St, Arizona, AR 70622'),
(3,'East Branch','789 East St, New Jersy, NY 32032');

INSERT INTO Book_Copies(book_id,branch_id,no_of_copies)
VALUES
(1,1,3),
(2,1,2),
(3,2,1),
(4,3,4),
(5,1,5),
(6,2,3),
(7,2,2),
(8,3,1),
(9,1,4),
(10,2,2),
(11,1,3),
(12,3,2),
(13,3,1),
(14,1,5),
(15,3,1),
(16,2,3),
(17,3,2),
(18,3,2),
(19,1,5),
(20,3,1),
(21,3,1);

INSERT INTO Book_Loans(book_id,branch_id,card_no,date_out,due_date,Returned_date)
VALUES
(1,1,123456,'2022-01-01','2022-02-01','2022-02-01'),
(2,1,789012,'2022-01-02','2022-02-02',NULL),
(3,2,345678,'2022-01-03','2022-02-03',NULL),
(4,3,901234,'2022-01-04','2022-02-04','2022-02-04'),
(5,1,567890,'2022-01-05','2022-02-05','2022-02-09'),
(6,2,234567,'2022-01-06','2022-02-06','2022-02-10'),
(7,2,890123,'2022-01-07','2022-02-07','2022-03-08'),
(8,3,456789,'2022-01-08','2022-02-08','2022-03-10'),
(9,1,111111,'2022-01-09','2022-02-09','2022-02-06'),
(10,2,222222,'2022-01-10','2022-02-10','2022-02-07'),
(11,1,333333,'2022-03-01','2022-03-08','2022-03-08'),
(12,3,444444,'2022-03-03','2022-03-10','2022-03-10'),
(13,3,555555,'2022-02-03','2022-03-03','2022-02-18'),
(14,1,565656,'2022-01-14','2022-02-14','2022-03-31'),
(15,3,676767,'2022-01-15','2022-02-15','2022-02-21'),
(16,2,787878,'2022-03-05','2022-03-12','2022-03-24'),
(17,3,989898,'2022-03-23','2022-03-30','2022-03-30'),
(18,3,121212,'2022-01-18','2022-02-18','2022-02-18'),
(19,1,232323,'2022-03-24','2022-03-31','2022-03-31'),
(20,3,343434,'2022-01-21','2022-02-21','2022-02-21'),
(21,3,454545,'2022-01-24','2022-02-24','2022-02-24');

INSERT INTO Borrower(card_no,name,address,phone)
VALUES
(123456,'John Smith','456 Oak St, Arizona, AR 70010','205-555-5555'),
(789012,'Jane Doe','789 Maple Ave, New Jersey, NJ 32542','555-235-5556'),
(345678,'Bob Johnson','12 Elm St, Arizona, AR 70345 ','545-234-5557'),
(901234,'Sarah Kim','345 Pine St, New York, NY 10065','515-325-2158'),
(567890,'Tom Lee','678  S Oak St, New York, NY 10045','209-525-5559'),
(234567,'Emily Lee','389 Oaklay St, Arizona, AR 70986','231-678-5560'),
(890123,'Michael Park','123 Pinewood St, New Jersey, NJ 32954','655-890-2161'),
(456789,'Laura Chen','345 Mapman Ave, Arizona, AR 70776','565-985-9962'),
(111111,'Alex Kim','983 Sine St, Arizona, AR 70451','678-784-5563'),
(222222,'Rachel Lee','999 Apple Ave, Arizona, AR 70671','231-875-5564'),
(333333,'William Johnson','705 Paster St, New Jersey 32002','235-525-5567'),
(444444,'Ethan Martinez','466 Deeplm St, New York, NY 10321','555-555-5569'),
(555555,'Grace Hernandez','315 Babes St, Arizona, AR 70862 ','455-567-5587'),
(565656,'Sophia Park','678 Dolphin St, New York, NY 10062','675-455-5568'),
(676767,'Olivia Lee','345 Spine St, New York, NY 10092','435-878-5569'),
(787878,'Noah Thompson','189 GreenOak Ave, New Jersey, NJ 32453','245-555-5571'),
(989898,'Olivia Smith','178 Elm St, New Jersey, NJ 32124','325-500-5579'),
(121212,'Chloe Park','345 Shark St, Arizona, AR 72213','755-905-5572'),
(232323,'William Chen','890 Sting St, New York, NY 10459','406-755-5580'),
(343434,'Olivia Johnson','345 Pine St, New Jersey, NJ 32095','662-554-5575'),
(454545,'Dylan Kim','567 Cowboy way St, New Jersey, NJ 32984','435-254-5578');

INSERT INTO Publisher(publisher_name,phone,address)
VALUES
('HarperCollins','212-207-7000','"195 Broadway, New York, NY 10007"'),
('Penguin Books','212-366-3000','"475 Hudson St, New York, NY 10014"'),
('Penguin Classics','212-366-2000','"123 Main St, California, CA 01383"'),
('Scribner','212-207-7474','"19 Broadway, New York, NY 10007"'),
('Harper & Row','212-207-7000','"1195 Border street, Montana, MT 59007"'),
('"Little, Brown and Company"','212-764-2000','"111 Huddle St, New Jersey, NJ 32014"'),
('Faber and Faber','201-797-3800','"463 south centre street, Arizona, AR 71653"'),
('Chatto & Windus','442-727-3800','"Bloomsbury House, 7477 Great Russell St, Arizona, AR 72965"'),
('"Ward, Lock and Co."','647-242-3434','"456 Maple Ave, Texas, TX 76013 "'),
('Random House India','291-225-6634','"423 baywatch centre street, Alabama, AL 30513"'),
('Thomas Cautley Newby','243-353-2352','"890 Elmwood Dr, Floride, FL 98238"'),
('Allen & Unwin','212-782-9001','"22 New Wharf Rd, Arizona, AR 70654"'),
('Pan Books','313-243-5353','"567 Pine Tree Rd, Colorado, CO 87348"'),
('Bantam Books','313-243-5354','"1745 Broadway, New York, NY 10019"'),
('Doubleday','212-782-9000','"789 Division St, Minnesota, MN 55344"'),
('American Publishing Company','682-243-3524','"7652 Northgate way lane, Georgia, GA 30054"'),
('Chapman and Hall','833-342-2343','"789 Oak St, Texas, TX 76010"');

SELECT 'Book' AS table_name, COUNT(*) AS total_records FROM Book;
SELECT 'Library_Branch' AS table_name, COUNT(*) AS total_records FROM Library_Branch;
SELECT 'Book_Authors' AS table_name, COUNT(*) AS total_records FROM Book_Authors;
SELECT 'Book_Copies' AS table_name, COUNT(*) AS total_records FROM Book_Copies;
SELECT 'Book_Loans' AS table_name, COUNT(*) AS total_records FROM Book_Loans;
SELECT 'Borrower' AS table_name, COUNT(*) AS total_records FROM Borrower;
SELECT 'Publisher' AS table_name, COUNT(*) AS total_records FROM Publisher;
