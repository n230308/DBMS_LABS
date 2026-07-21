USE Taxation_Info;

/*PartG*/
--Task1
SELECT full_name FROM Taxpayer WHERE taxpayer_id IN(
    SELECT taxpayer_id FROM Income_Record
);

--Task2
SELECT full_name, occupation FROM Taxpayer WHERE occupation IN (
    SELECT occupation
    FROM Taxpayer
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

/*PartH*/
--task1
SELECT full_name FROM Taxpayer WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);
--task2
SELECT DISTINCT occupation
FROM Taxpayer
WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id
    FROM Income_Record
);