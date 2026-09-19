--PARTA
USE taxation_info;
SHOW TABLES;
SELECT * FROM taxpayer;
SELECT * FROM income_category;
SELECT * FROM financial_year;
SELECT * FROM income_record;


--PARTB
--task1
SET AUTOCOMMIT = 0;
SELECT @@AUTOCOMMIT;
START TRANSACTION;
UPDATE income_record SET amount = 850000 WHERE income_id = 1003;
SELECT * FROM income_record WHERE income_id = 1003;
COMMIT;
--task2
START TRANSACTION;
UPDATE income_record SET amount = 900000 WHERE income_id = 1004;
SELECT * FROM income_record WHERE income_id = 1004;
COMMIT;
--task3
START TRANSACTION;
UPDATE Income_Record SET amount = 999999 WHERE income_id = 1004;
SELECT * FROM Income_Record WHERE income_id = 1004;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1004;
--task4
START TRANSACTION;
INSERT INTO Income_Record ()
VALUES
(1007, 101, 'TCL Test Income', 50000.00,
 '2026-03-31', 'Test', 5, 6);
SELECT * FROM Income_Record WHERE income_id = 1007;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1007;
--task5
START TRANSACTION;
DELETE FROM Income_Record WHERE income_id = 1006;
SELECT * FROM Income_Record WHERE income_id = 1006;
ROLLBACK;
SELECT * FROM Income_Record WHERE income_id = 1006;
--task6
START TRANSACTION;
UPDATE Income_Record SET amount = 120000 WHERE income_id = 1004;
INSERT INTO Income_Record ()
VALUES
(1007, 101, 'Additional Income', 60000.00,
 '2026-03-31', 'Combined Test', 5, 6);
SELECT * FROM Income_Record WHERE income_id IN (1004, 1007);
COMMIT;

--PartC
--task1
START TRANSACTION;
UPDATE Income_Record SET amount = 130000 WHERE income_id = 1004;
SAVEPOINT sp1;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
ROLLBACK TO SAVEPOINT sp1;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
COMMIT;
--task2
START TRANSACTION;
INSERT INTO Income_Record ()
VALUES
(1008, 102, 'Temporary Income', 70000.00,
 '2026-03-31', 'SP Test', 5, 6);
SAVEPOINT sp2;
UPDATE Income_Record SET amount = 1700000 WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT sp2;
SELECT * FROM Income_Record WHERE income_id IN (1006, 1008);
COMMIT;
--task3
START TRANSACTION;
UPDATE Income_Record SET amount = 140000 WHERE income_id = 1004;
SAVEPOINT sp1;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
SAVEPOINT sp2;
UPDATE Income_Record SET amount = 800000 WHERE income_id = 1005;
ROLLBACK TO SAVEPOINT sp1;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1005, 1006);
COMMIT;
--task4
START TRANSACTION;
INSERT INTO Income_Record ()
VALUES
(1009, 103, 'Temporary Business Income', 100000.00,
 '2026-03-31', 'Combined Test', 2, 6);
UPDATE Income_Record SET amount = 125000 WHERE income_id = 1004;
SAVEPOINT before_delete;
DELETE FROM Income_Record WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT before_delete;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006, 1009);
COMMIT;
--task5
START TRANSACTION;
UPDATE Income_Record SET amount = 130000 WHERE income_id = 1004;
SAVEPOINT sp_release;
UPDATE Income_Record SET amount = 1550000 WHERE income_id = 1006;
RELEASE SAVEPOINT sp_release;
ROLLBACK TO SAVEPOINT sp_release;
ROLLBACK;
--task6
START TRANSACTION;
UPDATE Income_Record SET amount = 140000 WHERE income_id = 1004;
SAVEPOINT sp_test;
UPDATE Income_Record SET amount = 1600000 WHERE income_id = 1006;
ROLLBACK TO SAVEPOINT sp_test;
SELECT * FROM Income_Record WHERE income_id IN (1004, 1006);
COMMIT;