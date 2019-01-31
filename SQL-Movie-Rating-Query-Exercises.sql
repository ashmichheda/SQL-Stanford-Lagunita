-- Q1
-- Find the titles of all movies directed by Steven Spielberg.

SELECT title 
FROM Movie
WHERE director = ‘Steven Spielberg’;

-- Q2
-- Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

SELECT distinct year
FROM Movie, Rating
WHERE Movie.mID = Rating.mID and (stars = 4 or stars = 5)
ORDER BY year;

-- Q3
-- Find the titles of all movies that have no ratings.

SELECT title
FROM Movie
WHERE mID not in (SELECT mID FROM Rating);


-- Q4
-- Some reviewers didn't provide a date with their rating. 
-- Find the names of all reviewers who have ratings with a NULL value for the date.

SELECT name
FROM Reviewer, Rating
WHERE Reviewer.rID = Rating.rID and ratingDate is NULL;


-- Q5
-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
-- Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

SELECT name, title, stars, ratingDate
FROM Movie, Reviewer, Rating
WHERE Movie.mID = Rating.mID and Reviewer.rID = Rating.rID
ORDER BY name, title, stars;


-- Q6
-- For all cases where the same reviewer rated the same movie twice 
-- and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

SELECT name, title
FROM Movie
INNER JOIN Rating R1 USING(mId)
INNER JOIN Rating R2 USING(rId)
INNER JOIN Reviewer USING(rId)
WHERE R1.mId = R2.mId AND R1.ratingDate < R2.ratingDate AND R1.stars < R2.stars;


-- Q7
-- For each movie that has at least one rating, find the highest number of stars that movie received. 
-- Return the movie title and number of stars. Sort by movie title.

SELECT title, MAX(stars)
FROM Movie, Rating
WHERE Movie.mID = Rating.mID and stars >=1
GROUP BY Movie.mID
ORDER BY title;


-- Q8
-- For each movie, return the title and the 'rating spread', that is, the difference between highest 
-- and lowest ratings given to that movie. 
-- Sort by rating spread from highest to lowest, then by movie title.

SELECT title, (MAX(stars) - MIN(stars)) AS rating_spread
FROM Movie, Rating
WHERE Movie.mID = Rating.mID
GROUP BY Movie.mID
ORDER BY rating_spread DESC, title;


-- Q9
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
-- (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. 
-- Don't just calculate the overall average rating before and after 1980.)

SELECT AVG(Before1980.avg) - AVG(After1980.avg)
FROM (
  SELECT AVG(stars) AS avg
  FROM Movie
  INNER JOIN Rating USING(mId)
  WHERE year < 1980
  GROUP BY mId
) AS Before1980, (
  SELECT AVG(stars) AS avg
  FROM Movie
  INNER JOIN Rating USING(mId)
  WHERE year > 1980
  GROUP BY mId
) AS After1980;

