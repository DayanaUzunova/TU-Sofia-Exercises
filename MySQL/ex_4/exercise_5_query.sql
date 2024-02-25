#1
INSERT INTO students(name, egn, address, phone, class)
VALUES ('Ivan Invanov', '9207186371', 'София-Сердика', 0888892950, 10);

#2
SELECT *
FROM students
ORDER BY students.name;

#3
DELETE
FROM students
WHERE egn = '9207186371';

#4
SELECT students.name, sport.name
FROM students
         JOIN studentSport on students.id = studentSport.student_id
         JOIN sportGroups on sportGroups.id = studentSport.sportGroup_id
         JOIN sports on sports.id = sportsGroups.sport_id;


#5
SELECT students.name, students.class, sportGroups.id
FROM students
         JOIN studentSport on students.id = studentSport.student_id
         JOIN sportGroups on sportGroups.id = students.sportGroup_id
WHERE sportGroups.dayOfWeek = 'monday';

#6
SELECT coaches.name FROM coaches
    JOIN sportGroups on coaches.id = sportGroups.coach_id
JOIN sports on sports.id = sportGroups.sport_id
WHERE sport.name = 'Football';

#7
SELECT sportGroups.location,sportGroups.hourOfTraining,sportGroups.dayOfWeek
FROM sportGroups
    JOIN sports on sport.id = sportGroups.sport_id
WHERE sport.name = 'Volleyball';

#8
SELECT sport.name FROM students
JOIN student_sport on students.id = studentSport.student_id
JOIN sportGroups on sportGroups.id = studentSport.sportGroup_id
JOIN sports on sport.id = sportGroups.sport_id
WHERE students.name = 'Iliyan Ivanov';

#9
SELECT students.name FROM students
    JOIN studentSport on students.id = studentsSport.student_id
JOIN sportGroups on sportGroups.id = studentsSport.sportGroup_id
JOIN coaches on coaches.id = sportGroups.coach_id
WHERE coaches.name = 'Ivan Todorov Petkov';
