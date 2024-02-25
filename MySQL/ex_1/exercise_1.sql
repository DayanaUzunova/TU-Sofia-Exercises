drop database if exists sportclubs;
create database sportclubs;
use sportclubs;

create table sports(
id int auto_increment primary key,
sport varchar(55) not null
);

create table students(
id int auto_increment primary key,
name varchar(255) not null,
fNum char(10) not null unique,
phone varchar(55) null
);

create table coaches(
id int auto_increment primary key,
name varchar(255) not null,
personalnumber CHAR(10) not null unique
);

create table sportgroups(
id int auto_increment primary key,
dayofweek ENUM('MONDAY, .... , SUNDAY'),
hourofplay TIME not null,
location VARCHAR(255) not null,
sport_id INT not null,
coach_id INT not null,
constraint foreign key(sport_id) references sports(id),
constraint foreign key(coach_id) references coaches(id),
UNIQUE KEY(dayofweek, hourofplay, location)
);

create table student_group(
student_id INT not null,
group_id INT not null,
constraint foreign key(student_id) references students(id),
constraint foreign key(group_id) references sportgroups(id),
primary key(student_id, group_id)
);