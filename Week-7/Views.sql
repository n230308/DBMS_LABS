USE Taxation_Info;

--Level1
--task1
CREATE VIEW HighestIncome AS
SELECT * FROM income_record WHERE amount = (
    SELECT MAX(amount) FROM income_record
);

--task2
CREATE VIEW LowestIncome AS
SELECT * FROM income_record WHERE amount = (
    SELECT MIN(amount) FROM income_record
);

--task3
CREATE VIEW GreaterAvgIncome AS
SELECT * FROM income_record WHERE amount > ALL (
    SELECT AVG(amount) FROM income_record
);

--task4 is same task1
--task5
CREATE VIEW TaxOccBusiness AS
SELECT full_name FROM taxpayer WHERE occupation = 'Business Owner';


--Level2
--task1
CREATE VIEW Tax_Atlest_OneIncRec AS
SELECT full_name FROM taxpayer WHERE taxpayer_id = ANY (
    SELECT taxpayer_id FROM income_record
);
--task2
CREATE VIEW Tax_Inc_Business AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
);
--task3
CREATE VIEW IncRec_Fy_2025_2026 AS
SELECT ir.* FROM income_record ir JOIN financial_year fy ON ir.year_id = fy.year_id WHERE fy.year_label = '2025-2026';
--task4
CREATE VIEW IncRec_amtGretr_MinBusinInc AS
SELECT * FROM income_record WHERE amount > ALL (
    SELECT MIN(amount) FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
);
--task5
CREATE VIEW IncRec_amtLess_MaxSalaryInc AS
SELECT * FROM income_record WHERE amount < ALL (
    SELECT MAX(amount) FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Salary'
    )
);
--task6
CREATE VIEW Tax_IncRec_Gretr_AvgIncom AS
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id IN(
    SELECT taxpayer_id FROM income_record WHERE amount > (
        SELECT AVG(amount) FROM income_record
    )
);
--task7
CREATE VIEW IncCatgry_Atlest_OneIncRec AS
SELECT category_id,category_name FROM income_category WHERE category_id = ANY(
    SELECT category_id FROM income_record
);
--task8
CREATE VIEW Tax_NoIncRec_InvestCatgry AS
SELECT taxpayer_id,full_name FROM taxpayer WHERE taxpayer_id NOT IN (
    SELECT taxpayer_id FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);


--Level3
--task1
CREATE VIEW Tax_highest_RecIncome AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task2
CREATE VIEW IncRec_amtGretr_AvgBusinessInc AS
SELECT * FROM income_record WHERE amount > (
    SELECT AVG(amount) FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Business'
    )
);
--task3
CREATE VIEW Tax_TotalInc_GretrThan_AvgTotalInc AS
SELECT * FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM taxpayer WHERE annual_income > (
        SELECT AVG(annual_income) FROM taxpayer
    )
);
--task4
CREATE VIEW IncRec_amtGretr_AtlestOneInvestIncRec AS
SELECT * FROM income_record WHERE amount > ANY (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task5
CREATE VIEW IncRec_amtGretr_EvryInvestIncRec AS
SELECT * FROM income_record WHERE amount > ALL (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task6
CREATE VIEW IncCatgry_HighestIncRec AS
SELECT category_id,category_name FROM income_category WHERE category_id IN (
    SELECT category_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task7
CREATE VIEW Fy_HighestTotalInc AS
SELECT year_id,year_label FROM financial_year WHERE year_id = (
    SELECT year_id FROM income_record GROUP BY year_id
    ORDER BY SUM(amount) DESC LIMIT 1
);
--task8
CREATE VIEW Taxpayers_Above_Avg_TotalIncome AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record GROUP BY taxpayer_id
    HAVING SUM(amount) > (
        SELECT AVG(total_income) FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income FROM income_record GROUP BY taxpayer_id
        ) AS taxpayer_totals
    )
);


--Real-World Taxation Analysis Using Views
--Task1
CREATE VIEW Tax_HighestInc AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task2
CREATE VIEW Tax_IncGretr_OveralAvgInc AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record WHERE amount > (
        SELECT AVG(amount) FROM income_record
    )
);
--task3
CREATE VIEW IncCatgry_HghistIncRec AS
SELECT category_id,category_name FROM income_category WHERE category_id IN (
    SELECT category_id FROM income_record WHERE amount = (
        SELECT MAX(amount) FROM income_record
    )
);
--task4
CREATE VIEW Business_No_Investment AS
SELECT full_name FROM taxpayer WHERE taxpayer_id IN (
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
CREATE VIEW IncRec_amtGretr_EvryInvesIncRec AS
SELECT * FROM income_record WHERE amount > ALL (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task6
CREATE VIEW IncRec_amtGretr_AtlestIncRec AS
SELECT * FROM income_record WHERE amount > ANY (
    SELECT amount FROM income_record WHERE category_id IN (
        SELECT category_id FROM income_category WHERE category_name = 'Investment'
    )
);
--task7
CREATE VIEW Tax_HighestTotalInc AS
SELECT taxpayer_id, full_name FROM taxpayer WHERE taxpayer_id IN (
    SELECT taxpayer_id FROM income_record GROUP BY taxpayer_id HAVING SUM(amount) = (
        SELECT MAX(total_income) FROM (
            SELECT taxpayer_id, SUM(amount) AS total_income FROM income_record GROUP BY taxpayer_id
        ) AS totals
    )
);
--task8
CREATE VIEW IncRec_amtGretr_AvgIncCorresCatgry AS
SELECT ir.income_id, ir.taxpayer_id, ir.income_source,ir.amount, ir.category_id FROM income_record ir JOIN (
    SELECT category_id, AVG(amount) AS avg_income FROM income_record GROUP BY category_id
) AS category_avg ON ir.category_id = category_avg.category_id
WHERE ir.amount > category_avg.avg_income;