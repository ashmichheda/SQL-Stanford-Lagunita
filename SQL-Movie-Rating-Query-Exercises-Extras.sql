-- Q1
-- Find the names of all reviewers who rated Gone with the Wind.


SELECT rev.name
FROM Reviewer rev
JOIN (SELECT distinct r.rID
FROM Rating r
WHERE r.mID = (SELECT m.mID 
From Movie m
WHERE m.title = 'Gone with the Wind')) t
ON rev.rID = t.rID;

-- Q2
-- For any rating where the reviewer is the same as the director of the movie, 
-- return the reviewer name, movie title, and number of stars. 


SELECT rev.name, m.title, rate.stars
FROM Reviewer rev, Rating rate, Movie m
WHERE rev.rID = rate.rID and m.mID = rate.mID and m.director = rev.name;

-- Q3
-- Return all reviewer names and movie names together in a single list, alphabetized. 
--(Sorting by the first name of the reviewer and first word in the title is fine; 
-- no need for special processing on last names or removing "The".) 

SELECT rev.name FROM Reviewer rev
UNION
SELECT m.title FROM Movie m
ORDER BY rev.name;

-- Q4
-- Find the titles of all movies not reviewed by Chris Jackson.

SELECT m.title
FROM Movie m
WHERE m.mID not in(SELECT distinct r.mID
FROM Rating r
WHERE r.rID = (SELECT rev.rID 
FROM Reviewer rev
WHERE rev.name = 'Chris Jackson'));

-- Q5
-- For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
-- Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. 
-- For each pair, return the names in the pair in alphabetical order. 

SELECT DISTINCT rev1.name, rev2.name
FROM Reviewer rev1, Reviewer rev2, Rating r1, Rating r2
WHERE r1.rID = rev1.rID
AND r2.rID = rev2.rID
AND r1.mID = r2.mID
AND rev1.name < rev2.name;

-- Q6
-- For each rating that is the lowest (fewest stars) currently in the database, 
-- return the reviewer name, movie title, and number of stars. 

SELECT r.name, 
       m.title,
       t.stars
  FROM (SELECT *
          FROM rating 
         WHERE stars = (SELECT MIN(stars) FROM rating)) t, Movie m, Reviewer r
  WHERE r.rID = t.rID and m.mID = t.mID;
  
-- Q7
-- List movie titles and average ratings, from highest-rated to lowest-rated. 
-- If two or more movies have the same average rating, 
-- list them in alphabetical order.   

SELECT m.title, AVG(r.stars) 
FROM Movie m, Rating r
WHERE m.mID = r.mID
GROUP BY m.title
ORDER BY 2 DESC, 1;

-- Q8
-- Find the names of all reviewers who have contributed three or more ratings. 
-- (As an extra challenge, try writing the query without HAVING or without COUNT.) 

SELECT rev.name
FROM (SELECT rID 
		FROM Rating
		GROUP BY rID
		HAVING COUNT(*) >= 3) t, Reviewer rev
WHERE rev.rID = t.rID;               
               
               
               
               
