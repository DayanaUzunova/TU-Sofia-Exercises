#1
SELECT * FROM song
WHERE song.arrangement = 'flow';

#2
#GROUP BY
#Заявка за намиране на средната цена на песните на всяка лейбъл компания
SELECT labels.name, AVG(prices.price) AS average_price
FROM songs_purchase.song
JOIN songs_purchase.labels ON labels.id = song.label_id
JOIN songs_purchase.prices ON prices.id = song.price_id
GROUP BY labels.id;

#3
#INNER JOIN
#имената на всички песни и съответните цени, които са продадени през поръчките на дата 2020-04-10
SELECT song.title, prices.price
FROM song_orders 
INNER JOIN orders ON song_orders.order_id = orders.id 
INNER JOIN song ON song_orders.song_id = song.id 
INNER JOIN prices ON song.price_id = prices.id
WHERE orders.date = '2020-04-10 15:00:00';

#4
#OUTER JOIN
#заглавията на всички песни и техните цени, ако дадена песен няма цена тя излиза като NULL
SELECT song.title, prices.price
FROM songs_purchase.song
LEFT OUTER JOIN songs_purchase.prices ON song.price_id = prices.id;

#5
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

#6
#JOIN + агрегатна функция
#Тази заявка ще изведе името на всеки лейбъл и броя на песните, които са издадени от този лейбъл, сортирани по име на лейбъла.
SELECT labels.name, COUNT(song.id) AS num_songs
FROM song
INNER JOIN labels ON song.label_id = labels.id
GROUP BY labels.name
LIMIT 5;

#7.1
#тригер_1
DROP TRIGGER if exists prices_update;
delimiter |
CREATE TRIGGER prices_update AFTER UPDATE ON prices
FOR EACH ROW 
BEGIN
INSERT INTO songPrices_log(operation,
old_price_id,
new_price_id
)
VALUES ('UPDATE',
OLD.price,
CASE NEW.price WHEN OLD.price THEN NULL ELSE NEW.price END,
NOW());
END;
|
Delimiter ;

UPDATE `songs_purchase`.`prices` SET `price`='150.000'  WHERE `id`='1';

Select * from prices;

#7.2
#тригер_2
#Този тригер ще бъде активиран след всяка операция за актуализиране на цена в таблицата prices. Ако новата цена е различна от старата, 
#ще се вмъкне нов ред в таблицата songPrices_log, който да отразява операцията за промяна на цената, старата цена и новата цена.
DELIMITER $$
DROP TRIGGER IF EXISTS prices_trigger $$
CREATE TRIGGER prices_trigger
AFTER UPDATE ON prices
FOR EACH ROW
BEGIN
  IF NEW.price != OLD.price THEN
    INSERT INTO songPrices_log (operation, old_price_id, new_price_id)
    VALUES ('UPDATE', OLD.price, NEW.price);
  END IF;
END $$
DELIMITER ;

UPDATE `songs_purchase`.`prices` SET `price`='180.000'  WHERE `id`='3';

Select * from prices;

#8
#Процедура за намиране на първите 10 песни в Българската класация
DELIMITER //
DROP PROCEDURE IF EXISTS get_top_songs //
CREATE PROCEDURE get_top_songs()
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE title VARCHAR(255);
DECLARE ranks INT;
DECLARE rank_cursor CURSOR FOR SELECT song.title, rankings.place FROM songs_purchase.song
INNER JOIN songs_purchase.songs_ranking ON song.id = songs_ranking.song_id
INNER JOIN songs_purchase.rankings ON songs_ranking.ranking_id = rankings.id
WHERE rankings.name = 'Bulgarian' ORDER BY rankings.date_of_ranking DESC, rankings.place ASC LIMIT 10;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN rank_cursor;
read_loop: LOOP
    FETCH rank_cursor INTO title, ranks;
    IF done THEN
        LEAVE read_loop;
    END IF;
    SELECT CONCAT(ranks, '. ', title) AS song_rank;
END LOOP;
CLOSE rank_cursor;
END //
DELIMITER ;
CALL get_top_songs();