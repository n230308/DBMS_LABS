USE Taxation_Info;

CREATE TABLE Financial_Year(
	year_id INT PRIMARY KEY,
    year_label VARCHAR(9) NOT NULL UNIQUE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    filling_deadline DATE,
    is_current BOOLEAN NOT NULL															
);

INSERT INTO Financial_Year()
VALUES
	(1,'2020-2021','2020-04-01','2021-03-31','2021-07-31',FALSE),
    (2,'2021-2022','2021-04-01','2022-03-31','2022-07-31',FALSE),
    (3,'2022-2023','2022-04-01','2023-03-31','2023-07-31',FALSE),
    (4,'2023-2024','2023-04-01','2024-03-31','2024-07-31',FALSE),
    (5,'2024-2025','2024-04-01','2025-03-31','2025-07-31',FALSE),
    (6,'2025-2026','2025-04-01','2026-03-31','2026-07-31',FALSE);
SELECT * FROM Financial_Year;