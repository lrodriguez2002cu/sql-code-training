
-- Julia asked her students to create some coding challenges.
--  Write a query to print the
-- hacker_id, name, and the total number of challenges created by each student.

-- Sort your results by the total number of challenges in descending order.

-- If more than one student created the same number of challenges,
--  then sort the result by hacker_id.

-- If more than one student created the same number of challenges and
-- the count is less than the maximum number of challenges created, 
-- then exclude those students from the result.

drop table if exists challenges

create table challenges
(
    challenge_id int,
    hacker_id int
);

insert into challenges
values
    (61654, 5077),
    (58302, 21283),
    (40587, 88255),
    (29477, 5077),
    (1220, 21283),
    (69514, 21283),
    (46561, 62743),
    (58077, 62743),
    (18483, 88255),
    (76766, 21283),
    (52382, 5077),
    (74467, 21283),
    (33625, 96196),
    (26053, 88255),
    (42665, 62743),
    (12859, 62743),
    (70094, 21283),
    (34599, 88255),
    (54680, 88255),
    (61881, 5077);

drop  table if exists hackers

create table hackers
(
    hacker_id int,
    name nvarchar(20)
);

select count(*)
from challenges

insert into hackers
values
    (5077, 'Rose'),
    (21283, 'Angela'),
    (62743, 'Frank'),
    (88255, 'Patrick'),
    (96196, 'Lisa');



WITH
    challenge_data
    AS
    (
        select h.hacker_id, h.name, count(c.challenge_id) as count,
            max(count(challenge_id)) over () max,
            rank() over (order by count(c.challenge_id)) rank,
            count(c.challenge_id) -lag(count (c.challenge_id)) over(order by count(c.challenge_id)) diff 
    , count (c.challenge_id) -lead(count(c.challenge_id)) over(order by count (c.challenge_id)) diff1

        from hackers h
            inner join challenges c on c.hacker_id = h.hacker_id
        group by h.hacker_id, h.name
    )
select ch.hacker_id, ch.name, ch.count
from challenge_data ch
where (diff is null or diff <> 0 or (diff = 0 and count = max))
    and (diff1 is null or diff1 <> 0 or (diff1 = 0 and count = max))
order by ch.count desc, ch.hacker_id


