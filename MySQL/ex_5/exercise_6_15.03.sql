#1.Имер клас и телефон на футболистите
use school_sport_clubs;
Select students.name, students.class, students.phone
FROM students
JOIN student_Sport on students.id = student_Sport.student_id
JOIN sportGroups on sportGroups.id = student_Sport.sportGroup_id
JOIN sports on sports.id = sportGroups.sport_id
WHERE sports.name = 'Football';

#2.Всички треньори по Волейбол
SELECT coaches.name as Coach, sports.name as Sport 
FROM coaches JOIN sportgroups as sportgroups on coaches.id = sportgroups.coach_id
			JOIN sports as sports ON sportgroups.sport_id = sports.id
            WHERE sports.name = 'Volleyball';
            
#3.Изведете името на треньора и спорта, който тренира ученик с име Илиян Иванов
SELECT students.name as StudentName, sport.name as SportName, coach.name as Coach
FROM students JOIN student_sport as studentsport ON students.id = studentsport.student_id
			JOIN sportGroups as sportgroups ON studentsport.sportGroup_id = sportgroups.id
            JOIN sports as sport ON sportgroups.id = sportgroups.id
            JOIN coaches as coach ON coach.id = sportgroups.id
WHERE students.name='Iliyan Ivanov';

#4.Изведете имената на учениците, класовете, място на тренировка и името на треньора на тези, чийто спорт започва от 8:00
Select students.name, sports.name, sportGroups.location, coaches.name
from students join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id=sportGroups.id
join sports on sportGroups.id=sports.id
join coaches on coaches.id= sportGroups.id
where sportGroups.hourOfTraining = '8:00';