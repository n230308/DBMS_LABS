USE Taxation_Info;

/*PartC*/
--Task1
SELECT DISTINCT occupation
FROM Taxpayer;

--Task2
SELECT DISTINCT category_name
FROM Income_Category;

--Task3
-- Already deleted the financial_year in PartA col, so no Financial years in DB

--Task4
SELECT DISTINCT income_source FROM Income_Record;


/*PartD*/
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
)
UNION
SELECT full_name FROM Taxpayer
WHERE taxpayer_id IN (
    SELECT taxpayer_id
    FROM Income_Record
    WHERE category_id = (
        SELECT category_id
        FROM Income_Category
        WHERE category_name = 'Business'
    )
);

--Task2
SELECT income_source
FROM Income_Record
WHERE year_id = (
    SELECT year_id
    FROM Financial_Year
    WHERE year_label = '2024-2025'
)
UNION
SELECT income_source
FROM Income_Record
WHERE year_id = (
    SELECT year_id
    FROM Financial_Year
    WHERE year_label = '2025-2026'
);

--Task3
SELECT full_name FROM Taxpayer WHERE occupation = 'Teacher'
UNION
SELECT full_name FROM Taxpayer WHERE occupation = 'Software Engineer';