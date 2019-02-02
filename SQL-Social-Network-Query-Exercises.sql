-- Q1
-- Find the names of all students who are friends with someone named Gabriel. 

SELECT H1.name
FROM Highschooler H1 INNER JOIN Friend 
ON H1.ID = Friend.ID1
INNER JOIN Highschooler H2
ON H2.ID = Friend.ID2
WHERE H2.name = 'Gabriel';


-- Q2
-- For every student who likes someone 2 or more grades younger than themselves, 
-- return that student's name and grade, and the name and grade of the student they like. 

-- Generating 2 instances of Highschooler table and performing join 

SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1 INNER JOIN Likes
ON H1.ID = Likes.ID1
INNER JOIN Highschooler H2
ON H2.ID = Likes.ID2
WHERE (H1.grade - H2.grade) >= 2;

-- Q3
-- For every pair of students who both like each other, return the name and grade of both students. 
-- Include each pair only once, with the two names in alphabetical order. 

SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1, Highschooler H2, Likes L1, Likes L2
WHERE (H1.ID = L1.ID1 AND H2.ID = L1.ID2) 
AND (H2.ID = L2.ID1 AND H1.ID = L2.ID2) AND H1.name < H2.name
ORDER BY H1.name, H2.name;
