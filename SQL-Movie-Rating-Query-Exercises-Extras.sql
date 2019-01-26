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
