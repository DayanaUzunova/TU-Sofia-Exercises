#1
DELIMITER //
DROP PROCEDURE IF EXISTS MakePayment //
CREATE PROCEDURE MakePayment(
    IN payment_student_id INT,
    IN payment_amount DOUBLE,
    OUT payment_success BIT
)
BEGIN
    DECLARE new_group_id INT;
    DECLARE new_month TINYINT;
    DECLARE new_year YEAR;
    DECLARE new_monthly_payment DOUBLE;
    
    -- Намерете групата, към която принадлежи студента
    SELECT group_id INTO new_group_id
    FROM student_sport
    WHERE student_id = payment_student_id
    LIMIT 1;
    
    -- Вземете текущия месец и година
    SET new_month = MONTH(CURDATE());
    SET new_year = YEAR(CURDATE());
    
    -- Проверете дали съществува такса за текущия месец и група
    SELECT paymentAmount INTO new_monthly_payment
    FROM taxesPayments
    WHERE student_id = payment_student_id
    AND group_id = new_group_id
    AND month = new_month
    AND year = new_year;
    
    -- Проверете дали преводът е успешен
    IF payment_amount >= new_monthly_payment THEN
        SET payment_success = 1;
    ELSE
        SET payment_success = 0;
    END IF;
    
    -- Актуализирайте таблицата с плащания
    INSERT INTO taxesPayments (student_id, group_id, paymentAmount, month, year, dateOfPayment)
    VALUES (payment_student_id, new_group_id, payment_amount, new_month, new_year, NOW());
    
    -- Актуализирайте флага за плащане в таблицата с плащания
    UPDATE coach_work
    SET isPayed = 1
    WHERE group_id = new_group_id
    AND MONTH(date) = new_month
    AND YEAR(date) = new_year;
    
END //

DELIMITER ;

SET @success = 0;
CALL MakePayment(1, 200, @success);
SELECT @success;

#2
DELIMITER //
DROP PROCEDURE IF EXISTS makePayments //
CREATE PROCEDURE makePayments()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE studentId, groupId INT;
    DECLARE paymentAmount DOUBLE;
    DECLARE cur CURSOR FOR SELECT student_id, group_id, paymentAmount FROM taxesPayments WHERE dateOfPayment IS NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    START TRANSACTION;
    
    OPEN cur;
    
    payment_loop: LOOP
        FETCH cur INTO studentId, groupId, paymentAmount;
        
        IF done THEN
            LEAVE payment_loop;
        END IF;
        
        -- Извършване на плащането
        UPDATE taxesPayments SET dateOfPayment = NOW() WHERE student_id = studentId AND group_id = groupId;
        
        IF ROW_COUNT() = 1 THEN
            -- Плащането е успешно
            COMMIT;
        ELSE
            -- Плащането е неуспешно
            ROLLBACK;
            
            -- Запис в таблицата "длъжници"
            INSERT INTO debtors (student_id, group_id, paymentAmount) VALUES (studentId, groupId, paymentAmount);
        END IF;
    END LOOP;
    
    CLOSE cur;
    
    END//
    
DELIMITER ;

#3
DELIMITER |
CREATE EVENT monthly_event
ON SCHEDULE
    EVERY 1 MONTH
    STARTS '2021-01-28 00:00:00'
DO
BEGIN
    CALL makePayments(MONTH(NOW()),YEAR(NOW()));
END;
|
DELIMITER ;

#4
DELIMITER //
DROP VIEW IF EXISTS client_info //
CREATE VIEW client_info AS
SELECT students.name, taxesPayments.dateOfPayment, sportGroups.location, taxesPayments.paymentAmount
FROM students
JOIN taxesPayments ON students.id = taxesPayments.student_id
JOIN sportGroups ON taxesPayments.group_id = sportGroups.id;

#5
DELIMITER //
DROP TRIGGER IF EXISTS check_payment_amount //
CREATE TRIGGER check_payment_amount
BEFORE INSERT ON taxesPayments
FOR EACH ROW
BEGIN
    IF NEW.paymentAmount < 10 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Payment amount must be at least 10.';
    END IF;
END//

DELIMITER ;

#6
DELIMITER //
DROP TRIGGER IF EXISTS check_payment_amount_2 //
CREATE TRIGGER check_payment_amount_2
BEFORE INSERT ON taxesPayments
FOR EACH ROW
BEGIN
    DECLARE total_amount DOUBLE;
    
    SELECT SUM(paymentAmount) INTO total_amount
    FROM taxesPayments
    WHERE student_id = NEW.student_id
        AND group_id = NEW.group_id
        AND year = NEW.year;
    
    IF total_amount + NEW.paymentAmount < (
        SELECT COUNT(*) * 200
        FROM sportGroups
        WHERE id = NEW.group_id
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Payment amount is less than the due amount.';
    END IF;
END//
DELIMITER ;

#7
DELIMITER //
DROP PROCEDURE IF EXISTS GetClientData //
CREATE PROCEDURE GetClientData(IN clientName VARCHAR(255))
BEGIN
    SELECT students.id, students.name, students.egn, students.address, students.phone, students.class,
        sportGroups.id, sportGroups.location, sportGroups.dayOfWeek, sportGroups.hourOfTraining,
        taxesPayments.paymentAmount, taxesPayments.month, taxesPayments.year, taxesPayments.dateOfPayment
    FROM students
    JOIN student_sport ON students.id = student_sport.student_id
    JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
    LEFT JOIN taxesPayments ON students.id = taxesPayments.student_id AND sportGroups.id = taxesPayments.group_id
    WHERE students.name = clientName;
END //

DELIMITER ;