DROP DATABASE IF EXISTS movies;
CREATE DATABASE movies;
USE movies;

create table movies.people(
id int auto_increment primary key,
name varchar(255) not null,
age varchar(255) not null,
email varchar(255) not null,
telephone varchar(255) not null
);

create table movies.cinemas(
id int auto_increment primary key,
name varchar(255) not null,
location varchar(255) not null
);

create table movies.movie(
id int auto_increment primary key,
name varchar(255) not null,
year varchar(255) not null,
country varchar(255) not null,
movie_id int not null,
CONSTRAINT FOREIGN KEY (movie_id) 
		REFERENCES people(id)
);

create table movies.hall(
id int auto_increment primary key,
number varchar(255) not null,
name varchar(255) not null,
status varchar(255) not null,
cinema_id int not null,
CONSTRAINT FOREIGN KEY (cinema_id) 
		REFERENCES cinemas(id)
);

create table movies.projection(
id int auto_increment primary key,
name varchar(255) not null,
timeofProjection varchar(255) not null,
numberOfPeople varchar(255) not null,
movie_id int not null,
people_id int not null,
hall_id int not null,
CONSTRAINT FOREIGN KEY (movie_id) 
		REFERENCES movie(id),
CONSTRAINT FOREIGN KEY (hall_id) 
	REFERENCES hall(id)
);