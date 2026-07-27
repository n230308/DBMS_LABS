USE Taxation_Info;
--PART-A
SHOW TABLES;
SELECT * FROM taxpayer;
SELECT * FROM income_category;
SELECT * FROM financial_year;
SELECT * FROM income_record;

--Part-B
--LEVEL 1
--ques1
SELECT UPPER(full_name) FROM taxpayer;
--ques2
SELECT LOWER(occupation) FROM taxpayer;
--ques3
SELECT LENGTH(full_name) FROM taxpayer;
--ques4
SELECT SUBSTRING(pan_number,1,4) FROM taxpayer;
--ques5
SELECT CONCAT(full_name," ",occupation) FROM taxpayer;

--LEVEL2
--ques6
SELECT REPLACE(category_name,"Income","Inc.") FROM income_category;
--ques7
SELECT TRIM(full_name) FROM taxpayer;
--ques8
SELECT SUBSTRING_INDEX(full_name," ",1) FROM taxpayer;

--LEVEL3
--ques9
SELECT CONCAT(
    "Taxpayer :",full_name,
    CHAR(10),
    "Occupation :",occupation
) FROM taxpayer;
--ques10
SELECT * FROM taxpayer WHERE pan_number LIKE "AP%";


--PART-C
--LEVEL1
--ques1
SELECT ROUND(annual_income) FROM taxpayer;
--ques2
SELECT ABS(annual_income - 500000) FROM taxpayer;
--ques3
SELECT POWER(annual_income,2) FROM taxpayer;

--LEVEL2
--ques4
SELECT MOD(annual_income,1000) FROM taxpayer;
--ques5
SELECT ROUND(annual_income,2) FROM taxpayer;
--ques6
SELECT CEIL(annual_income),FLOOR(annual_income) FROM taxpayer;

--LEVEL3
--ques7
SELECT FLOOR(1+RAND()*100);
--ques8
SELECT SQRT(annual_income) FROM taxpayer;
--ques9
SELECT annual_income * 1.10 FROM taxpayer;



--PART-D
--LEVEL-1
--ques1
SELECT CURDATE();
--ques2
SELECT NOW();
--ques3
SELECT YEAR(start_date) FROM financial_year;
--ques4
SELECT MONTH(start_date) FROM financial_year;
--ques5
SELECT DAY(start_date) FROM financial_year;

--LEVEL2
--ques6
SELECT DATE_ADD(start_date,INTERVAL 1 YEAR) FROM financial_year;
--ques7
SELECT DATE_ADD(start_date, INTERVAL 30 DAY) FROM financial_year;
--ques8
SELECT DATE_SUB(start_date, INTERVAL 30 DAY) FROM financial_year;

--LEVEL3
--ques9
SELECT DATEDIFF(CURDATE(),start_date) FROM financial_year;
--ques10
SELECT * FROM financial_year WHERE YEAR(start_date) = YEAR(CURDATE());


--PARTE
--LEVEL1
--ques1
SELECT CAST(annual_income AS SIGNED) FROM taxpayer;
--ques2
SELECT CAST(taxpayer_id AS CHAR) FROM taxpayer;

--LEVEL2
--ques3
SELECT CAST(start_date AS DATETIME) FROM financial_year;
--ques4
SELECT CAST(annual_income AS DECIMAL) FROM taxpayer;

--LEVEL3
--ques5
SELECT CAST(annual_income AS CHAR) FROM taxpayer;
--ques6
SELECT CAST(annual_income AS DECIMAL(12,2))*0.10 FROM taxpayer;