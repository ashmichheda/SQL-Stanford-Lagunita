-- Q1
-- Find the names of all students who are friends with someone named Gabriel. 

SELECT H1.name
FROM Highschooler H1 INNER JOIN Friend 
ON H1.ID = Friend.ID1
INNER JOIN Highschooler H2
ON H2.ID = Friend.ID2
WHERE H2.name = 'Gabriel';

