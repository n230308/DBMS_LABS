DELIMITER //

CREATE PROCEDURE cursor_tax_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_category VARCHAR(30);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_net DECIMAL(12,2);

    DECLARE taxpayer_cursor CURSOR FOR
        SELECT full_name, annual_income
        FROM Taxpayer
        WHERE is_active = 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET done = 1;

    OPEN taxpayer_cursor;

    read_loop: LOOP

        FETCH taxpayer_cursor
        INTO v_name, v_income;

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
    CLOSE taxpayer_cursor;
END //
DELIMITER ;

--Ques2
DELIMITER //
CREATE PROCEDURE cursor_conditional_assessment()
BEGIN

    DECLARE done INT DEFAULT 0;

    DECLARE v_name VARCHAR(100);
    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_category VARCHAR(50);

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

        IF v_income <= 500000 THEN

            SET v_tax = 0;
            SET v_category = 'NO TAX';

        ELSEIF v_income <= 1000000 THEN

            SET v_tax = (v_income - 500000) * 0.10;
            SET v_category = 'Standard Assessment';

        ELSE

            SET v_tax = calculate_tax(v_income);
            SET v_category = 'High Income Assessment';

        END IF;

        SELECT
            v_name AS full_name,
            v_income AS Annual_Income,
            v_tax AS Tax_Amount,
            v_category AS Assessment_Category;

    END LOOP;

    CLOSE c_taxpayers;
END //


DELIMITER ;
-- Ques4
DELIMITER //
CREATE PROCEDURE update_taxpayer_income(
    IN p_taxpayer_id INT,
    IN p_new_income DECIMAL(12,2)
)
BEGIN

    DECLARE v_name VARCHAR(100);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    IF p_new_income < 0 THEN
        SELECT 'Invalid income. Income cannot be negative.' AS Message;
    ELSE

        SELECT full_name
        INTO v_name
        FROM Taxpayer
        WHERE taxpayer_id = p_taxpayer_id;

        IF v_not_found THEN

            SELECT 'Taxpayer not found' AS Message;

        ELSE

            UPDATE Taxpayer
            SET annual_income = p_new_income
            WHERE taxpayer_id = p_taxpayer_id;

            SELECT
                'Income updated successfully' AS Message,
                v_name AS full_name,
                p_new_income AS New_Income;

        END IF;

    END IF;
END //
DELIMITER ;


--Ques4.
DELIMITER //
CREATE PROCEDURE exception_tax_assessment(
    IN p_taxpayer_id INT
)
BEGIN

    DECLARE v_income DECIMAL(12,2);
    DECLARE v_tax DECIMAL(12,2);
    DECLARE v_not_found BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_not_found = TRUE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        SELECT 'An SQL error occurred.' AS Message;

    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    IF v_not_found THEN

        SELECT 'Taxpayer not found.' AS Message;

    ELSE

        SET v_tax = calculate_tax(v_income);

        SELECT
            v_income AS annual_Income,
            v_tax AS Tax_Amount;

    END IF;
END //

