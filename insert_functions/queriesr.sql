

UPDATE book_loans
SET late = CASE 
    WHEN Returned_date > due_date THEN 1
    WHEN Returned_date <= due_date THEN 0
    ELSE 0
    END;



ALTER TABLE library_branch
ADD LateFee INT

UPDATE library_branch
SET LateFee = CASE
        WHEN branch_name = 'Main Branch' THEN 10
        WHEN branch_name = 'West Branch' THEN 5
        WHEN branch_name = 'East Branch' THEN 5
        Else 2
        END;


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




