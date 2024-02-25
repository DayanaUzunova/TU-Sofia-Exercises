#1
DELIMITER $
DROP PROCEDURE IF EXISTS test $
CREATE PROCEDURE test(IN name VARCHAR(255))
BEGIN
Select sports.name, sportGroups.location, sportGroups.dayOfWeek, students.name, students.phone
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join coaches on sportgroups.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id;

END $
DELIMITER ;
set @name ='Ivan';
CALL test(@name);

#2
DELIMITER $
DROP PROCEDURE IF EXISTS test2 $
CREATE PROCEDURE test2(IN id INT)
BEGIN
Select sports.name, students.name, coaches.name
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join coaches on sportgroups.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id
where id = sports.id;

END $
|
DELIMITER ;
CALL test2(1);

#3
DELIMITER |
DROP PROCEDURE IF EXISTS test3 |
CREATE PROCEDURE test3(IN studentName VARCHAR(255), inYear YEAR)
BEGIN
SELECT studentName, AVG(taxesPayments.paymentAmount) AS AverageTaxes
FROM students
JOIN taxespayments ON students.id=taxespayments.student_id
WHERE studentName=students.name
AND inYear=taxespayments.year;
END;
|
DELIMITER ;
CALL test3('Iliyan Ivanov',2022); 

#4
DELIMITER |
DROP PROCEDURE IF EXISTS test4 |
CREATE PROCEDURE test4(IN coachName VARCHAR(255))
BEGIN
DECLARE counter INT;
SELECT COUNT(sportgroups.coach_id) INTO counter
FROM coaches
JOIN sportgroups ON sportgroups.coach_id=coaches.id
WHERE coaches.name=coachName;
IF(counter = 0 OR counter = NULL)
THEN
SELECT 'No groups for the trainer!' AS RESULT;
ELSE
SELECT counter;
END IF;
END;
|
DELIMITER ;
 
CALL test4('Ivan Todorov Petkov');

#5
use transaction_test;

DELIMITER $
DROP PROCEDURE IF EXISTS trans $
CREATE PROCEDURE trans(in id1 INT, in id2 INT)
BEGIN
START TRANSACTION;
update customer_accounts
	set amount = amount - 50000
	WHERE customer_accounts.customer_id = id1 AND amount >= 50000;
    
IF(row_count()=0)
THEN ROLLBACK;
ELSE

update customer_accounts
	set amount = amount + 50000 
	WHERE customer_accounts.customer_id = id2;
IF(row_count()=0)
	THEN ROLLBACK;
ELSE commit;
END IF;
END IF;
END $
DELIMITER ;

CALL trans(1,2);

#6
DELIMITER $
DROP PROCEDURE IF EXISTS trans2 $
CREATE PROCEDURE trans2(in curr VARCHAR(10),in name1 VARCHAR(255), in name2 VARCHAR(255))
BEGIN
START TRANSACTION;
update customer_accounts
	set amount = amount - 50000
	WHERE currency = 'BGN' AND customer_id = (SELECT id FROM customers WHERE name = name1);
    
IF(row_count()=0)
	THEN ROLLBACK;
END IF;    

update customer_accounts
	set amount = amount + 50000 
		WHERE currency = 'BGN' AND customer_id = (SELECT id FROM customers WHERE name = name2);
IF(row_count()=0)
	THEN ROLLBACK;
ELSE commit;
END IF;
END $
DELIMITER ;

CALL trans2('BGN','Stoyan Pavlov Pavlov','Ivan Petrov Iordanov');