-- Q1
-- Add the reviewer Roger Ebert to your database, with an rID of 209. 

INSERT INTO Reviewer values (209, 'Roger Ebert');

-- Q2
-- Insert 5-star ratings by James Cameron for all movies in the database. 
-- Leave the review date as NULL. 

insert into rating 
select rid, mid, 5, null
from reviewer, movie
where name='James Cameron';

-- Q3
-- For all movies that have an average rating of 4 stars or higher, add 25 to the release year. 
-- (Update the existing tuples; don't insert new tuples.) 

UPDATE Movie
SET year = year + 25
WHERE Movie.mID in(SELECT mID 
		FROM Rating 
        GROUP BY mID
        HAVING AVG(Stars) >= 4);