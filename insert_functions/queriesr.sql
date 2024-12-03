

ALTER TABLE library_branch
ADD LateFee INT;

UPDATE library_branch
SET LateFee = CASE
        WHEN branch_name = 'Main Branch' THEN 10
        WHEN branch_name = 'West Branch' THEN 5
        WHEN branch_name = 'East Branch' THEN 5
        Else 2
    END;





