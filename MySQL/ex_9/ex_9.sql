#1
CREATE VIEW cv (coach_Name, groupInfo, sport_Name, year, month, salaryamount)
AS
SELECT coaches.name, CONCAT(sportgroups.id + ' - ' + sportgroups.location) AS groupInfo, sports.name,
salarypayments.year, salarypayments.month, salarypayments.salaryAmount
FROM sportgroups 
JOIN coaches ON sportgroups.coach_id=coaches.id
JOIN sports ON sportgroups.sport_id=sports.id
JOIN salarypayments ON salarypayments.coach_id=coaches.id
WHERE salarypayments.month = month(now()) and salarypayments.year = year(now());

#2
delimiter |
DROP PROCEDURE IF EXISTS Zadacha2 |
create procedure Zadacha2()
begin
SELECT students.name FROM students
JOIN student_sport ON student_sport.student_id=students.id
JOIN sportgroups ON sportgroups.id=student_sport.sportgroup_id
GROUP BY student_id
HAVING COUNT(student_sport.sportgroup_id)>1;
end;
|
delimiter |
CALL Zadacha2();

#3
delimiter |
DROP PROCEDURE IF EXISTS Zadacha3 |
create procedure Zadacha3()
begin
SELECT coaches.name, sportgroups.id FROM coaches
LEFT JOIN sportgroups ON sportgroups.coach_id=coaches.id
WHERE sportgroups.id is NULL;
end;
|
delimiter |
CALL Zadacha3();

#4
use  transaction_test

DELIMITER $$
DROP PROCEDURE IF EXISTS transfer_money;
CREATE PROCEDURE transfer_money(
    IN amount DECIMAL(10, 2),
    IN currency VARCHAR(3),
    OUT newSum DECIMAL(10, 2),
    OUT message VARCHAR(255)
)
BEGIN
    DECLARE bgn_rate DECIMAL(10, 4) DEFAULT 1;
    DECLARE eur_rate DECIMAL(10, 4) DEFAULT 1;

    IF currency = 'EUR' THEN
        SELECT value INTO eur_rate FROM exchange_rates WHERE currency = 'EUR';
        SET amount = amount * eur_rate;
    ELSEIF currency = 'BGN' THEN
        SELECT value INTO bgn_rate FROM exchange_rates WHERE currency = 'BGN';
        SET amount = amount / bgn_rate;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Unsupported currency';
    END IF;
END$$

DELIMITER ;

#5
USE transaction_test;
DROP PROCEDURE IF EXISTS transfer_money_between_accounts;
DELIMITER $$

CREATE PROCEDURE transfer_money_between_accounts(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(10, 2)
)
transfer_money_between_accounts:
BEGIN
    DECLARE from_currency VARCHAR(3);
    DECLARE to_currency VARCHAR(3);
    DECLARE from_amount DECIMAL(10, 2);
    DECLARE to_amount DECIMAL(10, 2);
    
    SELECT currency, amount INTO from_currency, from_amount FROM customer_accounts WHERE id = from_account;
    IF from_currency IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid from_account';
        LEAVE transfer_money_between_accounts;
    END IF;


    SELECT currency, amount INTO to_currency, to_amount FROM customer_accounts WHERE id = to_account;
    IF to_currency IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid to_account';
        LEAVE transfer_money_between_accounts;
    END IF;

    IF from_currency != to_currency THEN
        CALL exchange_currency(from_account, to_account, amount, from_currency, to_currency);
        SELECT amount INTO from_amount FROM customer_accounts WHERE id = from_account;
    END IF;

    IF from_amount < amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough money';
        LEAVE transfer_money_between_accounts;
    END IF;

    START TRANSACTION;
    UPDATE customer_accounts SET amount = amount - amount WHERE id = from_account;
    IF (ROW_COUNT() = 0) THEN
        ROLLBACK;
    ELSE
    UPDATE customer_accounts SET amount = amount + amount WHERE id = to_account;
    IF (ROW_COUNT() = 0) THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END IF;
END$$

DELIMITER ;