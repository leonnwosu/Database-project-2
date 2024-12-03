
ALTER TABLE borrower ADD CONSTRAINT card_no UNIQUE (card_no);

INSERT INTO borrower (card_no, name, address, phone)
VALUES (NULL, 'Leon Nwosu', '5212 la viva ln', '682-804-3811');


UPDATE borrower
SET phone = '832-721-8965'
WHERE name = 'Leon Nwosu';


UPDATE book_copies 
JOIN library_branch AS LB ON book_copies.branch_id = LB.branch_id
SET book_copies.no_of_copies = book_copies.no_of_copies + 1
WHERE LB.branch_name = 'East Branch';


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


ALTER TABLE book_copies DROP FOREIGN KEY `book_copies_ibfk_2`;
ALTER TABLE library_branch DROP PRIMARY KEY;
ALTER TABLE library_branch MODIFY branch_id INT AUTO_INCREMENT PRIMARY KEY;

INSERT INTO library_branch(branch_name, branch_address)
VALUES
( 'North Branch', '456 NW, Irving TX 76100'),
( 'UTA Branch', '123 Cooper St, Arlington TX 76101');


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


SELECT BR.name
FROM borrower AS BR
JOIN book_loans AS B ON B.card_no = BR.card_no
WHERE B.returned_date IS NULL;


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

SELECT 
    B.title, 
    MAX(DATEDIFF(BL.due_date, BL.date_out)) AS max_days_borrowed
FROM 
    book AS B
JOIN 
    book_loans AS BL ON B.book_id = BL.book_id
GROUP BY 
    B.title;

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

SELECT BR.name, BR.address
FROM borrower AS BR
JOIN book_loans AS B ON B.card_no = BR.card_no
JOIN library_branch AS LB ON LB.branch_id = B.branch_id
WHERE LB.branch_name = 'West Branch';


--part III

--1

ALTER TABLE book_loans 
ADD late Boolean;

UPDATE book_loans
SET late = CASE 
    WHEN CURRENT_DATE > due_date THEN 1
    WHEN CURRENT_DATE <= due_date THEN 0
    END;

--2

ALTER TABLE library_branch
ADD LateFee INT

UPDATE library_branch
SET LateFee = CASE
        WHEN branch_name = 'Main Branch' THEN 10
        WHEN branch_name = 'West Branch' THEN 5
        WHEN branch_name = 'East Branch' THEN 5
        Else 2
        END;

--3

CREATE VIEW vBookLoanInfo AS
SELECT 
    bl.card_no AS Card_No,
    br.name AS Borrower_Name,
    bl.date_out AS Date_Out,
    bl.due_date AS Due_Date,
    bl.returned_date AS Returned_date,
    DATEDIFF(bl.returned_date, bl.date_out) AS TotalDays,
    b.book_title AS Book_Title,
    CASE
        WHEN bl.returned_date > bl.due_date THEN DATEDIFF(bl.returned_date, bl.due_date)
        ELSE 0
    END AS number_of_days_late,
    bl.branch_id AS Branch_ID,
    CASE 
        WHEN DATEDIFF(bl.returned_date, bl.due_date) > 0 AND lb.branch_name = 'Main Branch' THEN DATEDIFF(bl.returned_date, bl.due_date) * 10
        WHEN DATEDIFF(bl.returned_date, bl.due_date) > 0 AND lb.branch_name = 'West Branch' THEN DATEDIFF(bl.returned_date, bl.due_date) * 5
        WHEN DATEDIFF(bl.returned_date, bl.due_date) > 0 AND lb.branch_name = 'East Branch' THEN DATEDIFF(bl.returned_date, bl.due_date) * 5
        WHEN DATEDIFF(bl.returned_date, bl.due_date) > 0 AND lb.branch_name IS NOT NULL THEN DATEDIFF(bl.returned_date, bl.due_date) * 2
        ELSE 0
    END AS LateFeeBalance
FROM book_loans AS bl
JOIN book AS b ON b.book_id = bl.book_id
JOIN  borrower AS br ON br.card_no = bl.card_no
JOIN  library_branch AS lb ON lb.branch_id = bl.branch_id;



CREATE TRIGGER after_book_loan_insert
AFTER INSERT ON book_loans
FOR EACH ROW
BEGIN
    UPDATE Book_Copies
    SET no_of_copies = no_of_copies - 1
    WHERE book_id = NEW.book_id;
END;





