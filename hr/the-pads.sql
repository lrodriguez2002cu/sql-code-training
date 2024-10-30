-- https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true

-- 1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical
-- (i.e.: enclosed in parentheses). For
-- example:
-- AnActorName (A), ADoctorName  (D), AProfessorName (P), and ASingerName  (S).

-- Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following
-- format:

-- There are a total of [occupation_count] [occupation]s.
-- where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name.
-- If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

-- Note:
-- There will be at least two entries in the table for each type of occupation.

drop table if exists OCCUPATIONS;

create table OCCUPATIONS
(
    name nvarchar(200),
    occupation nvarchar(200)
);

insert into occupations
values
    ('Samantha'	, 'Doctor'),
    ('Julia', 'Actor'),
    ('Maria'	, 'Actor'),
    ('Meera'	, 'Singer'),
    ('Ashely'	, 'Professor'),
    ('Ketty'	, 'Professor'),
    ('Christeen', 'Professor'),
    ('Jane', 'Actor'),
    ('Jenny', 'Doctor'),
    ('Priya'	, 'Singer');

-- This is the answer that should be valid as requested in the question

with
    ordered_occupations
    AS
    (
        select
            1 as num,
            rank() over (order by name) as  rank,
            CONCAT (name , '(',   SUBSTRING(occupation, 1, 1), ')') as name_occupation
        from occupations
    )
select string_agg(o.name_occupation, ', ') WITHIN group (order by o.name_occupation)
from ordered_occupations o
group by num;



select Concat('There are a total of ', count(*),' ', Lower(o.occupation), 's.')--, count(*), o.occupation
from occupations o
group by o.occupation
order by count(*)



---  This is the answer that works
with
    ordered_occupations
    AS
    (
        select
            1 as num,
            rank() over (order by name) as  rank,
            CONCAT (name , '(',   SUBSTRING(occupation, 1, 1), ')') as name_occupation
        from occupations
    )
--select string_agg(o.name_occupation, ', ') WITHIN group (order by o.name_occupation)
select o.name_occupation
from ordered_occupations o
order by rank;



select Concat('There are a total of ', count(*),' ', Lower(o.occupation), 's.')--, count(*), o.occupation
from occupations o
group by o.occupation
order by count(*)
