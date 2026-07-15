CREATE DATABASE Taxation_Info;
USE Taxation_Info;

/*Entity 1: Taxpayer */
CREATE TABLE Taxpayer(
	taxpayer_id INT PRIMARY KEY,
    pan_number VARCHAR(10) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    occupation VARCHAR(50) NOT NULL,
    annual_income DECIMAL(12,2) NOT NULL,
    email VARCHAR(100) UNIQUE,
    is_active BOOLEAN
);

INSERT INTO Taxpayer(taxpayer_id,pan_number,full_name,date_of_birth,occupation, annual_income,email,is_active)
VALUES
	(101,'ABCDE1234F','Ravi Kumar','1995-06-15','Software Engineer',850000.00,'ravi.kumar@example.com',TRUE),
    (102,'BCDEF2345G','Priya Sharma','1992-11-22','Doctor',1200000.00,'priya.sharma@example.com',TRUE),
    (103,'CDEFG3456H','Arjun Reddy','1988-03-10','Bussiness Owner',1800000.00,'arjun.reddy@example.com',TRUE),
    (104,'DEFGH4567J','Sneha Patel','1998-08-05','Teacher',620000.00,'sneha.patel@example.com',TRUE),
    (105,'EFGHJ5678K','Kiran Rao','1990-01-18','Freelancer',750000.00,'kiran.rao@example.com',TRUE),
    (106,'FGHJK6789L','Meera Singh','1985-12-30','Consultant',1500000.00,'meera.singh@example.com',TRUE);
SELECT * FROM Taxpayer;

/*PART-D*/
INSERT INTO Taxpayer()
VALUES
	(107,'GHJK7890M','Manikanta','2007-10-03','Student',750000.00,'mani@example.com',TRUE);

UPDATE Taxpayer SET annual_income = 950000.00 WHERE taxpayer_id = 101;
UPDATE Taxpayer SET occupation = 'Software Consultant' WHERE taxpayer_id = 105;
UPDATE Taxpayer SET is_active = TRUE WHERE taxpayer_id = 106;
DELETE FROM Taxpayer WHERE taxpayer_id = 107;

/*PART-E TASK-1*/
ALTER TABLE Taxpayer ADD phone_number INT;
/*PART-E TASK-3*/
ALTER TABLE Taxpayer
MODIFY COLUMN occupation VARCHAR(150);

/*PART-F exp-1*/
INSERT INTO Taxpayer() VALUES (101,'GHJK7890M','Manikanta','2007-10-03','Student',750000.00,'mani@example.com',FALSE);
-- ERROR 1136

INSERT INTO Taxpayer() VALUES (107,'ABCDE1234F','Manikanta','2007-10-03','Student',750000.00,'mani@example.com',FALSE);
-- ERROR 1136

INSERT INTO Taxpayer() VALUES (108,'ABCDE1234F','2007-10-03','Student',750000.00,'mani@example.com',FALSE);
-- ERROR 1136