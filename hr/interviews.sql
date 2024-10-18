-- https://www.hackerrank.com/challenges/interviews/problem?isFullScreen=true

drop table if exists contests;

create table contests
(
    contest_id int,
    hacker_id int,
    name nvarchar(50)
);

insert into contests
values
    (66406, 17973, 'Rose'),
    (66556, 79153, 'Angela'),
    (94828, 80275, 'Frank');


drop table if exists colleges;

create table colleges
(
    college_id int,
    contest_id int
);

insert into colleges
values
    (11219, 66406),
    (32473, 66556),
    (56685, 94828);


drop table if exists challenges;

create table challenges
(
    challenge_id int,
    college_id int
);

insert into challenges
values
    (18765, 11219),
    (47127, 11219),
    (60292, 32473),
    (72974, 56685);


drop table if exists view_stats

create table view_stats
(
    challenge_id int,
    total_views int,
    total_unique_views int
);


insert into view_stats
values
    (47127, 26, 19),
    (47127, 15, 14),
    (18765, 43, 10),
    (18765, 72, 13),
    (75516, 35, 17),
    (60292, 11, 10),
    (72974, 41, 15),
    (75516, 75, 11);


drop table if exists submission_stats;

create table submission_stats
(
    challenge_id int,
    total_submissions int,
    total_accepted_submissions int
);

select *
from submission_stats

insert into submission_stats
values
    (75516, 34, 12),
    (47127, 27, 10),
    (47127, 56, 18),
    (75516, 74, 12),
    (75516, 83, 8),
    (72974, 68, 24),
    (72974, 82, 14),
    (47127, 28, 11);

-- sample output 
-- 66406 17973 Rose 111 39 156 56
-- 66556 79153 Angela 0 0 11 10
-- 94828 80275 Frank 150 38 41 15

-- Samantha interviews many candidates from different colleges using
-- coding challenges and contests.
--  Write a query to print the
-- contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, 
-- and total_unique_views
-- for each contest sorted by contest_id. 
-- Exclude the contest from the result  if all four sums are 0.

-- Note:
-- A specific contest can be used to screen candidates at more than one college,
-- but each college only holds 1 screening contest.

with
    sub_st
    --submission stats
    as
    (
        select s.challenge_id,
            sum(s.total_submissions) as sum_total_submissions,
            sum(s.total_accepted_submissions) as sum_total_accepted_submissions
        from submission_stats s
        group by challenge_id
    ),
    view_st
    --view stats
    as
    (
        select v.challenge_id,
            sum(v.total_views) as sum_total_views,
            sum(v.total_unique_views) as sum_total_unique_views
        from view_stats v
        group by v.challenge_id
    ),
    stats -- all stats
    as
    (
        select ch.challenge_id, ch.college_id,
            sum(s.sum_total_submissions) as sum_total_submissions,
            sum(s.sum_total_accepted_submissions) as sum_total_accepted_submissions,
            sum(v.sum_total_views) as sum_total_views,
            sum(v.sum_total_unique_views) as sum_total_unique_views
        from challenges ch
            left join view_st v on v.challenge_id = ch.challenge_id
            left join sub_st as s on s.challenge_id = ch.challenge_id
        group by ch.challenge_id , ch.college_id
    )
select c.contest_id, hacker_id, name,
    sum (ISNULL(s.sum_total_submissions, 0)) as sum_total_submissions,
    sum (ISNULL(s.sum_total_accepted_submissions, 0)) as sum_total_accepted_submissions,
    sum (ISNULL(s.sum_total_views, 0)) as sum_total_views,
    sum (ISNULL(s.sum_total_unique_views, 0)) as sum_total_unique_views
from stats s
    inner join colleges col on s.college_id = col.college_id
    inner join contests c on c.contest_id = col.contest_id
group by c.contest_id, hacker_id, name
 having 
 (   
     sum(ISNULL(s.sum_total_submissions, 0)) + 
     sum(ISNULL(s.sum_total_accepted_submissions, 0)) +
     sum(ISNULL(s.sum_total_views, 0)) +
     sum(ISNULL(s.sum_total_unique_views, 0))
 )>  0
order by contest_id