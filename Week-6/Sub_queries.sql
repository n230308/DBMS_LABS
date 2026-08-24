USE Taxation_Info;
--PartA
--Level1
--Task1
SELECT * FROM income_record WHERE amount = (
    SELECT MAX(amount) FROM income_record
);
--Task2
SELECT * FROM income_record WHERE amount = (
    SELECT MIN(amount) FROM income_record
);
--Task3
SELECT * FROM income_record WHERE amount > ALL (
    SELECT AVG(amount) FROM income_record
);
--Task4
SELECT * FROM income_record WHERE amount = (
    SELECT MAX(amount) FROM income_record
);
--task5
SELECT taxpayer_id,full_name FROM taxpayer WHERE occupation IN (
    SELECT occupation FROM taxpayer WHERE occupation = 'Bussiness Owner'
);

--Level2
--Task1
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id = ANY (
    SELECT taxpayer_id FROM income_record
);
--Task2
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE category_id = (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
);
--task3
SELECT * FROM income_record WHERE year_id IN (
    SELECT year_id FROM financial_year WHERE year_label = '2025-2026'
);
--task4
SELECT * FROM income_record WHERE amount > (
    SELECT MIN(amount) FROM income_record WHERE category_id = (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
);
--task5
SELECT * FROM income_record WHERE amount < (
    SELECT MAX(amount) FROM income_record WHERE category_id = (
        SELECT category_id FROM income_category WHERE category_name = 'Salary'
    )
);
--task6
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN(
    SELECT taxpayer_id FROM income_record WHERE amount > (
        SELECT AVG(amount) FROM income_record
    )
);
--task7
SELECT category_id,category_name FROM income_category WHERE category_id = ANY(
    SELECT category_id FROM income_record
);
--task8
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);

--Level3
--task1
SELECT full_name,date_of_birth FROM taxpayer WHERE taxpayer_id =(
    SELECT taxpayer_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task2 (important)
SELECT * FROM income_record WHERE income_id IN (
    SELECT income_id FROM income_record WHERE amount > (
        SELECT AVG(amount) FROM income_record WHERE category_id = (
            SELECT category_id FROM income_category WHERE category_name = 'Business'
        )
    )
);
--task3
SELECT * FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM taxpayer WHERE annual_income > (
        SELECT AVG(annual_income) FROM taxpayer
    )
);
--task4
SELECT * FROM income_record WHERE amount > ANY (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task5
SELECT * FROM income_record WHERE amount > ALL (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task6
SELECT category_id,category_name FROM income_category WHERE category_id IN (
    SELECT category_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task7
SELECT year_id,year_label FROM financial_year WHERE year_id = (
    SELECT year_id FROM income_record GROUP BY year_id
    ORDER BY SUM(amount) DESC LIMIT 1
);
--task8
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income) FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income FROM income_record GROUP BY taxpayer_id
        ) AS taxpayer_totals
    )
);

--Real-World Taxation Analysis
--Task1
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task2
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE amount > (
        SELECT AVG(amount) FROM income_record
    )
);
--task3
SELECT category_id,category_name FROM income_category WHERE category_id = (
    SELECT category_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task4
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
)
AND taxpayer_id NOT IN (
    SELECT taxpayer_id FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task5
SELECT income_id,income_source FROM income_record WHERE amount > ALL (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task6
SELECT income_id,income_source FROM income_record WHERE amount > ANY (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task7
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record GROUP BY taxpayer_id HAVING SUM(amount) = (
        SELECT MAX(total_income) FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income FROM income_record GROUP BY taxpayer_id
        ) AS totals
    )
);
--task8
SELECT ir.income_id, ir.taxpayer_id, ir.income_source,ir.amount, ir.category_id FROM income_record ir JOIN (
    SELECT category_id, AVG(amount) AS avg_income FROM income_record GROUP BY category_id
) AS category_avg ON ir.category_id = category_avg.category_id
WHERE ir.amount > category_avg.avg_income;