-- https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true
drop table if exists hackers;

create table hackers
(
    hacker_id int,
    name nvarchar(50)
);

insert into hackers
values
    (5580, 'Rose'),
    (8439, 'Angela'),
    (27205, 'Frank'),
    (52243, 'Patrick'),
    (52348, 'Lisa'),
    (57645, 'Kimberly'),
    (77726, 'Bonnie'),
    (83082, 'Michael'),
    (86870, 'Todd'),
    (90411, 'Joe');

drop table if exists difficulty;

create table difficulty
(
    difficulty_level int,
    score int
);

insert into difficulty
values
    (1, 20),
    (2, 30),
    (3, 40),
    (4, 60),
    (5, 80),
    (6, 100),
    (7, 120);

drop table if exists challenges;

create table challenges
(
    challenge_id int,
    hacker_id int,
    difficulty_level int
);

insert into challenges
values
    (4810, 77726, 4),
    (21089, 27205, 1),
    (36566, 5580, 7),
    (66730, 52243, 6),
    (71055, 52243, 2);

drop table if exists submissions;

create table submissions
(
    submission_id int,
    hacker_id int,
    challenge_id int,
    score int
);

INSERT INTO submissions
    (submission_id, hacker_id, challenge_id, score)
VALUES
    (68628, 77726, 36566, 30),
    (65300, 77726, 21089, 10),
    (40326, 52243, 36566, 77),
    (8941, 27205, 4810, 4),
    (83554, 77726, 66730, 30),
    (43353, 52243, 66730, 0),
    (55385, 52348, 71055, 20),
    (39784, 27205, 71055, 23),
    (94613, 86870, 71055, 30),
    (45788, 52348, 36566, 0),
    (93058, 86870, 36566, 30),
    (7344, 8439, 66730, 92),
    (2721, 8439, 4810, 36),
    (523, 5580, 71055, 4),
    (49105, 52348, 66730, 0),
    (55877, 57645, 66730, 80),
    (38355, 27205, 66730, 35),
    (3924, 8439, 36566, 80),
    (97397, 90411, 66730, 100),
    (84162, 83082, 4810, 40),
    (97431, 90411, 71055, 30);

-- Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to
-- print the respective hacker_id and name of hackers who achieved full scores for more than one challenge.
--  Order your output in descending order by the total number of challenges in which the hacker earned a full score.
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

select h.hacker_id,  h.name --, STRING_AGG(c.challenge_id, ',')
from hackers h
    inner join submissions s on h.hacker_id = s.hacker_id
    inner join challenges c on s.challenge_id = c.challenge_id
    inner join difficulty d on c.difficulty_level = d.difficulty_level
where s.score = d.score
group by h.hacker_id, h.name--, c.challenge_id 
having count(distinct s.challenge_id) >= 2
order by count (distinct s.challenge_id) desc, h.hacker_id asc

