
-- Consider P1(a, c) and P2(b, d)  to be two points on a 2D plane where are (a, b) the respective minimum and maximum values of Northern Latitude
-- (LAT_N) and (c, d)  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

-- Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.


-- The STATION table is described as
-- follows:
drop table if exists station;

create table station
(
    id decimal,
    city nvarchar(21),
    state nvarchar(2),
    LAT_N decimal,
    LONG_W decimal
);


INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (4, 'Houston', 'TX', 29.7604, -95.3698);
INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (5, 'Phoenix', 'AZ', 33.4484, -112.0740);
INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (2, 'Los Angeles', 'CA', 34.0522, -118.2437);
INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (1, 'New York', 'NY', 40.7128, -74.0060);
INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (3, 'Chicago', 'IL', 41.8781, -87.6298);
INSERT INTO station
    (id, city, state, LAT_N, LONG_W)
VALUES
    (6, 'Denver', 'CO', 42.8781, -87.6298);

delete station
where 
   city =  'Denver'

truncate table station
select *
from station

select
    FORMAT
(
SQRT
(POWER
(p1_A - p2_B, 2) + POWER
(p1_C - p2_D, 2)), 'N4')  AS EuclideanDistance
from (
select min(LAT_N) as P1_A, max(LAT_N) as P2_B,
        min(LONG_W) as P1_C, max (LONG_W) as P2_D
    from station 
) s


-- A median is defined as a number separating the higher half of a data
-- set from the lower half. Query the median of the Northern Latitudes
-- (LAT_N) from STATION and round your answer to 4 decimal places.

WITH
    ranking
    AS
    (
        SELECT
            LAT_N,
            ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num,
            COUNT(*) OVER () AS total_rows
        FROM station
    )
SELECT TOP 1
    ROUND(
        CASE 
            WHEN total_rows % 2 = 1 THEN 
                (SELECT LAT_N
    FROM ranking
    WHERE row_num = (total_rows + 1) / 2)
            ELSE 
                (SELECT AVG(LAT_N)
    FROM ranking
    WHERE row_num IN (total_rows / 2, total_rows / 2 + 1))
        END, 
    4) AS median_LAT_N
FROM ranking
;



-- solution
with
    ranking
    as
    (
        select
            ROW_NUMBER() over (order by LAT_N asc) as row_num,
            COUNT(*) over () as total_rows,
            LAT_N
        from station
    )
select FORMAT(AVG(LAT_N), 'N4')
from ranking r
where
(total_rows%2 <> 0
    and (r.row_num 
    between (total_rows/2 +1) 
    and (total_rows/2 + 1)
))
    or (total_rows %2 = 0
    and (r.row_num between (total_rows/2) 
  and  (total_rows/2 +1))
)

