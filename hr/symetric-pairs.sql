-- https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true

-- Two pairs
-- (X1, Y1) and
-- (X2, Y2) are said to be symmetric pairs
-- if X1 = Y2 and X2 = Y1.

-- Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
drop table if exists Functions;

create table Functions
(
    x int,
    y int
);

insert into Functions
values
    (20, 20),
    (20, 20),
    (20, 21),
    (23, 22),
    (22, 23),
    (21, 20);

with
    ranked
    as
    (
        select x, y, ROW_NUMBER()  over (order by x, y) as rank
        from Functions
    )
select x, y
from ranked r
where concat(y, '-', x) in (select concat(x, '-', y)
from ranked f
where f.rank > r.rank)  

