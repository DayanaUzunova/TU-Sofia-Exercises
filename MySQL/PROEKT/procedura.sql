DELIMITER $$
DROP PROCEDURE IF EXISTS get_top_songs_by_year $$
CREATE PROCEDURE get_top_songs_by_year(IN search_year INT)
BEGIN 
DECLARE done INT DEFAULT FALSE;
DECLARE title VARCHAR(255);
DECLARE ranks INT;
DECLARE rank_cursor CURSOR FOR SELECT song.title, rankings.place FROM songs_purchase.song
JOIN songs_purchase.songs_ranking ON song.id = songs_ranking.song_id
JOIN songs_purchase.rankings ON songs_ranking.ranking_id = rankings.id
WHERE rankings.name = 'Bulgarian' ORDER BY rankings.date_of_ranking DESC, rankings.place ASC LIMIT 10;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN rank_cursor;
read_loop: LOOP
    FETCH rank_cursor INTO title, ranks;
    IF done THEN
        LEAVE read_loop;
    END IF;
    SELECT CONCAT(ranks, ': ', title) AS song_rank;
END LOOP;
CLOSE rank_cursor;
END $$
DELIMITER ;
CALL get_top_songs_by_year('2020');