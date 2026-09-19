USE taxation_info;

--task1
    --switch to administrator
    --create new connection
CREATE USER 'tax_data_entry'@'localhost' IDENTIFIED BY 'Entry@123';
GRANT SELECT, INSERT ON taxation_info.Income_Record TO 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
SELECT CURRENT_USER();
SELECT * FROM Income_Record;
INSERT INTO Income_Record ()
VALUES
(1015, 101, 'Data Entry Test', 55000.00,
 '2026-03-31', 'Entry Test', 5, 6);

--task2
    --switch to administrator
    --create new connection
CREATE USER 'tax_officer'@'localhost' IDENTIFIED BY 'Officer@123';
GRANT SELECT, INSERT, UPDATE ON taxation_info.Income_Record TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
INSERT INTO Income_Record ()
VALUES
(1016, 102, 'Officer Test Income', 65000.00,
 '2026-03-31', 'Officer Insert Test', 5, 6);
UPDATE Income_Record SET amount = 70000.00 WHERE income_id = 1016;
DELETE FROM Income_Record WHERE income_id = 1016; --error

--task3
GRANT SELECT ON taxation_info.Taxpayer_Income_Summary TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
SELECT * FROM Taxpayer_Income_Summary;

--task4
GRANT SELECT, INSERT, UPDATE ON taxation_info.Income_Record TO 'tax_officer'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';
-- Revoke only UPDATE
REVOKE UPDATE ON taxation_info.Income_Record FROM 'tax_officer'@'localhost';
-- Verify final privileges
SHOW GRANTS FOR 'tax_officer'@'localhost';
SELECT * FROM Income_Record;
INSERT INTO Income_Record ()
VALUES
(1017, 103, 'Task 4 Test', 45000.00,
 '2026-03-31', 'Task 4 Insert', 5, 6);
UPDATE Income_Record SET amount = 50000 WHERE income_id = 1017;

--task5
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
SHOW GRANTS FOR 'tax_officer'@'localhost';

--task6
SHOW GRANTS FOR 'tax_data_entry'@'localhost';
SELECT * FROM Income_Record;
INSERT INTO Income_Record ()
VALUES
(1018, 104, 'Final Task Test', 40000.00,
 '2026-03-31', NULL, 5, 6);
UPDATE Income_Record SET amount = 45000 WHERE income_id = 1018;
DELETE FROM Income_Record WHERE income_id = 1018;