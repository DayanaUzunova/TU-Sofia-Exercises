DROP DATABASE IF EXISTS songs_purchase;
CREATE DATABASE songs_purchase;
USE songs_purchase;

CREATE TABLE songs_purchase.labels(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
location VARCHAR(255) NOT NULL,
date_of_creation DATE NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.prices(
id INT AUTO_INCREMENT PRIMARY KEY,
price DECIMAL NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.song(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(255) NOT NULL,
arrangement ENUM('flow','voicing','mix'),
length TIME NOT NULL,
release_date DATETIME NOT NULL,
user VARCHAR(255) NOT NULL,
userName VARCHAR(255) NOT NULL,
label_id INT NOT NULL,
price_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(label_id) REFERENCES labels(id),
CONSTRAINT FOREIGN KEY(price_id) REFERENCES prices(id)
)Engine = Innodb;

CREATE TABLE songs_purchase.albums(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
release_date DATE NOT NULL,
price_id INT NOT NULL,
label_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(price_id) REFERENCES prices(id),
CONSTRAINT FOREIGN KEY(label_id) REFERENCES labels(id)
)Engine = Innodb;

CREATE TABLE songs_purchase.users(
id INT AUTO_INCREMENT PRIMARY KEY,
user ENUM('composer','singer', 'group'),
name VARCHAR(255) NOT NULL,
date_of_birth DATE NOT NULL,
nationality VARCHAR(255) NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.genres(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.customers(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
username VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.orders(
id INT AUTO_INCREMENT PRIMARY KEY,
number INT NOT NULL,
date DATETIME NOT NULL,
customer_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(customer_id) REFERENCES customers(id)
)Engine = Innodb;

CREATE TABLE songs_purchase.rankings(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
place INT NOT NULL,
date_of_ranking DATE NOT NULL
)Engine = Innodb;

CREATE TABLE songs_purchase.users_songs(
user_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(user_id) REFERENCES users(id),
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(user_id, song_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.songs_albums(
album_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(album_id) REFERENCES albums(id),
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(album_id, song_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.songs_genres(
genre_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(genre_id) REFERENCES genres(id),
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(genre_id, song_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.songs_ranking(
song_id INT NOT NULL,
ranking_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
CONSTRAINT FOREIGN KEY(ranking_id) REFERENCES rankings(id),
PRIMARY KEY(song_id, ranking_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.songs_customers(
customer_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(customer_id) REFERENCES customers(id),
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(customer_id, song_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.song_orders(
order_id INT NOT NULL,
song_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(id),
CONSTRAINT FOREIGN KEY(song_id) REFERENCES song(id),
PRIMARY KEY(order_id, song_id)
)Engine = Innodb;


CREATE TABLE songs_purchase.order_prices(
order_id INT NOT NULL,
price_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(id),
CONSTRAINT FOREIGN KEY(price_id) REFERENCES prices(id),
PRIMARY KEY(order_id, price_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.users_albums(
user_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(user_id) REFERENCES users(id),
CONSTRAINT FOREIGN KEY(album_id) REFERENCES albums(id),
PRIMARY KEY(user_id, album_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.orders_albums(
order_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(id),
CONSTRAINT FOREIGN KEY(album_id) REFERENCES albums(id),
PRIMARY KEY(order_id, album_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.customers_albums(
customer_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(customer_id) REFERENCES customers(id),
CONSTRAINT FOREIGN KEY(album_id) REFERENCES albums(id),
PRIMARY KEY(customer_id, album_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.genres_albums(
genre_id INT NOT NULL,
album_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(genre_id) REFERENCES genres(id),
CONSTRAINT FOREIGN KEY(album_id) REFERENCES albums(id),
PRIMARY KEY(genre_id, album_id)
)Engine = Innodb;

CREATE TABLE songs_purchase.songPrices_log(
id INT auto_increment primary key,
operation ENUM('INSERT','UPDATE','DELETE') not null,
old_price_id DECIMAL,
new_price_id DECIMAL
)Engine = Innodb;

INSERT INTO labels
VALUES 	(NULL, 'Payner', 'Sofia', '2019-05-10'), #Preslava
        (NULL, 'Sheeran Production', 'Plovdiv', '2020-11-06'), #Ed Sheeran
		(NULL, 'Miley Music', 'Blagoevgrad', '2023-08-11'), #Miley
		(NULL, 'Giela', 'Sofia', '2000-08-17'), #Gloria
		(NULL, 'Upsurt', 'Plovdiv', '2021-10-07'), #Ico Hazarta
		(NULL, 'Republic Records', 'Sofia', '2021-08-03'), #The Weekend
		(NULL, 'James Music', 'Sofia', '2019-09-09') #James Arthur
        ;

INSERT INTO prices
VALUES 	(NULL, '200.000'),
		(NULL, '120.000'),
		(NULL, '130.000'),
		(NULL, '140.000'),
		(NULL, '120.000'),
		(NULL, '250.000'),
		(NULL, '150.000'),
		(NULL, '180.000')
        ;
        
INSERT INTO song
VALUES	(NULL, 'Beden v surceto', 'mix', '00:03:51', '2020-06-19 18:00:00', 'singer', 'Preslava', 1, 2),
		(NULL, 'Flowers', 'mix', '00:03:21', '2023-03-15 13:00:00', 'singer', 'Miley Cyrus', 3, 5),
		(NULL, 'Call out my name', 'flow', '00:02:55', '2022-08-10 10:00:00', 'composer', 'The Weekend', 6, 4),
		(NULL, 'Imposiible', 'voicing', '00:03:30', '2016-06-15 15:30:00', 'singer', 'James Arthur', 7, 7),
		(NULL, 'Starboy', 'flow', '00:03:39', '2023-01-10 18:00:00', 'composer', 'The Weekend', 6, 8),
		(NULL, 'Bravo', 'flow', '00:03:10', '2020-02-02 18:00:00', 'singer', 'Ico Hazarta', 5, 2),
		(NULL, 'Katerino mome', 'voicing', '00:04:22', '2014-05-04 12:00:00', 'singer', 'Gloria', 4, 4),
		(NULL, 'Kradi, kradi', 'voicing', '00:04:33', '2010-11-20 18:00:00', 'group', 'Upsurt', 5, 1),
		(NULL, 'Piyan', 'flow', '00:05:26', '2015-06-17 18:00:00', 'singer', 'Preslava', 1, 1),
		(NULL, 'Gladen', 'voicing', '00:04:29', '2020-06-01 18:00:00', 'composer', 'Ico Hazarta', 5, 5),
		(NULL, 'Shape of you', 'flow', '00:04:24', '2014-07-17 15:00:00', 'singer', 'Ed Sheeran', 2, 8),
		(NULL, 'Nazad,mome Kalino', 'voicing', '00:03:15', '2016-01-12 18:30:00', 'singer', 'Gloria', 4, 2),
		(NULL, 'Wrecking ball', 'flow', '00:03:36', '2023-03-04 18:00:00', 'singer', 'Miley Cyrus', 3, 7),
		(NULL, 'Hurts', 'voicing', '00:03:48', '2023-01-19 18:00:00', 'singer', 'James Arthur', 7, 6),
		(NULL, 'Perfect', 'mix', '00:03:40', '2021-03-03 14:00:00', 'singer', 'Ed Sheeran', 2, 6),
        (NULL, 'Kolega', 'flow', '00:05:02', '2011-11-20 18:00:00', 'group', 'Upsurt', 5, 5),
        (NULL, 'Sladkoto zlo', 'voicing', '00:03:42', '2022-07-20 18:00:00', 'singer', 'Preslava', 1, 3)
		;
        
INSERT INTO albums
VALUES	(NULL, 'Da gori v lubov', '2019-09-09', 2, 1),
		(NULL, 'Krepost', '2021-11-06', 3, 4),
		(NULL, 'Nepravilen rap', '2019-05-18', 5, 5),
		(NULL, 'Loose change', '2005-04-13', 1, 2),
		(NULL, 'After Hours', '2020-03-20', 6, 6),
		(NULL, 'You need me', '2009-11-02', 4, 2),
		(NULL, 'Endless Summer Vacation', '2023-02-24', 7, 3),
        (NULL, 'You', '2006-05-14', 2, 7)
;
        
INSERT INTO users
VALUES	(NULL, 'composer', 'Ico Hazarta', '1985-12-19', 'bulgarian'),
		(NULL, 'singer', 'Ico Hazarta', '1985-12-19', 'bulgarian'),
		(NULL, 'composer', 'The Weekend', '1990-05-10', 'american'),
		(NULL, 'singer', 'The Weekend', '1990-05-10', 'american'),
		(NULL, 'singer', 'James Arthur', '1994-02-11', 'american'),
		(NULL, 'singer', 'Preslava', '1987-04-16', 'bulgarian'),
		(NULL, 'singer', 'Miley Cyrus', '1996-07-01', 'american'),
		(NULL, 'singer', 'Gloria', '1983-08-06', 'bulgarian'),
		(NULL, 'singer', 'Ed Sheeran', '1991-07-15', 'american'),
        (NULL, 'group', 'Upsurt', '1980-02-13', 'bulgarians')
;

INSERT INTO genres
VALUES	(NULL, 'pop-folk'),
		(NULL, 'pop'),
		(NULL, 'hip-hop'),
		(NULL, 'blues'),
		(NULL, 'folk'),
		(NULL, 'jazz'),
		(NULL, 'rock'),
		(NULL, 'funk')
        ;
        
INSERT INTO customers
VALUES	(NULL, 'Dayana', 'deycheto', '1111', 'deycheto@gmail.com'),
		(NULL, 'Denislav', 'denkata', '2222', 'd.dimitrov@gmail.com'),
		(NULL, 'Viktoriya', 'vikichka', '3333', 'viki@gmail.com'),
		(NULL, 'Emily', 'emiliyanka', '4444', 'emi@gmail.com'),
		(NULL, 'Petur', 'pepkata', '5555', 'p.milanov@gmail.com'),
		(NULL, 'Vasilena', 'vysi', '6666', 'v.dimitrova@gmail.com'),
		(NULL, 'Georgi', 'gogo', '7777', 'g.kostov@gmail.com'),
		(NULL, 'Milena', 'milenita', '8888', 'm.ivanova@gmail.com')
        ;
        
INSERT INTO orders
VALUES	(NULL, '1', '2020-04-10 15:00:00', 1),
		(NULL, '2', '2021-02-10 16:00:00', 2),
		(NULL, '3', '2020-06-11 11:0:00', 3),
		(NULL, '4', '2023-01-04 15:00:00', 4),
		(NULL, '5', '2020-04-10 15:00:00', 5),
		(NULL, '6', '2020-04-10 15:00:00', 6),
		(NULL, '7', '2020-04-10 15:00:00', 7),
		(NULL, '8', '2020-04-10 15:00:00', 8)
;

INSERT INTO rankings
VALUES	(NULL, 'Bulgarian', 1, '2019-05-06'),
		(NULL, 'Bulgarian', 2, '2019-05-06'),
		(NULL, 'Bulgarian', 3, '2019-05-06'),
		(NULL, 'Bulgarian', 4, '2019-05-06'),
		(NULL, 'Bulgarian', 5, '2019-05-06'),
		(NULL, 'Bulgarian', 6, '2019-05-06'),
		(NULL, 'Bulgarian', 7, '2019-05-06'),
		(NULL, 'Bulgarian', 8, '2019-05-06'),
		(NULL, 'Bulgarian', 9, '2019-05-06'),
		(NULL, 'Bulgarian', 10, '2019-05-06'),
		(NULL, 'American', 1, '2023-04-19'),
		(NULL, 'American', 2, '2023-04-19'),
		(NULL, 'American', 3, '2023-04-19'),
		(NULL, 'American', 4, '2023-04-19'),
		(NULL, 'American', 5, '2023-04-19')
	;
        
INSERT INTO users_songs
VALUES	(6, 1),
		(7, 2),
		(3, 3),
		(4, 3),
		(5, 4),
		(4, 5),
		(3, 5),
		(2, 6),
		(1, 6),
		(8, 7),
		(10, 8),
		(6, 9),
		(1, 10),
		(2, 10),
		(9, 11),
		(8, 12),
		(7, 13),
		(5, 14),
		(9, 15),
        (10, 16),
        (6, 17)
;

INSERT INTO songs_albums
VALUES	(1, 1),
		(1, 9),
		(1, 7),
		(2, 7),
		(2, 12),
		(3, 6),
		(3, 8),
		(3, 10),
		(4, 11),
		(4, 15),
		(5, 3),
		(5, 5),
		(6,15),
		(7, 2),
		(7, 13),
		(8, 4),
		(8, 14),
        (3, 16),
        (1, 17)
;

INSERT INTO songs_genres
VALUES	(1, 1),
		(1, 9),
		(1, 7),
        (2, 2),
        (2, 15),
        (2, 5),
        (2, 13),
        (3, 6),
        (3, 8),
        (3, 10),
        (3, 5),
        (4, 3),
        (4, 4),
        (4, 11),
        (4, 14),
        (2, 7),
        (2, 12),
        (2, 16),
        (1, 17)
;

INSERT INTO songs_ranking
VALUES	(1, 1),
		(6,2),
        (7,3),
        (8,4),
        (9, 5),
        (10, 6),
        (12, 7),
        (2, 8),
        (16, 9),
        (17, 10),
        (3, 11),
        (4, 12),
        (5, 13),
        (11, 14),
        (13, 15)
;

INSERT INTO songs_customers
VALUES	(1, 1),
		(1, 3),
        (1, 17),
		(2, 1),
        (2, 16),
		(3, 8),
		(4, 2),
		(4, 4),
        (4, 9),
		(5, 5),
		(5, 6),
		(5, 7),
		(6, 1),
		(6, 9),
		(6, 10),
		(7, 11),
		(7, 12),
		(7, 13),
		(8, 14),
		(8, 15)
;

INSERT INTO song_orders
VALUES	(1, 1),
		(1, 8),
        (2, 2),
        (2, 3),
        (2, 9),
        (3, 4),
        (3, 5),
        (3, 6),
        (4, 7),
        (4, 10),
        (5, 11),
        (5, 12),
        (6, 13),
        (6, 14),
        (7, 15),
        (7, 16),
        (8, 17)
;

INSERT INTO order_prices
VALUES	(1, 2),
		(2, 5),
        (2, 4),
        (3, 7),
        (3, 8),
        (3, 2),
        (4, 4),
        (1, 1),
        (2, 1),
        (4, 5),
        (5, 8),
        (5, 2),
        (6, 7),
        (6, 6),
        (7, 6),
        (7, 5),
        (8, 3)
	;
        
INSERT INTO users_albums
VALUES	(1, 3),
		(2, 3),
        (3, 5),
        (4, 5),
        (5, 8),
        (6, 1),
        (7, 7),
        (8, 2),
        (9, 6),
        (9, 4),
        (10, 3)
	;
    
INSERT INTO orders_albums
VALUES	(1, 1),
		(2, 2),
        (3, 3),
        (4, 4),
        (5, 5),
        (6, 6),
        (7, 7),
        (8, 8)
	;

INSERT INTO customers_albums
VALUES	(1, 1),
		(1, 5),
		(2, 1),
        (2, 8),
        (3, 2),
        (4, 2),
        (5, 3),
        (6, 4),
        (7, 6),
        (8, 7)
;

INSERT INTO genres_albums
VALUES	(1, 1),
		(1, 2),
        (3, 3),
        (2, 4),
        (3, 5),
        (2, 6),
        (2, 7),
        (2, 8)
;