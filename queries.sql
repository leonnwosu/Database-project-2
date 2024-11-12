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