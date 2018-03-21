/* General subqueries. Many of these may be already implemented, so choose whatever hasn't been done yet! ~Craig Aucoin */

/* Select all the tv shows that a specified actor has appeared on */
SELECT showName FROM tvshow JOIN contract USING (showID) JOIN credit USING (creditID)
	WHERE credit.fullName = "Daniel Linda";

/* Show the Date, the season and episode, and the timeslot_id for a show */
select DATE_FORMAT(timeslot_start, "%H:%i") AS 'Air Time', CONCAT(showName, ' -- ', "S", seasonNumber, " E", episodeNumber) AS 'Show - Season - Episode', timeslot_id 
	from timeslot 
		JOIN episode on episode.episodeId = timeslot.episode_id
        JOIN tvshow USING (showid)
	WHERE timeslot_start > STR_TO_DATE('03/29/2018 00:00:00', '%m/%d/%Y %H:%i:%s') 
		and timeslot_start < STR_TO_DATE('03/29/2018 23:59:59', '%m/%d/%Y %H:%i:%s');


/* Show the date, The name of the show, the season, and the episode of each airing of an episode */
SELECT DATE_FORMAT(timeslot_start, "%H:%i") AS 'Time', showName, seasonNumber, episodeNumber, timeslot_id
	FROM timeslot
		join tvshow USING (showID)
        join episode USING (showID)
	WHERE showName = "Game of Thrones"
    ORDER BY timeslot_id, seasonNumber, episodeNumber;


/* show the tv shows that are produced by a specified production company */
SELECT showName FROM tvshow JOIN production USING (prodId)
	WHERE prodName LIKE "%Sony%";
    
/* show the production company name and the number of tv shows that they produced */
SELECT prodName, COUNT(showID) AS Num_of_shows FROM production LEFT JOIN tvshow USING (prodID)
	GROUP BY (prodID)
    ORDER BY Num_of_shows;
    
/* Show the subtitle language of each region */
SELECT regionName, subtitlesLang FROM subtitle JOIN region USING (subtitleId);


/* Show the name and the profession of each credited personel */
SELECT fullName, profession FROM profession RIGHT JOIN credit USING (creditId);


/* Show the region and the show that will be subtitled */
SELECT regionName, showName 
	FROM region 
		JOIN region_has_tvshow ON region.regionID = region_has_tvshow.region_regionID 
		JOIN tvshow ON tvshow.showID = region_has_tvshow.tvshow_showID;

/* Create View to print out the episodes with a rating of more than 8 */
CREATE VIEW best_rated_episodes AS
	SELECT CONCAT(showName, ' -- ', "S", seasonNumber, " E", episodeNumber) AS 'Show - Season - Episode', averageRating
    FROM tvshow JOIN episode USING (showid)
    WHERE averageRating >= 8;
    
/* Create View to show each shows average rating */
CREATE VIEW show_average_ratings AS
	SELECT showName, AVG(averageRating) as Average_Rating FROM tvshow JOIN episode USING (showid)
    GROUP BY showID;
    
/* View all movies */
SELECT movieName FROM movie;

/* Show the show names and the number of episodes each series has */
SELECT showName, COUNT(episodeid) FROM tvshow JOIN episode USING (showid)
	GROUP BY showid;
    
/* Show the number of shows that have subtitles in each language */
SELECT subtitlesLang, COUNT(showid) AS no_of_shows_in_language 
	FROM subtitle
		JOIN region USING (subtitleID) 
        JOIN region_has_tvshow ON region.regionId = region_has_tvshow.region_regionId
        JOIN tvshow ON region_has_tvshow.tvshow_showId = tvshow.showID
	GROUP BY subtitleID;
