SET SERVEROUTPUT ON;
-- partA
-- task1
BEGIN
    DBMS_OUTPUT.PUT_LINE('Welcome to TaxationDB');
END;
/

--task3
DECLARE
    v_name   Taxpayer.full_name%TYPE;
    v_income Taxpayer.annual_income%TYPE;
BEGIN
    SELECT full_name, annual_income INTO v_name, v_income FROM Taxpayer
    WHERE taxpayer_id = 101;
    DBMS_OUTPUT.PUT_LINE('Taxpayer Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Annual Income: ' || v_income);
END;
/

-- Level 0
-- Ques1
DECLARE
    v_income NUMBER(12,2);
    v_tax    NUMBER(12,2);
BEGIN
    SELECT annual_income INTO v_income FROM Taxpayer WHERE taxpayer_id = 101;
    v_tax := v_income * 0.10;
    DBMS_OUTPUT.PUT_LINE('Annual Income: ' || v_income);
    DBMS_OUTPUT.PUT_LINE('10% of Annual Income: ' || v_tax);
END;
/

-- Ques2
CREATE OR REPLACE PROCEDURE display_taxpayer_details(p_taxpayer_id IN NUMBER)
IS
    v_name       Taxpayer.full_name%TYPE;
    v_pan        Taxpayer.pan_number%TYPE;
    v_occupation Taxpayer.occupation%TYPE;
    v_income     Taxpayer.annual_income%TYPE;
BEGIN
    SELECT full_name,
           pan_number,
           occupation,
           annual_income
    INTO v_name,
         v_pan,
         v_occupation,
         v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;
    DBMS_OUTPUT.PUT_LINE('Taxpayer Name : ' || v_name);
    DBMS_OUTPUT.PUT_LINE('PAN Number    : ' || v_pan);
    DBMS_OUTPUT.PUT_LINE('Occupation    : ' || v_occupation);
    DBMS_OUTPUT.PUT_LINE('Annual Income : ' || v_income);
END;
/
BEGIN
    display_taxpayer_details(101);
END;
/

-- Ques3
DECLARE
    v_status NUMBER;
BEGIN
    SELECT is_active
    INTO v_status
    FROM Taxpayer
    WHERE taxpayer_id = 101;

    IF v_status = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Taxpayer Status: Active');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Taxpayer Status: Inactive');
    END IF;
END;
/

-- Ques4
CREATE OR REPLACE FUNCTION check_taxable(
    p_income IN NUMBER
)
RETURN VARCHAR2
IS
BEGIN
    IF p_income > 0 THEN
        RETURN 'Taxable';
    ELSE
        RETURN 'Non-Taxable';
    END IF;
END;
/
SELECT check_taxable(0) AS status FROM dual;

-- Ques5
DECLARE
    v_num NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);

        v_num := v_num + 1;

        EXIT WHEN v_num > 10;
    END LOOP;
END;
/


-- Level1
-- Ques1
CREATE PROCEDURE classify_taxpayer_income(p_taxpayer_id IN NUMBER)
IS
    v_income Taxpayer.annual_income%TYPE;
BEGIN
    SELECT annual_income INTO v_income FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
    IF v_income > 1000000 THEN
        DBMS_OUTPUT.PUT_LINE('Income Classification: High Income');

    ELSIF v_income >= 500000 THEN
        DBMS_OUTPUT.PUT_LINE('Income Classification: Medium Income');

    ELSE
        DBMS_OUTPUT.PUT_LINE('Income Classification: Low Income');
    END IF;
END;
/
BEGIN
    classify_taxpayer_income(103);
END;
/

-- Ques2
CREATE OR REPLACE FUNCTION get_annual_income(
    p_taxpayer_id IN NUMBER
)
RETURN NUMBER
IS
    v_income Taxpayer.annual_income%TYPE;
BEGIN
    SELECT annual_income
    INTO v_income
    FROM Taxpayer
    WHERE taxpayer_id = p_taxpayer_id;

    RETURN v_income;
END;
/
SELECT full_name,get_annual_income(taxpayer_id) AS annual_income FROM Taxpayer;


-- Level2
-- Ques1
DECLARE
    CURSOR taxpayer_cursor IS
        SELECT full_name, annual_income, occupation FROM Taxpayer WHERE is_active = 1;
BEGIN
    FOR taxpayer_rec IN taxpayer_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Taxpayer Name: ' || taxpayer_rec.full_name);
        DBMS_OUTPUT.PUT_LINE('Annual Income: ' || taxpayer_rec.annual_income);
        DBMS_OUTPUT.PUT_LINE('Occupation: ' || taxpayer_rec.occupation);
        DBMS_OUTPUT.PUT_LINE('---------------------------');
    END LOOP;
END;
/

-- Ques2
CREATE OR REPLACE PROCEDURE find_taxpayer(p_taxpayer_id IN NUMBER)
IS
    v_name   Taxpayer.full_name%TYPE;
    v_income Taxpayer.annual_income%TYPE;
BEGIN
    SELECT full_name, annual_income INTO v_name, v_income FROM Taxpayer WHERE taxpayer_id = p_taxpayer_id;
    DBMS_OUTPUT.PUT_LINE('Taxpayer Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Annual Income: ' || v_income);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Taxpayer not found');
END;
/
BEGIN
    find_taxpayer(109);
END;
/