DROP DATABASE IF EXISTS airport;
CREATE DATABASE airport;
USE airport;


CREATE TABLE airport.planes(
id INT AUTO_INCREMENT PRIMARY KEY,
brand VARCHAR(255) NOT NULL,
number INT NOT NULL,
dateOfCreation DATE NOT NULL,
creator VARCHAR(255) NOT NULL,
numberOfPassenger INT NOT NULL
);

CREATE TABLE airport.stewardess(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn INT NOT NULL,
mail VARCHAR(255) NOT NULL,
telephone INT NOT NULL
);

CREATE TABLE airport.pilot(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn INT NOT NULL,
mail VARCHAR(255) NOT NULL,
telephone INT NOT NULL
);

CREATE TABLE airport.flights(
id INT AUTO_INCREMENT PRIMARY KEY ,
numberOfFlight VARCHAR(10) NOT NULL,
numberOfPlane VARCHAR(10) NOT NULL,
pilot VARCHAR(255) NOT NULL,
stewardess VARCHAR(255) NOT NULL,
hourOfTakeOff TIME NOT NULL,
hourOfLanding TIME NOT NULL,
firstDestination VARCHAR(255) NOT NULL,
secondDestination VARCHAR(255) NOT NULL,
plane_id int not null,
CONSTRAINT FOREIGN KEY (plane_id)
	REFERENCES planes(id)
);

CREATE TABLE flights_stewardess(
flight_id int not null,
stewardess_id int not null,
CONSTRAINT FOREIGN KEY(flight_id)
	REFERENCES flights(id),
CONSTRAINT FOREIGN KEY(stewardess_id)
	REFERENCES stewardess(id)
);

CREATE TABLE flights_pilot(
flight_id int not null,
pilot_id int not null,
CONSTRAINT FOREIGN KEY(flight_id)
	REFERENCES flights(id),
CONSTRAINT FOREIGN KEY(pilot_id)
	REFERENCES pilot(id)
);