USE Taxation_Info;
--task6
SELECT full_name,pan_number,income_source,category_name,year_label FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id;

--task7
SELECT full_name,category_name,des_cription FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id;

--task8
SELECT income_source,year_label FROM income_record ir INNER JOIN financial_year fy ON ir.year_id = fy.year_id;

--task9
SELECT full_name,category_name,year_label FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id WHERE category_name = "Business" AND year_label = '2025-2026';

--task10
SELECT full_name,pan_number,income_source,amount,category_name,des_cription,year_label FROM taxpayer txp INNER JOIN income_record ir ON txp.taxpayer_id = ir.taxpayer_id INNER JOIN income_category ic ON ir.category_id = ic.category_id INNER JOIN financial_year fy ON ir.year_id = fy.year_id;
