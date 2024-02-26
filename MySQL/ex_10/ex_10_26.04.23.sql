#Zadacha 1

DROP TRIGGER IF EXISTS before_salarypayment_delete;
delimiter |
CREATE TRIGGER before_salarypayment_delete BEFORE DELETE ON salarypayments
FOR EACH ROW
BEGIN
INSERT INTO salarypayments_log(operation,
old_coach_id,
old_month,
old_year,
old_salaryAmount,
old_dateOfPayment,
dateOfLog)
VALUES('DELETE', OLD.coach_id, OLD.month,
OLD.year, OLD.salaryAmount, OLD.dateOfPayment, NOW());
end;
|
delimiter ;

UPDATE salarypayments SET salaryamount = '2000' WHERE id = 13;
DELETE FROM salarypayments WHERE id = 6;

#Zadacha 2
 
DELETE FROM salarypayments;
 
INSERT INTO salarypayments(
coach_id,
month,
year,
salaryAmount,
dateOfPayment)
SELECT old_coach_id, 
       old_month, 
       old_year, 
       old_salaryAmount,
  old_dateOfPayment
FROM salarypayments_log
WHERE operation = 'DELETE';
 
SELECT * FROM salarypayments;
 
#Zadacha 3
 
DROP TRIGGER IF EXISTS before_student_sport_insert;
delimiter |
CREATE TRIGGER before_student_sport_insert BEFORE INSERT ON student_sport
FOR EACH ROW
BEGIN
IF (SELECT COUNT(*) FROM student_sport WHERE student_id = NEW.student_id) >=2 THEN
SIGNAL SQLSTATE '45000'
SET message_text = 'A student cannot be added in more than 2 groups.';
END IF;
end;
|
delimiter ;
 
 
#Zadacha 4
CREATE OR REPLACE VIEW zad4 AS
SELECT students.name, COUNT(sportgroup_id) AS number_of_groups
FROM students JOIN student_sport ON student_sport.student_id=students.id
GROUP BY student_sport.student_id;

#Zadacha 5

delimiter |
CREATE PROCEDURE sport_info(IN given_sport VARCHAR(50))
BEGIN
SELECT sports.name, coaches.name, sportgroups.location, sportgroups.hourOfTraining, sportgroups.dayOfWeek
FROM sports
JOIN sportgroups ON sportgroups.sport_id = sports.id
JOIN coaches ON sportgroups.coach_id = coaches.id
WHERE sports.name = given_sport;
END;

|
delimiter ;

CALL sport_info("Football");

DROP PROCEDURE IF EXISTS sport_info;