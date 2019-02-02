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


-- Q4
-- Find all students who do not appear in the Likes table (as a student who likes or is liked) 
-- and return their names and grades. 
-- Sort by grade, then by name within each grade.

-- Approach: Take a union from 2 instances of Likes tables to get unique ID1 and ID2 
-- Select IDs from Highschooler not from the UNION result obtained from above step.
-- sort them by first grade and then name.

SELECT name, grade
FROM Highschooler
WHERE ID not in (
  SELECT DISTINCT ID1
  FROM Likes
  UNION
  SELECT DISTINCT ID2
  FROM Likes)
ORDER BY grade, name;
  
  
  
-- Q5
-- For every situation where student A likes student B, 
-- but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), 
-- return A and B's names and grades. 

SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Highschooler H1 INNER JOIN Likes
ON H1.ID = Likes.ID1
INNER JOIN Highschooler H2
ON H2.ID = Likes.ID2
WHERE H2.ID not in (
	SELECT DISTINCT ID1
	FROM Likes);
  
  
  
-- Q6
-- Find names and grades of students who only have friends in the same grade. 
-- Return the result sorted by grade, then by name within each grade.

SELECT name, grade
FROM Highschooler H1
WHERE ID not in (
	SELECT ID1
	FROM Highschooler H2, Friend F
	WHERE H1.ID = F.ID1 AND H2.ID = F.ID2 AND H1.grade <> H2.grade)
ORDER BY grade, name;



-- Q7
-- For each student A who likes a student B where the two are not friends, 
-- find if they have a friend C in common (who can introduce them!). 
-- For all such trios, return the name and grade of A, B, and C. 

SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Highschooler H1, Highschooler H2, Highschooler H3, 
Friend F1, Friend F2, Likes
WHERE (H1.ID = Likes.ID1 and H2.ID = Likes.ID2) AND 
H2.ID NOT IN (
				SELECT ID2
				FROM Friend 
				WHERE ID1 = H1.ID 
			)
AND (H1.ID = F1.ID1 AND H3.ID = F1.ID2) AND (H2.ID = F2.ID1 AND H3.ID = F2.ID2);






















