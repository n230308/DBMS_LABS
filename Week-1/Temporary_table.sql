USE Taxation_Info;

CREATE TABLE Tax_Office(
	office_id INT PRIMARY KEY,
    office_name VARCHAR(30) NOT NULL,
    city VARCHAR(20) NOT NULL
);

INSERT INTO Tax_Office()
VALUES
	(1,'DELL','Hyderabad'),
    (2,'HP','Mumbai');
    
TRUNCATE TABLE Tax_Office;
DROP TABLE Tax_Office;