USE taxation_info;

--PARTA
--task2
DELIMITER //
CREATE PROCEDURE welcome_taxation()
BEGIN
    SELECT 'Welcome to TaxationDB';
END //
DELIMITER ;
CALL welcome_taxation();


--task4
DELIMITER //
CREATE PROCEDURE get_taxpayer_income(IN p_taxpayer_id INT)
BEGIN
    SELECT
        full_name AS 'Taxpayer Name',
        annual_income AS 'Annual Income'
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
END //
DELIMITER ;
CALL get_taxpayer_income(101);
-- task5 same as task4 and Compare the PL/SQL and MySQL compare

-- Level 0
-- ques1
DELIMITER //
CREATE PROCEDURE calc_10_perc(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    SELECT annual_income INTO v_income FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
    SET v_tax = v_income * 0.10;
    SELECT
        v_income AS 'Annual Income',
        v_tax AS '10% of Annual Income';
END //
DELIMITER ;
CALL calc_10_perc(101);


--Ques2
DELIMITER //
CREATE PROCEDURE display_taxpayer_details(
    IN p_taxpayer_id INT
)
BEGIN
    SELECT full_name AS 'Taxpayer Name',pan_number AS 'PAN Number',occupation AS 'Occupation',annual_income AS 'Annual Income' FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
END //
DELIMITER ;
CALL display_taxpayer_details(102);


-- Ques3
DELIMITER //
CREATE PROCEDURE check_taxpayer_status(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_status TINYINT;
    SELECT is_active INTO v_status FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
    IF v_status = 1 THEN
        SELECT 'Active' AS 'Taxpayer Status';
    ELSE
        SELECT 'Inactive' AS 'Taxpayer Status';
    END IF;
END //
DELIMITER ;
CALL check_taxpayer_status(105);


--Ques 4
DELIMITER //
CREATE FUNCTION check_taxable(p_income DECIMAL(12,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF p_income > 0 THEN
        RETURN 'Taxable';
    ELSE
        RETURN 'Non-Taxable';
    END IF;
END //
DELIMITER ;
SELECT check_taxable(50000) AS status;


-- Ques5
DELIMITER //
CREATE PROCEDURE display_numbers()
BEGIN
    DECLARE v_num INT DEFAULT 1;
    WHILE v_num <= 10 DO
        SELECT v_num AS Number;
        SET v_num = v_num + 1;
    END WHILE;
END //
DELIMITER ;
CALL display_numbers();


-- Level 1
-- Ques1
DELIMITER //
CREATE PROCEDURE classify_taxpayer_income(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_income DECIMAL(12,2);
    SELECT annual_income INTO v_income FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
    IF v_income > 1000000 THEN
        SELECT 'High Income' AS 'Income Classification';

    ELSEIF v_income >= 500000 THEN
        SELECT 'Medium Income' AS 'Income Classification';

    ELSE
        SELECT 'Low Income' AS 'Income Classification';
    END IF;
END //
DELIMITER ;
CALL classify_taxpayer_income(105);

--Ques2
DELIMITER //
CREATE FUNCTION get_annual_income(
    p_taxpayer_id INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_income DECIMAL(12,2);
    SELECT annual_income INTO v_income FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
    RETURN v_income;
END //
DELIMITER ;
SELECT get_annual_income(101) AS annual_income;

-- Level2
-- Ques1
DELIMITER //
CREATE PROCEDURE display_active_taxpayers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_occupation VARCHAR(150);
    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income, occupation
        FROM Taxpayer
        WHERE is_active = 1;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = TRUE;
    OPEN taxpayer_cursor;
    read_loop: LOOP
        FETCH taxpayer_cursor INTO v_name, v_income, v_occupation;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT
            v_name AS 'Taxpayer Name',
            v_income AS 'Annual Income',
            v_occupation AS 'Occupation';

    END LOOP;
    CLOSE taxpayer_cursor;
END //
DELIMITER ;
CALL display_active_taxpayers();

-- Ques2
DELIMITER //
CREATE PROCEDURE find_taxpayer(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT 'Taxpayer not found' AS message;
    END;
    SELECT full_name, annual_income INTO v_name,v_income FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
    SELECT
        v_name AS 'Taxpayer Name',
        v_income AS 'Annual Income';

END //
DELIMITER ;
CALL find_taxpayer(128);