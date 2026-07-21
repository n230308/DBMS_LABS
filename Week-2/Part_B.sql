USE Taxation_Info;

--Task1
UPDATE Income_Record SET icnome_id = 1007 WHERE taxpayer_id = 999;
-- ERROR

--Task2
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1007, 101, 'Freelancing', 50000.00, '2026-05-10', 'Test', 20, 6);
--ERROR 1452 (23000): Cannot add or update a child row:
-- a foreign key constraint fails
-- (`Taxation_Info`.`income_record`,
-- CONSTRAINT `fk_incomeRecord_Taxpayer2`
-- FOREIGN KEY (`category_id`)
-- REFERENCES `income_category` (`category_id`))


--Task3
INSERT INTO Income_Record
(income_id, taxpayer_id, income_source, amount, received_date, remarks, category_id, year_id)
VALUES
(1008, 101, 'Interest Income', 50000.00, '2026-03-31', 'Test', 1, 15);
-- ERROR 1452 (23000): Cannot add or update a child row:
-- a foreign key constraint fails
-- (`Taxation_Info`.`income_record`,
-- CONSTRAINT `fk_incomeRecord_FinanYear`
-- FOREIGN KEY (`year_id`)
-- REFERENCES `financial_year` (`year_id`))


--Task4
DELETE FROM Taxpayer
WHERE taxpayer_id = 101;
-- ERROR 1451 (23000): Cannot delete or update a parent row:
-- a foreign key constraint fails
-- (`Taxation_Info`.`income_record`,
-- CONSTRAINT `fk_incomeRecord_Taxpayer`
-- FOREIGN KEY (`taxpayer_id`)
-- REFERENCES `taxpayer` (`taxpayer_id`))


--Task5
DELETE FROM Income_Category
WHERE category_id = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails