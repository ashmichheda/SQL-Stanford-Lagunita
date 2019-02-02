-- Q1
-- For every situation where student A likes student B, 
-- but student B likes a different student C, return the names and grades of A, B, and C. 

SELECT H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
FROM Highschooler H1, Highschooler H2, Highschooler H3, Likes l1, Likes L2
WHERE (H1.ID = L1.ID1 AND H2.ID = L1.ID2) AND (H2.ID = L2.ID1 AND H3.ID = L2.ID2 AND H3.ID <> H1.ID);