USE Taxation_Info;

/*PartE*/
--Task1
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (

    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Salary'
    )
    INTERSECT
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Business'
    )
);

--Task2
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (

    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = (
        SELECT year_id
        FROM Financial_Year
        WHERE year_label = '2024-2025'
    )
    INTERSECT
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = (
        SELECT year_id
        FROM Financial_Year
        WHERE year_label = '2025-2026'
    )
);

/*PartF*/
--Task1
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (

    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Salary'
    )
    EXCEPT
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Business'
    )
);

--Task2
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (

    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = (
        SELECT year_id
        FROM Financial_Year
        WHERE year_label = '2025-2026'
    )
    EXCEPT
    SELECT taxpayer_id
    FROM Income_Record
    WHERE year_id = (
        SELECT year_id
        FROM Financial_Year
        WHERE year_label = '2024-2025'
    )
);