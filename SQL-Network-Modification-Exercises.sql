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
	
	
-- Q3
-- For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
-- Do not add duplicate friendships, friendships that already exist, or friendships with oneself. 
-- (This one is a bit challenging; congratulations if you get it right.) 

insert into friend
select f1.id1, f2.id2
from friend f1 join friend f2 on f1.id2 = f2.id1
where f1.id1 <> f2.id2
except
select * from friend;
