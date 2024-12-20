-- https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true

drop table if exists hackers;

create table hackers (
    hacker_id int,
    name nvarchar(50)
);


INSERT INTO hackers
    (hacker_id, name)
VALUES
    (4071, 'Rose'),
    (4806, 'Angela'),
    (26071, 'Frank'),
    (49438, 'Patrick'),
    (74842, 'Lisa'),
    (80305, 'Kimberly'),
    (84072, 'Bonnie'),
    (87868, 'Michael'),
    (92118, 'Todd'),
    (95895, 'Joe');


drop table if exists submissions;

create table submissions
(
    submission_id int,
    hacker_id int,
    challenge_id int,
    score int
);


insert into submissions
    (submission_id, hacker_id, challenge_id, score)
values
    (67194, 74842, 63132, 76),
    (64479, 74842, 19797, 98),
    (40742, 26071, 49593, 20),
    (17513, 4806, 49593, 32),
    (69846, 80305, 19797, 19),
    (41002, 26071, 89343, 36),
    (52826, 49438, 49593, 9),
    (31093, 26071, 19797, 2),
    (81614, 84072, 49593, 100),
    (44829, 26071, 89343, 17),
    (75147, 80305, 49593, 48),
    (14115, 4806, 49593, 76),
    (6943, 4071, 19797, 95),
    (12855, 4806, 25917, 13),
    (73343, 80305, 49593, 42),
    (84264, 84072, 63132, 0),
    (9951, 4071, 49593, 43),
    (45104, 49438, 25917, 34),
    (53795, 74842, 19797, 5),
    (26363, 26071, 19797, 29),
    (10063, 4071, 49593, 96);

-- You did such a great job helping Julia with her last coding 
-- contest challenge that she wants you to work on this one, too!

-- The total score of a hacker is the sum of their maximum scores for all 
-- of the challenges. Write a query to print the hacker_id, name, and total score 
-- of the hackers ordered by the descending score. 
-- If more than one hacker achieved the same total score, 
-- then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 
-- from your result.

with data as (
select distinct h.hacker_id, h.name, max(s.score) over (partition by h.hacker_id, challenge_id) as max,
    challenge_id
from submissions s
    inner join hackers h on s.hacker_id = h.hacker_id
--group by h.hacker_id, h.name
)
select hacker_id, name, sum(max) as total_score from data
group by hacker_id , name
having sum(max) > 0
order by  sum(max) desc, hacker_id asc