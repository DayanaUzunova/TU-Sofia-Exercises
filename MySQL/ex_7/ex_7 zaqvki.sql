#1
SELECT students.name,students.class,students.phone
FROM students
join student_Sport on students.id = student_Sport.student_id
join sportGroups on sportGroups.id = student_Sport.sportGroup_id
join sports on sports.id = sportGroups.sport_id
where sports.name = 'Football';

#2
Select coaches.name, sports.name 
from coaches join sportgroups on coaches.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id
where sports.name = 'Volleyball';

#3
SELECT coaches.name,sports.name, sportgroups.dayOfWeek, sportgroups.location
from students join student_sport on students.id = student_sport.student_id
join sportgroups on sportgroups.id = student_sport.sportGroup_id
join coaches on sportgroups.coach_id = coaches.id
join sports on sports.id = sportGroups.sport_id
where students.name = 'Maria Hristova Dimova';

#4
Select taxespayments.paymentAmount from taxespayments
join sportgroups on group_id = sportgroups.id
join coaches on sportgroups.coach_id = coaches.id
where taxespayments.paymentAmount >'700' and coaches.egn = '7509041245';

#5 
SELECT count(students.id) as SumOfStudent
FROM students
join student_sport on students.id = student_id
join sportgroups on sportgroups.id = sportGroup_id
join sports on sports.id = sport_id
where sports.name = 'Football';

#6
SELECT coaches.name, sports.name
FROM coaches join sportgroups on coaches.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id;
