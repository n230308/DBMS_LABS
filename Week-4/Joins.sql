--PART-A
USE Taxation_Info;
SHOW TABLES;

--PART-B
--LEVEL-1
--task-1
SELECT full_name,income_source FROM taxpayer INNER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id;
--task2
SELECT full_name,category_name FROM taxpayer INNER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id INNER JOIN income_category ON income_record.category_id = income_category.category_id;
--task3
SELECT amount,year_label FROM income_record INNER JOIN financial_year ON income_record.year_id = financial_year.year_id;
--task4
SELECT full_name,annual_income,amount FROM taxpayer INNER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id;
--task5
SELECT full_name,income_source,category_name,year_label FROM taxpayer INNER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id INNER JOIN income_category ON income_record.category_id = income_category.category_id INNER JOIN financial_year ON income_record.year_id = financial_year.year_id;

--LEVEL-2
--task1
SELECT full_name,category_name FROM taxpayer INNER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id INNER JOIN income_category ON income_record.category_id = income_category.category_id WHERE category_name = "Salary";
--task2
SELECT full_name,occupation,income_source FROM taxpayer t INNER JOIN income_record ir ON t.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id WHERE category_name = "Business";
--task3
SELECT full_name,start_date,end_date FROM taxpayer tp INNER JOIN income_record ir ON tp.taxpayer_id = ir.taxpayer_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id;
--task4
SELECT full_name,occupation,annual_income,category_name,des_cription FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id;
--task5
SELECT full_name,pan_number,occupation,income_source,category_name,amount,year_label,start_date,end_date FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id;

--LEVEL3
--task1
SELECT full_name,income_source FROM taxpayer LEFT OUTER JOIN income_record ON taxpayer.taxpayer_id = income_record.taxpayer_id;
--task2
SELECT category_name,income_source FROM income_record RIGHT OUTER JOIN income_category ON income_record.category_id = income_category.category_id;6
--task3
SELECT t.full_name, ir.income_source FROM taxpayer t
LEFT JOIN income_record ir
ON t.taxpayer_id = ir.taxpayer_id

UNION

SELECT t.full_name, ir.income_source FROM taxpayer t
RIGHT JOIN income_record ir
ON t.taxpayer_id = ir.taxpayer_id;

--task4
SELECT full_name, year_label
FROM taxpayer
CROSS JOIN financial_year ;

--task5
SELECT t1.full_name AS Taxp1,t2.full_name AS Taxp2,t1.occupation FROM taxpayer t1 INNER JOIN taxpayer t2 ON t1.occupation = t2.occupation AND t1.taxpayer_id < t2.taxpayer_id;
