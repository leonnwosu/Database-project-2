SELECT * FROM vbookloaninfo;

UPDATE book_loans
SET late = CASE 
    WHEN Returned_date > due_date THEN 1
    WHEN Returned_date <= due_date THEN 0
    WHEN Returned_date = NULL AND CURRENT_DATE > due_date THEN 1
    else 0
    END;


ALTER TABLE borrower MODIFY card_no INT AUTO_INCREMENT;


