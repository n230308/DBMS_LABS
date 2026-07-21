USE Taxation_Info;

/*Part-I*/
SELECT full_name FROM Taxpayer t
WHERE EXISTS (
    SELECT *
    FROM Income_Record ir
    WHERE ir.taxpayer_id = t.taxpayer_id
);

SELECT year_label FROM Financial_Year fy
WHERE EXISTS (
    SELECT *
    FROM Income_Record ir
    WHERE ir.year_id = fy.year_id
);

/*Part-J*/
--task1
SELECT full_name FROM Taxpayer t
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record ir
    WHERE ir.taxpayer_id = t.taxpayer_id
);
--task2
SELECT category_name
FROM Income_Category ic
WHERE NOT EXISTS (
    SELECT *
    FROM Income_Record ir
    WHERE ir.category_id = ic.category_id
);