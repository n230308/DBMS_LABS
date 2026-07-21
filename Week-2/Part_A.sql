USE Taxation_Info;

SELECT * FROM Income_Record;

/*PART-A Step-1 */
ALTER TABLE Income_Record
DROP COLUMN category_name, DROP COLUMN financial_year;

/*PART-A Step-2 */
ALTER TABLE Income_Record ADD category_id INT, ADD year_id INT;

/*PART-A Step-3 */
ALTER TABLE Income_Record ADD CONSTRAINT fk_incomeRecord_Taxpayer FOREIGN KEY (taxpayer_id) REFERENCES Taxpayer(taxpayer_id);

ALTER TABLE Income_Record ADD CONSTRAINT fk_incomeRecord_IncomeCatgry2 FOREIGN KEY (category_id) REFERENCES Income_Category(category_id);

ALTER TABLE Income_Record ADD CONSTRAINT fk_incomeRecord_FinanYear FOREIGN KEY (year_id) REFERENCES Financial_Year(year_id);

/*Part-A step-4 */
UPDATE Income_Record SET category_id = 1 WHERE taxpayer_id = 101;
UPDATE Income_Record SET year_id = 1 WHERE taxpayer_id = 101;
UPDATE Income_Record SET year_id = 2,category_id = 2 WHERE taxpayer_id = 102;
UPDATE Income_Record SET year_id = 3,category_id = 3 WHERE taxpayer_id = 103;
UPDATE Income_Record SET year_id = 4,category_id = 4 WHERE taxpayer_id = 104;
UPDATE Income_Record SET year_id = 5,category_id = 5 WHERE taxpayer_id = 105;
UPDATE Income_Record SET year_id = 6,category_id = 6 WHERE taxpayer_id = 106;
