--1
ALTER TABLE borrower DROP CONSTRAINT card_no;

ALTER TABLE borrower ADD CONSTRAINT card_no UNIQUE (card_no);

INSERT INTO borrower (card_no,Bo_name, adress, phone_number)
VALUES(NULL ,'Leon Nwosu', '5212 la viva ln','682-804-3811');


--2
UPDATE borrower
SET phone_number = '(832)721-8965'
WHERE Bo_name = 'Leon Nwosu';


--3
UPDATE book_copies 
JOIN library_branch AS LB ON book_copies.branch_id = LB.branch_id
SET book_copies.no_of_copies = book_copies.no_of_copies + 1
WHERE LB.branch_name = 'East Branch';


--4a
ALTER TABLE book MODIFY IdNo INT AUTO_INCREMENT;

INSERT INTO book(title,publisher_name)
VALUES ('Harry potter and the Sorcerer''s Stone', 'Oxford Publishing');
INSERT INTO book_author
VALUES((SELECT IdNo FROM book WHERE title = 'Harry potter and the Sorcerer''s Stone' ),'J.K Rowling' );


--4b
ALTER TABLE library_branch MODIFY branch_id INT AUTO_INCREMENT;

INSERT INTO library_branch(branch_name, LB_address)
VALUES( 'North Branch', '456 NW, Irving TX 76100'),
( 'UTA Branch', '123 Cooper St, Arlington TX 76101');

--5
SELECT B.title, LB.branch_name, DATEDIFF(BR.returned_date, BR.date_check_out) AS days_borrowed_for
FROM book AS B
JOIN borrow AS BR ON BR.IdNo = B.IdNo
JOIN library_branch AS LB ON LB.branch_id = BR.branch_id
WHERE DATEDIFF(BR.returned_date, BR.date_check_out) AS days_borrowed_for;

--6
SELECT BR.Bo_name
FROM borrower AS BR
JOIN borrow AS B ON B.card_no = BR.card_no
WHERE B.returned_date IS NULL;

--7
SELECT LB.branch_name, COUNT(BR.IdNo) AS borrowed_books_amount, CASE 
WHEN BR.returned_date IS NOT NULL THEN 'Returned'
WHEN BR.returned_date IS NULL AND CURDATE() > BR.due_date THEN 'Late'
WHEN BR.returned_date IS NULL AND CURDATE() <= BR.due_date THEN 'Still Borrowed'
END AS book_status
FROM borrow AS BR
JOIN library_branch AS LB ON LB.branch_id = BR.branch_id
GROUP BY LB.branch_name, book_status;

--8

--9


--10
SELECT BR.Bo_name, BR.adress
FROM borrower AS BR
JOIN borrow AS B ON B.card_no = BR.card_no
JOIN library_branch AS LB ON LB.branch_id = B.branch_id
WHERE LB.branch_name = 'West Branch'