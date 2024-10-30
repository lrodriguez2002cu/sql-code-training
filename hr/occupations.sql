-- https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true

--Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
-- and displayed underneath its corresponding Occupation. 
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

--Note: 
--Print NULL when there are no more names corresponding to an occupation.

drop table if exists occupations;

create table occupations
(
    name nvarchar(200),
    occupation nvarchar(200)
);

insert into occupations
values
    ('Samantha', 'Doctor'),
    ('Julia', 'Actor'),
    ('Maria', 'Actor'),
    ('Meera', 'Singer'),
    ('Ashely', 'Professor'),
    ('Ketty', 'Professor'),
    ('Christeen', 'Professor'),
    ('Jane', 'Actor'),
    ('Jenny', 'Doctor'),
    ('Priya', 'Singer')


SELECT Doctor,
    Singer,
    Professor,
    Actor
FROM (
    SELECT distinct o.occupation, (STRING_AGG(o1.Name, ', ') within group (order by o1.name))  as others
    FROM occupations o
        inner join occupations o1
        on o1.occupation = o.occupation
    group by o.name, o.occupation 
) src
PIVOT (
    max(others)
    FOR occupation IN ([Doctor], [Singer], [Professor], [Actor])
) pvt



SELECT Doctor,
    Singer,
    Professor,
    Actor
FROM (
    select name, occupation
    from occupations o
) src
PIVOT (
    max(occupation)
    FOR occupation IN ([Doctor], [Singer], [Professor], [Actor])
) pvt

-- Step 1: Use ROW_NUMBER to rank names alphabetically within each occupation
WITH
    RankedOccupations
    AS
    (
        SELECT
            name,
            occupation,
            ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) AS row_num
        FROM OCCUPATIONS
    )
--select * from RankedOccupations 

-- Step 2: Use PIVOT to transform the rows into columns based on occupation
SELECT
    COALESCE(Doctor, NULL) AS Doctor,
    COALESCE(Professor, NULL) AS Professor,
    COALESCE(Singer, NULL) AS Singer,
    COALESCE(Actor, NULL) AS Actor
FROM RankedOccupations
PIVOT (
    MAX(name)  -- Use MAX to get the name for each row_num within each occupation
    FOR occupation IN ([Doctor], [Professor], [Singer], [Actor])
) AS PivotTable
ORDER BY row_num;

--select * from RankedOccupations
