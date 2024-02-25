#1 имена започващи на и
SELECT id, name,egn,address,phone,class
FROM students
WHERE name LIKE 'I%';

#2 името на студента, името на спотра и името на треньора
SELECT students.name, sports.name, coaches.name
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join coaches on sportgroups.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id;

#3 името на студента и таксите, които е платил
Select students.name, taxespayments.paymentAmount, taxespayments.month
From students join taxespayments on students.id = taxespayments.student_id
where paymentAmount >= 250;

#4 името на студента, името на спорта и къде тренират
Select students.name, sports.name, sportgroups.location
From students join student_sport ON students.id = student_sport.student_id
join sportgroups ON sportgroups.id = student_sport.sportGroup_id
join sports on sportgroups.sport_id = sports.id;

#5 името на студента, денят на тренировките и името на треньора
Select students.name, sportgroups.dayOfWeek, coaches.name
From students join student_sport ON students.id = student_sport.student_id
join sportgroups ON sportgroups.id = student_sport.sportGroup_id
join coaches ON coaches.id = sportgroups.coach_id;

#6
Select students.name, students.phone, students.egn, sportgroups.hourOfTraining, sportgroups.location, coaches.name
From students join student_sport ON students.id = student_sport.student_id
join sportgroups ON sportgroups.id = student_sport.sportGroup_id
join coaches ON coaches.id = sportgroups.coach_id;

#Изведете името на треньора,спорта,денят и мястото на тренировки за Maria Hristova Dimova.
SELECT students.name, coaches.name, sports.name, sportgroups.dayOfWeek, sportgroups.location
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join sports on sports.id = sportgroups.sport_id
join coaches on coaches.id = sportgroups.coach_id
where students.name = 'Maria Hristova Dimova';


SELECT students.name, coaches.name, sports.name, sportgroups.dayOfWeek, sportgroups.location
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join sports on sports.id = sportgroups.sport_id
join coaches on coaches.id = sportgroups.coach_id
where coaches.name = 'georgi Ivanov Todorov';

#7 Изведете имената на всички треньори по волейбол
Select coaches.name, sports.name
from sportgroups join coaches on coaches.id = sportgroups.coach_id
join sports on sports.id = sportgroups.sport_id
where sports.name = 'Volleyball';

#8 Изведете имената, класовете и телефоните на всички ученици, които тренират футбол.
Select students.name, students.class, students.phone, sports.name
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join sports on sports.id = sportgroups.sport_id
where sports.name = 'Football';

#9 извеждаме имена на спорт, който започва с буквата Ф и треньора
Select sports.name, coaches.name
From sportgroups join sports on sports.id = sportgroups.sport_id
join coaches on coaches.id = sportgroups.coach_id
where sports.name like 'F%';

#10 вложени
SELECT coaches.name,sports.name
from coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id
);

#11
SELECT coaches.name,sports.name
from coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id
)
where coaches.id = 1;

#12 Изведете списък с имената на учениците и класовете им, както и номера (id) на групата в която тренират за всички ученици, които тренират в 
#понеделник от 08:00 и са при треньор с име „Иван Тодоров Петров“, но само за групите му по футбол.
Select students.name, students.class, sportgroups.id
From students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join sports on sports.id = sportgroups.sport_id
join coaches on coaches.id = sportgroups.coach_id
where sports.name = 'Football';

#OUTER JOIN
SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups LEFT OUTER JOIN coaches
ON sportgroups.coach_id = coaches.id;