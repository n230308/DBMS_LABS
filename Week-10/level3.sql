--level3
--Ques1
DELIMITER ;
DELIMITER //
CREATE PROCEDURE complete_tax_assessment(IN p_taxpayer_id INT)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_pan VARCHAR(20);
    DECLARE v_occupation VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);

    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT
        full_name,
        pan_number,
        occupation,
        annual_income
    INTO
        v_name,
        v_pan,
        v_occupation,
        v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found.' AS Message;

    ELSE

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_pan AS PAN_Number,
            v_occupation AS Occupation,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Tax_Amount,
            v_net AS Net_Income;

    END IF;
END //
DELIMITER ;
CALL complete_tax_assessment(103);

-- Ques2
DELIMITER //
CREATE PROCEDURE process_income_records()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_income_id INT;
    DECLARE v_taxpayer_id INT;
    DECLARE v_source VARCHAR(100);
    DECLARE v_category VARCHAR(50);
    DECLARE v_amount DECIMAL(12,2);
    DECLARE v_received_date DATE;
    DECLARE v_financial_year VARCHAR(30);
    DECLARE v_classification VARCHAR(30);

    DECLARE c_records CURSOR FOR
        SELECT
            ir.income_id,
            ir.taxpayer_id,
            ir.income_source,
            ic.category_name,
            ir.amount,
            ir.received_date,
            fy.financial_year
        FROM Income_Record ir
        JOIN Income_Category ic
            ON ir.category_id = ic.category_id
        JOIN Financial_Year fy
            ON ir.year_id = fy.year_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN c_records;

    read_loop: LOOP

        FETCH c_records
        INTO v_income_id,
             v_taxpayer_id,
             v_source,
             v_category,
             v_amount,
             v_received_date,
             v_financial_year;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        IF v_amount <= 50000 THEN
            SET v_classification = 'Small Income Record';

        ELSEIF v_amount <= 200000 THEN
            SET v_classification = 'Medium Income Record';

        ELSE
            SET v_classification = 'Large Income Record';
        END IF;

        SELECT
            v_income_id AS Income_ID,
            v_taxpayer_id AS Taxpayer_ID,
            v_source AS Income_Source,
            v_category AS Category,
            v_amount AS Amount,
            v_received_date AS Received_Date,
            v_financial_year AS Financial_Year,
            v_classification AS Classification;

    END LOOP;

    CLOSE c_records;
END //
DELIMITER ;

--Ques3
DELIMITER //
CREATE PROCEDURE combined_tax_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE c_taxpayers CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN c_taxpayers;

    read_loop: LOOP

        FETCH c_taxpayers INTO v_name, v_income;

        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Tax_Amount,
            v_net AS Net_Income;

    END LOOP;
    CLOSE c_taxpayers;
END //
DELIMITER ;