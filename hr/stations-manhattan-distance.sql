
-- Consider and  to be two points on a 2D plane.

-- happens to equal the minimum value in Northern Latitude
-- (LAT_N in STATION).
--  happens to equal the minimum value in Western Longitude
-- (LONG_W in STATION).
--  happens to equal the maximum value in Northern Latitude
-- (LAT_N in STATION).
--  happens to equal the maximum value in Western Longitude
-- (LONG_W in STATION).
-- Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.


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
    FORMAT(
ABS(p1_A - p2_B) +
ABS(p1_C - p2_D) , 'N4')  AS ManhattanDistance
from (
select min(LAT_N) as P1_A, max(LAT_N) as P2_B,
        min(LONG_W) as P1_C, max (LONG_W) as P2_D
    from station 
) s


