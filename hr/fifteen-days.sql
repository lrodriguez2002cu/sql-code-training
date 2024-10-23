-- Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the
-- end date was March 15, 2016. 

-- Write a query to print total number of unique hackers who made at least  submission each day
-- (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day.
-- If more than one such hacker has a maximum number of submissions, print the
-- lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.


drop  table if exists hackers

create table hackers
(
    hacker_id int,
    name nvarchar(20)
);

insert into hackers
values
    (15758, 'Rose'),
    (20703, 'Angela'),
    (36396, 'Frank'),
    (38289, 'Patrick'),
    (44065, 'Lisa'),
    (53473, 'Kimberly'),
    (62529, 'Bonnie'),
    (79722, 'Michael');

drop table if exists submissions;

create table submissions
(
    submission_date datetime2,
    submission_id int,
    hacker_id int,
    score int
);

truncate table submissions;

insert into submissions
values
    ('2016-03-01', 8494, 20703, 0),
    ('2016-03-01', 22403, 53473, 15),
    ('2016-03-01', 23965, 79722, 60),
    ('2016-03-01', 30173, 36396, 70),

    ('2016-03-02', 34928, 20703, 0),
    ('2016-03-02', 38740, 15758, 60),
    ('2016-03-02', 42769, 79722, 25),
    ('2016-03-02', 44364, 79722, 60),

    ('2016-03-03', 45440, 20703, 0),
    ('2016-03-03', 49050, 36396, 70),
    ('2016-03-03', 50273, 79722, 5),


    ('2016-03-04', 50344, 20703, 0),
    ('2016-03-04', 51360, 44065, 90),
    ('2016-03-04', 54404, 53473, 65),
    ('2016-03-04', 61533, 79722, 45),


    ('2016-03-05', 72852, 20703, 0),
    ('2016-03-05', 74546, 38289, 0),
    ('2016-03-05', 76487, 62529, 0),
    ('2016-03-05', 82439, 36396, 10),
    ('2016-03-05', 90006, 36396, 40),

    ('2016-03-06', 90404, 20703, 0);

-- extra data  for testing for kimberly


declare
@user int,
@submission_id int,
@addExtra bit;

if @addExtra = 1 begin

    select @user = 53473 , @submission_id = 1234;

    insert into submissions
    values
        --extra
        ('2016-03-02', @submission_id + 1, @user, 15),
        --extra
        ('2016-03-03', @submission_id + 2, @user, 15),
        --extra
        ('2016-03-04', @submission_id + 3, @user, 15),
        --extra
        ('2016-03-05', @submission_id + 4, @user, 15),
        --extra
        ('2016-03-06', @submission_id + 5, @user, 15);


    insert into submissions
    values
        --extra
        ('2016-03-02', 22403, 53473, 15
),
        --extra
        ('2016-03-03', 22403, 53473, 15),
        --extra
        ('2016-03-04', 22403, 53473, 15),
        --extra
        ('2016-03-05', 22403, 53473, 15),
        --extra
        ('2016-03-06', 22403, 53473, 15);

end;


-- Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the
-- end date was March 15, 2016. 

-- Write a query to print total number of unique hackers who made at least  submission each day
-- (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day.
-- If more than one such hacker has a maximum number of submissions, print the
-- lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.

WITH
    distinct_submission_dates
    AS
    (
        SELECT DISTINCT submission_date
        --, min(submission_date) as min_date, max(submission_date) as max_date
        FROM submissions
    ),
    min_max
    as
    (
        --for convenience
        SELECT DISTINCT
            min(submission_date) as min_date, max(submission_date) as max_date
        FROM submissions
    ),
    subs_info
    as
    (
        SELECT
            s.hacker_id as hackers_each_day_id,
            d.submission_date,
            COUNT(DISTINCT s.submission_date) AS submission_dates_before,
            -- a hacker has submitted every day if the distintcs submission dates are equal to the number of days from the beginning 
            (COUNT(DISTINCT s.submission_date) - DATEDIFF(day, (select top 1
                min_date
            from min_max), d.submission_date) - 1) AS everyday_before_if_zero,
            -- number of days since the beginning of the contest
            DATEDIFF(day, d.submission_date, (select top 1
                min_date
            from min_max)) AS diff_to_min
        FROM submissions s
            JOIN distinct_submission_dates d -- for each date
            ON s.submission_date <= d.submission_date
        -- that while the date is less than submission date
        GROUP BY hacker_id, d.submission_date
    ),
    hackers_each_day
    as
    (
        select *
        from subs_info si
        where si.everyday_before_if_zero = 0
        --makes sense to move this to the previous query as it only filters 
    ),
    ranking_by_date
    as
    (
        select cast(s.submission_date as date) as submission_date , s.hacker_id, h.name,
            rank()  over (partition by s.submission_date order by count(submission_id) desc, s.hacker_id) as rank_a_day
        from submissions s
            inner join hackers h on h.hacker_id = s.hacker_id
        group by s.submission_date, s.hacker_id, h.name
    )

select distinct r.submission_date,
    count(*) over (partition by d.submission_date) as total_unique_hackers,
    hacker_id, name
from ranking_by_date r
    inner join hackers_each_day d on d.submission_date = r.submission_date
where rank_a_day = 1
order by r.submission_date

------------------------
declare @misc bit = 0;

if @misc = 1 begin

    WITH
        distinct_submission_dates
        AS
        (
            SELECT DISTINCT submission_date
            --, min(submission_date) as min_date, max(submission_date) as max_date
            FROM submissions
        ),
        min_max
        as
        (
            -- for convenience
            SELECT DISTINCT
                min(submission_date) as min_date, max(submission_date) as max_date
            FROM submissions
        ),
        subs_info
        as
        (
            SELECT
                s.hacker_id as hackers_each_day_id,
                d.submission_date,
                --FORMAT(d.submission_date, 'd', 'en-US') as date_str ,
                COUNT(DISTINCT s.submission_date) AS submission_dates_before,
                (COUNT(DISTINCT s.submission_date) - DATEDIFF(day, (select top 1
                    min_date
                from min_max), d.submission_date) - 1) AS everyday_before_if_zero,
                DATEDIFF(day, (select top 1
                    min_date
                from min_max), d.submission_date ) AS diff_to_min
            FROM submissions s
                JOIN distinct_submission_dates d
                ON s.submission_date <= d.submission_date
            GROUP BY hacker_id, d.submission_date
        )
    select *
    from subs_info
    where everyday_before_if_zero = 0


    with
        -- hackers_each_day
        -- as
        -- (
        --     select s.hacker_id as hackers_each_day_id, count(distinct s.submission_id) as submissions_count, count(distinct submission_date) as numberof_dates,
        --         min(submission_date) as min_date, max(submission_date) as max_date
        --     from submissions s
        --         inner join hackers h on h.hacker_id = s.hacker_id
        --     group by s.hacker_id
        --     --having count (distinct submission_date) >= (select count(distinct submission_date) from submissions)
        -- ) ,
        ranking_by_date
        as
        (
            select submission_date, s.hacker_id, h.name,
                -- count(*) over() total_count, 
                count (s.hacker_id) over (partition by submission_date) as total_unique_hackers,
                rank()  over (partition by submission_date order by count(submission_id) desc, s.hacker_id) as rank_a_day
            from submissions s
                inner join hackers h on h.hacker_id = s.hacker_id
            --  inner join hackers_each_day d on h.hacker_id = d.hackers_each_day_id
            group by submission_date, s.hacker_id, h.name
        )

    select cast (submission_date as date) , total_unique_hackers, hacker_id, name
    from ranking_by_date
    where rank_a_day = 1
    order by submission_date


    --  tests 
    declare @submission_date date = '2016-03-03';


    -- submission dates for date 
    select hacker_id, count(distinct submission_date) as submission_dates_before,
        (count(distinct submission_date) - datediff(day, (select min(submission_date)), @submission_date) -1) as everyday_before_if_zero,
        datediff(day, @submission_date,(select min(submission_date))) as diff_to_min
    from submissions
    where submission_date <= @submission_date
    group by hacker_id;


-- select count (distinct submission_date)
-- from submissions
-- 2016-03-01 4 20703 Angela
-- 2016-03-02 2 79722 Michael
-- 2016-03-03 2 20703 Angela
-- 2016-03-04 2 20703 Angela
-- 2016-03-05 1 36396 Frank
-- 2016-03-06 1 20703 Angela

end --end misc section