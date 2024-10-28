-- https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true

drop table if exists students;

create table students
(
    id int,
    name nvarchar(50),
    marks int
);

insert into students
values
    (1, 'Julia', 88),
    (2, 'Samantha', 68),
    (3, 'Maria', 99),
    (4, 'Scarlet', 78),
    (5, 'Ashley', 63),
    (6, 'Jane', 81);

drop table if exists grades;

create table grades
(
    grade int,
    min_mark int,
    max_mark int
);

insert into grades
values
    (1, 0, 9),
    (2, 10, 19),
    (3, 20, 29),
    (4, 30, 39),
    (5, 40, 49),
    (6, 50, 59),
    (7, 60, 69),
    (8, 70, 79),
    (9, 80, 89),
    (10, 90, 100);

 --The report must be in descending order by grade i.e. higher grades are entered first. 
 -- If there is more than one student with the same grade (8-10) assigned to them,
-- order those particular students by their name alphabetically. 
-- Finally, if the grade is lower than 8, use "NULL" as their name and list them by their
-- grades in descending order. If there is more than one student with the same grade (1-7) assigned to them,
-- order those particular students by their marks in ascending order.

select case when g.grade >= 8 then s.name else null end as name,
    g.grade as grade, s.marks as marks
from students s
    inner join grades g
    on s.marks >= g.min_mark and s.marks <= g.max_mark
order by g.grade desc, -- order by grade
case 
when g.grade >= 8 then name  --if grade over 8 then by name in case same grade is assigned
else null 
end asc, 
case 
when g.grade < 8 then marks -- if less than 8 then order by marks asc
else null
end asc
;
