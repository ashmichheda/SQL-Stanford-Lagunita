-- No. of colleges applied to by each student
SELECT student.id, name, count(distinct cName)
from student, apply
where student.id = apply.id
group by student.id;

-- Above query with students who haven't applied to any college
-- make the count appear as 0. We do a union as follows

SELECT student.id, count(distinct cName)
from student, apply
where student.id = apply.id
group by student.id
UNION
select id, 0
from student
where id not in (select id from apply);

-- Colleges with fewer than 5 applications
select cName
from apply
group by cName
having count(*) < 5;

-- Colleges with fewer than 5 applicants

select cName
from apply
group by cName
having count(distinct id) < 5;

-- Find Majors whose applican't maximum GPA is below the average

select major
from apply, student
where student.id = apply.id
group by major
having max(gpa) < (select avg(gpa) from student);




