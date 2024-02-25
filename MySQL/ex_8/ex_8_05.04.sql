#1
DELIMITER $
DROP PROCEDURE IF EXISTS testProc $
CREATE PROCEDURE testProc()
BEGIN
Select sports.name, sportGroups.location
from sports JOIN sportGroups
ON sports.id = sportGroups.sport_id;

END $
DELIMITER ;
CALL testProc();

#2
drop procedure if exists getAllPaymentsAmountOptimized;
delimiter |
CREATE procedure getAllPaymentsAmountOptimized(IN firstMonth INT, IN secMonth INT, IN paymentYear INT, IN studId INT)
BEGIN
    DECLARE iterator int;
    CREATE TEMPORARY TABLE tempTbl(
    student_id int, 
    group_id int,
    paymentAmount double,
    month int
    ) ENGINE = Memory;
    
    
	IF(firstMonth >= secMonth)
    THEN 
		SELECT 'Please enter correct months!' as RESULT;
	ELSE IF((SELECT COUNT(*)
			FROM taxesPayments
			WHERE student_id =studId ) = 0)
        THEN SELECT 'Please enter correct student_id!' as RESULT;
		ELSE
	
	SET ITERATOR = firstMonth;

		WHILE(iterator >= firstMonth AND iterator <= secMonth)
		DO
			INSERT INTO tempTbl
			SELECT student_id, group_id, paymentAmount, month
			FROM taxespayments
			WHERE student_id = studId
			AND year = paymentYear
			AND month = iterator;
    
			SET iterator = iterator + 1;
		END WHILE;
		END IF;
    
    END IF;
		SELECT *
        FROM tempTbl;
        DROP TABLE tempTbl;
END;
|
DELIMITER ;

CALL getAllPaymentsAmountOptimized(1,6,2021,1);