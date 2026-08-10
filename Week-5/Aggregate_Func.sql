USE Taxation_Info;
SHOW TABLES;
SELECT * FROM taxpayer;
SELECT * FROM income_category;
SELECT * FROM financial_year;
SELECT * FROM income_record;

--PartB
--LEVEL1
--Task1
SELECT COUNT(*) FROM income_record;
--task2
SELECT SUM(amount) FROM income_record;
--task3
SELECT AVG(amount) FROM income_record;
--task4
SELECT MAX(amount) FROM income_record;
--task5
SELECT MIN(amount) FROM income_record;

--LEVEL2
--task1
SELECT category_name, COUNT(income_id) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY category_name;
--task2
SELECT category_name, SUM(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY category_name;
--task3
SELECT category_name, AVG(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY category_name;
--task4
SELECT category_name, MAX(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY category_name;
--task5
SELECT category_name, MIN(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY category_name;
--task6
SELECT year_label, SUM(amount) FROM financial_year INNER JOIN income_record ON financial_year.year_id = income_record.year_id GROUP BY financial_year.year_id;
--task7
SELECT year_label, COUNT(amount) FROM financial_year INNER JOIN income_record ON financial_year.year_id = income_record.year_id GROUP BY financial_year.year_id;
--task8
SELECT SUM(amount),category_name,year_label FROM financial_year fy INNER JOIN income_record ir ON fy.year_id = ir.year_id INNER JOIN income_category ic ON ic.category_id = ir.category_id GROUP BY ir.category_id,fy.year_id;

--LEVEL3
--task1
SELECT category_name,SUM(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY income_category.category_name HAVING SUM(amount) > 1000000;
--task2
SELECT category_name,AVG(amount) FROM income_category INNER JOIN income_record ON income_category.category_id = income_record.category_id GROUP BY income_category.category_name HAVING AVG(amount) > 500000;
--task3
SELECT fy.year_label,COUNT(ir.income_id) AS income_record_count FROM financial_year fy INNER JOIN income_record ir ON fy.year_id = ir.year_id GROUP BY fy.year_id, fy.year_label HAVING COUNT(ir.income_id) > 3;
--task4
SELECT ic.category_name,SUM(ir.amount) AS total_income FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY  ic.category_name ORDER BY total_income DESC;
--task5
SELECT ic.category_name,SUM(ir.amount) AS total_income FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_id, ic.category_name HAVING SUM(ir.amount) > 1000000 ORDER BY total_income DESC;
--task6
SELECT ic.category_name,
       SUM(ir.amount) AS total_income,
       AVG(ir.amount) AS average_income
FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_id, ic.category_name;
--task7
SELECT ic.category_name,
       fy.year_label,
       SUM(ir.amount) AS total_income
FROM income_record ir INNER JOIN income_category ic ON ir.category_id = ic.category_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id GROUP BY ic.category_name,fy.year_id, fy.year_label ORDER BY total_income DESC LIMIT 1;
--task8
SELECT fy.year_label,
       COUNT(DISTINCT t.taxpayer_id) AS taxpayer_count
FROM taxpayer t INNER JOIN income_record ir ON t.taxpayer_id = ir.taxpayer_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id GROUP BY fy.year_id, fy.year_label;


--REAL-WORLD-TAXATION ANALYSIS
--task1
SELECT category_name,SUM(amount) AS total_income FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_name ORDER BY total_income DESC LIMIT 1;
--task2
SELECT year_label,SUM(amount) AS total_income FROM financial_year fy INNER JOIN income_record ir ON fy.year_id = ir.year_id GROUP BY fy.year_id,fy.year_id ORDER BY total_income DESC LIMIT 1;
--task3
SELECT category_name,AVG(amount) AS avg_income FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_id,ic.category_name ORDER BY avg_income DESC LIMIT 1;
--task4
SELECT ic.category_name,
       COUNT(ir.income_id) AS income_record_count
FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_id, ic.category_name HAVING COUNT(ir.income_id) > 2;
--task5
SELECT fy.year_label,
       SUM(ir.amount) AS total_income
FROM financial_year fy INNER JOIN income_record ir ON fy.year_id = ir.year_id GROUP BY fy.year_id, fy.year_label HAVING SUM(ir.amount) > 1000000;
--task6
SELECT category_name,COUNT(amount) AS no_of_records,SUM(amount) AS total_income,AVG(amount) AS avg_income,MAX(amount) AS highest_income,MIN(amount) AS lowest_income FROM income_category ic INNER JOIN income_record ir ON ic.category_id = ir.category_id GROUP BY ic.category_id, ic.category_name;