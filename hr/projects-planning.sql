-- https://www.hackerrank.com/challenges/sql-projects/problem?isFullScreen=true

-- You are given a table, Projects, containing three columns:
-- Task_ID, Start_Date and End_Date. 
-- It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day 
-- for each row in the table.


drop table if exists projects;

create table projects (
    Task_ID int,
    Start_Date datetime2,
    End_Date datetime2
);

insert into projects values 
(1,	'2015-10-01',	'2015-10-02'),
(2,	'2015-10-02',	'2015-10-03'),
(3,	'2015-10-03',	'2015-10-04'),
(4,	'2015-10-13',	'2015-10-14'),
(5,	'2015-10-14',	'2015-10-15'),
(6,	'2015-10-28',	'2015-10-29'),
(7,	'2015-10-30',	'2015-10-31');

-- Write a query to output the start and end dates of projects listed by 
-- the number of days it took to complete the project in ascending order.
-- If there is more than one project that have the same number of completion days,
-- then order by the start date of the project.

with projects_info as (
   select p.Task_ID, 
   --calculate the difference of end dates to use it as a marker
   DATEDIFF(day,p.End_Date, LAG(p.End_Date) OVER (ORDER BY p.End_Date)) AS diffs,
   p.Start_Date,
   p.End_Date 
   from projects p 
),
projects_tasks as (
    select p1.*, 
    --search the date diff if the next chunck and use it as a project number includinf the base date
    isNull((select top 1 concat(cast(pi.End_Date as date), pi.diffs) 
     from projects_info as pi 
     where pi.End_Date > p1.End_Date and pi.diffs <> -1 and pi.diffs is not null),1)  as proj_num
     from projects_info p1 
)
--select * from projects_tasks 
select cast (min(pt.Start_Date) as date), cast(max(pt.End_Date)  as date) from projects_tasks pt
group by pt.proj_num
order by datediff (day, min(pt.Start_Date), max(pt.End_Date)) asc, min(pt.Start_Date)
