#агрегатни функции
SELECT COUNT(song.id) as songCount
FROM labels
join song
on labels.id = song.label_id
where labels.name = 'Payner';

#
SELECT song.id, song.title as SongName, SUM(orders.number) as SumOfAllOrders, orders.date as Date
FROM orders
JOIN song_orders
ON orders.id = song_orders.order_id
join song
on song.id = song_orders.song_id
GROUP BY Date, song_id
having SumofAllOrders > 4;

SELECT MAX(prices.price) as MaxPriceForSong
FROM prices;

#средна стойност на песен
SELECT AVG(prices.price) AS average_price 
FROM song
JOIN prices ON song.price_id = prices.id;

#общата цена на поръчка
SELECT orders.id, SUM(prices.price) as total_price
FROM songs_purchase.orders
INNER JOIN songs_purchase.order_prices ON orders.id = order_prices.order_id
INNER JOIN songs_purchase.prices ON order_prices.price_id = prices.id
GROUP BY orders.id;

#цените на всички песни в базата
SELECT SUM(prices.price) AS total_price
FROM songs_purchase.song
JOIN songs_purchase.prices ON songs_purchase.song.price_id = songs_purchase.prices.id;

SELECT labels.name, AVG(prices.price) AS average_price
FROM songs_purchase.song
JOIN songs_purchase.labels ON labels.id = song.label_id
JOIN songs_purchase.prices ON prices.id = song.price_id
GROUP BY labels.id;

















#1
Select labels.name, labels.location
FROM labels
where location = 'Sofia';

#2
SELECT song.title, labels.name
FROM song
JOIN labels ON song.label_id = labels.id
where labels.name = 'Republic Records';

#3
Select song.title, labels.name, prices.price
FROM song
JOIN labels ON song.label_id = labels.id
JOIN prices ON song.price_id = prices.id
where price > 100;

#4
Select song.title, song.userName, labels.name
FROM song
JOIN labels ON song.label_id = labels.id
where labels.name = 'Upsurt';

#5
Select albums.name, prices.price
from albums
join prices on albums.price_id = prices.id
where albums.name like '%e';

#името на песента, името на изпълнителя, ролята му, името на издателството
Select song.title, users.name, users.user, labels.name
from song 
join labels on song.label_id = labels.id
join users_songs on song.id = users_songs.song_id
join users on users.id = users_songs.user_id
where users.user = 'composer';

#имената на песните и албумите, в които са
Select song.title, albums.name
from song
join songs_albums on song.id = songs_albums.song_id
join albums on albums.id = songs_albums.album_id
where albums.name = 'After Hours';

#името на песента, жанра
Select song.title, genres.name, albums.name, labels.name
from song
join songs_genres on song.id = songs_genres.song_id
join genres on genres.id = songs_genres.genre_id
join songs_albums on song.id = songs_albums.song_id
join albums on albums.id = songs_albums.album_id
join labels on song.label_id = labels.id
where genres.name = 'pop';

#името на песента, мястото на което е и в коя класация е
select song.title, rankings.place, rankings.name
from song
join songs_ranking on song.id = songs_ranking.song_id
join rankings on rankings.id = songs_ranking.ranking_id
where rankings.name = 'American';

#името на песента, името на купувача, цената на песента
Select song.title, customers.name, prices.price
from song
join prices on song.price_id = prices.id
join songs_customers on song.id = songs_customers.song_id
join customers on customers.id = songs_customers.customer_id
where customers.name = 'Dayana'
order by prices.price ASC;

#коя песен, колко пъти е поръчана, от кого и цената
Select song.title, orders.amount, customers.name, prices.price
from song join song_orders on song.id = song_orders.song_id
join orders on orders.id = song_orders.order_id
join songs_customers on song.id = songs_customers.song_id
join customers on customers.id = songs_customers.customer_id
join prices on song.price_id = prices.id
where price > 100;

Select song.title, prices.price
from song join prices
on song.price_id = prices.id;

#името на песента, колко пъти е поръчана и цената
Select song.title, orders.amount, prices.price
from song
join song_orders on song.id = song_orders.song_id
join orders on orders.id = song_orders.order_id
join prices on song.price_id = prices.id;

Select orders.date, orders.number, prices.price
from orders
join order_prices on orders.id = order_prices.order_id
join prices on prices.id = order_prices.price_id
where orders.number = '1';

#името на албума, какъв е изпълнителя и неговото име
Select albums.name, users.user, users.name, orders.amount
from albums 
join users_albums on albums.id = users_albums.album_id
join users on users.id = users_albums.user_id
join orders_albums on albums.id = orders_albums.album_id
join orders on orders.id = orders_albums.order_id;

#името на албума, колко пъти е поръчан, от кого
Select albums.name, orders.amount, customers.name
from albums 
join orders_albums on albums.id = orders_albums.album_id
join orders on orders.id = orders_albums.order_id
join customers_albums on albums.id = customers_albums.album_id
join customers on customers.id = customers_albums.customer_id;

#GROUP BY
#Заявка за намиране на средната цена на песните на всяка лейбъл компания
SELECT labels.name, AVG(prices.price) AS average_price
FROM songs_purchase.song
JOIN songs_purchase.labels ON labels.id = song.label_id
JOIN songs_purchase.prices ON prices.id = song.price_id
GROUP BY labels.id;

#INNER JOIN
#имената на всички песни и съответните цени, които са продадени през поръчките на дата 2020-04-10
SELECT song.title, prices.price
FROM song_orders 
INNER JOIN orders ON song_orders.order_id = orders.id 
INNER JOIN song ON song_orders.song_id = song.id 
INNER JOIN prices ON song.price_id = prices.id
WHERE orders.date = '2020-04-10 15:00:00';

#OUTER JOIN
#заглавията на всички песни и техните цени
SELECT song.title, prices.price
FROM songs_purchase.song
LEFT OUTER JOIN songs_purchase.prices ON song.price_id = prices.id;

Select song.title, labels.name
FROM song
JOIN labels on song.label_id = labels.id;

Select song.title, albums.name
from song
song
LEFT OUTER JOIN songs_albums
on song.id = songs_albums.song_id
LEFT OUTER JOIN albums on
albums.id = songs_albums.album_id;

#Вложен SELECT 
#Тази заявка ще избере името на албума, заглавието на песента, 
#датата на публикуване и дължината на песента от всички песни на албуми, 
#издадени от музикалното издателство "Payner" и дължината на песента е повече 
#от 3 минути и 30 секунди, подредени по дата на публикуване в низходящ ред.
SELECT album.name, song.title, song.release_date, song.length
FROM songs_purchase.albums AS album
INNER JOIN songs_purchase.songs_albums AS sa ON album.id = sa.album_id
INNER JOIN songs_purchase.song AS song ON sa.song_id = song.id
WHERE album.label_id = (
SELECT id
FROM songs_purchase.labels
WHERE name = 'Payner'
) AND song.length > '00:03:30'
ORDER BY song.release_date DESC;

#JOIN + агрегатна функция
SELECT customers.username, COUNT(orders.id) as total_orders
FROM customers
JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.username;

#8.1
#Тази процедура използва курсор, за да избере всички песни, които са издадени след 1 януари 2020 година, и да изведе заглавието им и цената им. 
#По-точно, курсорът извлича ID, заглавие и цена за всяка песен в таблицата songs_purchase.song, като цената се взема от таблицата songs_purchase.prices, 
#използвайки price_id на песента. Тези данни се обработват в цикъл, като за всяка песен се извежда заглавието й и цената й във формат, който обединява 
#двата стълба в едно изречение.
DROP PROCEDURE IF EXISTS songs_after_2020;
DELIMITER //
CREATE PROCEDURE songs_after_2020()
BEGIN
    DECLARE song_id INT;
    DECLARE song_title VARCHAR(255);
    DECLARE song_price DECIMAL(65,00);
    DECLARE done INT DEFAULT FALSE;
    DECLARE songs_cursor CURSOR FOR
        SELECT id, title, (SELECT price FROM songs_purchase.prices WHERE id = song.price_id) AS price
        FROM songs_purchase.song
        WHERE release_date > '2020-01-01';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN songs_cursor;
    song_loop: LOOP
        FETCH songs_cursor INTO song_id, song_title, song_price;
        IF done THEN
            LEAVE song_loop;
        END IF;
        SELECT CONCAT(song_title, ': ', song_price) AS song_price;
    END LOOP;
    CLOSE songs_cursor;
END //
DELIMITER ;
CALL songs_after_2020();

DELIMITER //
DROP VIEW IF EXISTS songs_compositors //
CREATE VIEW songs_compositors AS
Select song.title AS songName, song.length AS length, song.release_date AS dateOfRelease, users.user AS user
from song
join users_songs on song.id = users_songs.song_id
join users on users.id = users_songs.user_id;

Select * from songs_compositors;
