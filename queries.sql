--1
ALTER TABLE borrower ADD CONSTRAINT card_no UNIQUE (card_no);

INSERT INTO borrower (card_no, name, address, phone)
VALUES (NULL, 'Leon Nwosu', '5212 la viva ln', '682-804-3811');

--2
UPDATE borrower
SET phone = '832-721-8965'
WHERE name = 'Leon Nwosu';

--3
UPDATE book_copies 
JOIN library_branch AS LB ON book_copies.branch_id = LB.branch_id
SET book_copies.no_of_copies = book_copies.no_of_copies + 1
WHERE LB.branch_name = 'East Branch';

--4a
ALTER TABLE book_authors DROP FOREIGN KEY `book_authors_ibfk_1`;
ALTER TABLE book_copies DROP FOREIGN KEY `book_copies_ibfk_1`;
ALTER TABLE book_loans DROP FOREIGN KEY `book_loans_ibfk_1`;
ALTER TABLE book DROP PRIMARY KEY;
ALTER TABLE book MODIFY book_id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE book ADD PRIMARY KEY(book_id);

INSERT INTO book(title,book_publisher)
VALUES ('Harry potter and the Sorcerer''s Stone', 'Oxford Publishing');
INSERT INTO book_authors(book_id,author_name)
SELECT book_id, 'J.K. Rowling'
FROM Book
WHERE title = 'Harry Potter and the Sorcerer''s Stone';

--4b
ALTER TABLE book_copies DROP FOREIGN KEY `book_copies_ibfk_2`;
ALTER TABLE library_branch DROP PRIMARY KEY;
ALTER TABLE library_branch MODIFY branch_id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO library_branch(branch_name, branch_address)
VALUES
( 'North Branch', '456 NW, Irving TX 76100'),
( 'UTA Branch', '123 Cooper St, Arlington TX 76101');

--5
SELECT 
    b.title AS Book_Title, 
    lb.branch_name AS Branch_Name, 
    DATEDIFF(bl.due_date, bl.date_out) AS Days_Borrowed
FROM 
    Book_Loans bl
JOIN 
    Book b ON bl.book_id = b.book_id
JOIN 
    Library_Branch lb ON bl.branch_id = lb.branch_id
WHERE 
    bl.date_out BETWEEN '2022-03-05' AND '2022-03-23';

--6
SELECT BR.name
FROM borrower AS BR
JOIN book_loans AS B ON B.card_no = BR.card_no
WHERE B.returned_date IS NULL;

--7
SELECT 
    LB.branch_name, 
    COUNT(BL.book_id) AS borrowed_books_amount, 
    CASE 
        WHEN BL.returned_date IS NOT NULL THEN 'Returned'
        WHEN BL.returned_date IS NULL AND CURDATE() > BL.due_date THEN 'Late'
        WHEN BL.returned_date IS NULL AND CURDATE() <= BL.due_date THEN 'Still Borrowed'
    END AS book_status
FROM 
    book_loans AS BL
JOIN 
    library_branch AS LB ON LB.branch_id = BL.branch_id
GROUP BY 
    LB.branch_name, book_status;
--8
SELECT 
    B.title, 
    MAX(DATEDIFF(BL.due_date, BL.date_out)) AS max_days_borrowed
FROM 
    book AS B
JOIN 
    book_loans AS BL ON B.book_id = BL.book_id
GROUP BY 
    B.title;
--9
SELECT 
    B.title, 
    BA.author_name,
    DATEDIFF(BL.due_date, BL.date_out) AS days_borrowed,
    CASE 
        WHEN BL.returned_date IS NULL AND CURDATE() > BL.due_date THEN 'Late'
        WHEN BL.returned_date IS NULL AND CURDATE() <= BL.due_date THEN 'Still Borrowed'
        WHEN BL.returned_date IS NOT NULL THEN 'Returned'
    END AS book_status
FROM 
    borrower AS BR
JOIN 
    book_loans AS BL ON BR.card_no = BL.card_no
JOIN 
    book AS B ON BL.book_id = B.book_id
JOIN 
    book_authors AS BA ON B.book_id = BA.book_id
WHERE 
    BR.name = 'Ethan Martinez'
ORDER BY 
    BL.date_out;
--10
SELECT BR.name, BR.address
FROM borrower AS BR
JOIN book_loans AS B ON B.card_no = BR.card_no
JOIN library_branch AS LB ON LB.branch_id = B.branch_id
WHERE LB.branch_name = 'West Branch';
