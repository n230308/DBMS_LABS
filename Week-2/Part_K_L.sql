USE Taxation_Info;

/*Part-K*/
--task1
SELECT full_name, annual_income
FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
--task2
SELECT full_name, annual_income FROM Taxpayer
WHERE annual_income > ANY (
    SELECT annual_income FROM Taxpayer
    WHERE taxpayer_id IN (
        SELECT taxpayer_id
        FROM Income_Record
        WHERE category_id = (
            SELECT category_id
            FROM Income_Category
            WHERE category_name = 'Business'
        )
    )
);

/*PartL*/
--task1
SELECT full_name, annual_income FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income
    FROM Taxpayer
    WHERE occupation = 'Teacher'
);
--task2
SELECT full_name, annual_income FROM Taxpayer
WHERE annual_income > ALL (
    SELECT annual_income FROM Taxpayer
    WHERE taxpayer_id IN (
        SELECT taxpayer_id FROM Income_Record
        WHERE category_id = (
            SELECT category_id FROM Income_Category
            WHERE category_name = 'Business'
        )
    )
);