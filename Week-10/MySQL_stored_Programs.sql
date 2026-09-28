USE taxation_info;

--PART-A
--task-1
DELIMITER //
CREATE FUNCTION calculate_tax(annual_inc DECIMAL(15,2))
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN

    DECLARE tax_amount DECIMAL(15,2);
    IF annual_inc <= 500000 THEN
        SET tax_amount = 0;
    ELSEIF annual_inc <= 1000000 THEN
        SET tax_amount = (annual_inc - 500000) * 0.10;
    ELSEIF annual_inc <= 1500000 THEN
        SET tax_amount = ((annual_inc - 1000000)* 0.20)+50000;
    ELSEIF annual_inc > 1500000 THEN
        SET tax_amount = ((annual_inc - 1500000)* 0.30)+150000;
    END IF;

    RETURN tax_amount;
END //
DELIMITER ;
SELECT calculate_tax(400000);
SELECT calculate_tax(750000);
SELECT calculate_tax(1800000);

-- partB
-- task2
DELIMITER //
CREATE PROCEDURE generate_tax_assessment(
    IN p_taxpayer_id INT
)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_pan VARCHAR(20);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_occupation VARCHAR(100);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net_income DECIMAL(12,2);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT full_name,
           pan_number,
           annual_income,
           occupation
    INTO v_name,
         v_pan,
         v_income,
         v_occupation
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found' AS Message;

    ELSE

        SET v_tax = calculate_tax(v_income);
        SET v_net_income = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_pan AS PAN_Number,
            v_occupation AS Occupation,
            v_income AS Annual_Income,
            v_tax AS Tax_Amount,
            v_net_income AS Net_Income;
    END IF;
END //
DELIMITER ;
CALL generate_tax_assessment(101);

--PartC
--Task3
DELIMITER //
CREATE FUNCTION income_category(p_income DECIMAL(12,2))
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN

    IF p_income <= 500000 THEN
        RETURN 'Low Income';

    ELSEIF p_income <= 1000000 THEN
        RETURN 'Medium Income';

    ELSEIF p_income <= 1500000 THEN
        RETURN 'High Income';

    ELSE
        RETURN 'Very High Income';
    END IF;
END //
DELIMITER ;
SELECT
    full_name,
    annual_income,
    income_category(annual_income) AS income_category
FROM Taxpayer;

-- Level1
-- Ques1
DELIMITER //
CREATE PROCEDURE taxpayer_summary(IN p_taxpayer_id INT)
BEGIN
    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE
        SET v_category = income_category(v_income);
        SET v_tax = calculate_tax(v_income);
        SET v_net = v_income - v_tax;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_category AS Income_Category,
            v_tax AS Calculated_Tax,
            v_net AS Net_Income;
    END IF;
END //
DELIMITER ;

-- Ques2
DELIMITER //
CREATE PROCEDURE income_record_summary(IN p_taxpayer_id INT)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_annual DECIMAL(12,2);
    DECLARE v_total DECIMAL(12,2);
    DECLARE v_difference DECIMAL(12,2);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT full_name, annual_income
    INTO v_name, v_annual
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN
        SELECT 'Taxpayer not found' AS Message;
    ELSE

        SELECT COALESCE(SUM(amount),0)
        INTO v_total
        FROM Income_Record
        WHERE taxpayer_id = p_taxpayer_id;

        SET v_difference = v_annual - v_total;
        SELECT
            v_name AS full_name,
            v_total AS Total_Recorded_Income,
            v_annual AS Annual_Income,
            v_difference AS Difference;

    END IF;
END //
DELIMITER ;
CALL income_record_summary(105);

-- Ques3
DELIMITER //
CREATE PROCEDURE conditional_assessment(IN p_taxpayer_id INT)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_status VARCHAR(50);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    SELECT full_name, annual_income
    INTO v_name, v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found' AS Message;

    ELSE

        IF v_income <= 500000 THEN
            SET v_status = 'No Tax Assessment';

        ELSEIF v_income <= 1000000 THEN
            SET v_status = 'Standard Assessment';

        ELSE
            SET v_status = 'High Income Assessment';
        END IF;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_status AS Assessment_Status;

    END IF;
END //
DELIMITER ;
