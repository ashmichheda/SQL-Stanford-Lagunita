-- Q1
-- It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 

DELETE FROM Highschooler
WHERE grade = 12;

-- Q2
-- If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 

DELETE FROM Likes
WHERE ID1 IN (SELECT L1.ID1 
	FROM Likes L1 INNER JOIN Friend F
	USING (ID1)
	WHERE L1.ID2 = F.ID2)
AND ID2 NOT IN(SELECT L1.ID1 
	FROM Likes L1 INNER JOIN Friend F
	USING (ID1)
	WHERE L1.ID2 = F.ID2);