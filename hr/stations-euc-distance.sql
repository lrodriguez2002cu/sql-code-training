
-- Consider P1(a, c) and P2(b, d)  to be two points on a 2D plane where are (a, b) the respective minimum and maximum values of Northern Latitude
-- (LAT_N) and (c, d)  are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

-- Query the Euclidean Distance between points  and  and format your answer to display  decimal digits.


-- The STATION table is described as
-- follows:
drop table if exists station;

create table station (
   id decimal,
   city nvarchar(21),
   state nvarchar(2),
   LAT_N  decimal,
   LONG_W decimal
);


INSERT INTO station (id, city, state, LAT_N, LONG_W) VALUES (1, 'New York', 'NY', 40.7128, -74.0060);
INSERT INTO station (id, city, state, LAT_N, LONG_W) VALUES (2, 'Los Angeles', 'CA', 34.0522, -118.2437);
INSERT INTO station (id, city, state, LAT_N, LONG_W) VALUES (3, 'Chicago', 'IL', 41.8781, -87.6298);
INSERT INTO station (id, city, state, LAT_N, LONG_W) VALUES (4, 'Houston', 'TX', 29.7604, -95.3698);
INSERT INTO station (id, city, state, LAT_N, LONG_W) VALUES (5, 'Phoenix', 'AZ', 33.4484, -112.0740);


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

