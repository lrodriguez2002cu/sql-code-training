-- https://www.hackerrank.com/challenges/draw-the-triangle-1/problem?isFullScreen=true

-- P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P
-- (5):
-- * * * * * 
-- * * * * 
-- * * * 
-- * * 
-- *

with numbers as (
    SELECT
        20 AS n
    UNION ALL
        SELECT
        n - 1
    FROM numbers
    where  n > 0
)
-- note the space between *
select REPLICATE(' *', n)  from numbers
order by n asc;