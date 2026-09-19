USE taxation_info;

--task1
START TRANSACTION;
INSERT INTO Income_Record ()
VALUES
(1019, 101, 'Annual Income Submission', 95000.00,
 '2026-03-31', NULL, 5, 6);
-- Verify before COMMIT
SELECT * FROM Income_Record WHERE income_id = 1019;
COMMIT;
-- Verify that the record remains
SELECT * FROM Income_Record WHERE income_id = 1019;


--task2
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;
START TRANSACTION;
UPDATE Income_Record SET amount = 999999.00 WHERE income_id = 1001;
-- Verify incorrect change
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;
ROLLBACK;
-- Verify original value is restored
SELECT income_id, amount FROM Income_Record WHERE income_id = 1001;


--task3
START TRANSACTION;
-- First valid modification
UPDATE Income_Record SET amount = 860000.00 WHERE income_id = 1001;
-- Create savepoint
SAVEPOINT valid_change;
-- Second incorrect modification
UPDATE Income_Record SET amount = 999999.00 WHERE income_id = 1002;
-- Verify both changes
SELECT income_id, amount FROM Income_Record WHERE income_id IN (1001, 1002);
-- Rollback only the second modification
ROLLBACK TO SAVEPOINT valid_change;
-- Verify first change remains
SELECT income_id, amount FROM Income_Record WHERE income_id IN (1001, 1002);
-- Permanently save the first modification
COMMIT;


--task4
GRANT SELECT, INSERT ON taxation_info.Income_Record TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
    -- tax_data_entry connection
INSERT INTO Income_Record ()
VALUES
(1020, 105, 'Part F Entry Test', 50000.00,
 '2026-03-31', NULL, 5, 6);
UPDATE Income_Record SET amount = 55000 WHERE income_id = 1020;
DELETE FROM Income_Record WHERE income_id = 1020;


--task5
GRANT SELECT ON taxation_info.Taxpayer_Income_Summary TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
    -- tax_data_entry connection
SELECT * FROM Taxpayer_Income_Summary;
SELECT * FROM Taxpayer;


--task6
GRANT UPDATE ON taxation_info.Income_Record TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
REVOKE UPDATE ON taxation_info.Income_Record FROM 'tax_data_entry'@'localhost';
UPDATE Income_Record SET amount = 55000 WHERE income_id = 1020;