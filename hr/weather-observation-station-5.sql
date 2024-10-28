-- https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true

drop table if exists station;

create table station
(
    id int,
    city nvarchar(50),
    state nvarchar(2)
);

insert into station
    (city)
values
    ('DEF'),
    ('ABC'),
    ('PQRS'),
    ('WXY');

with
    data
    as
    (
        select city, len(city) len,
            --  max(len(city)) over() max,
            --  min(len(city)) over() min,
            rank() over(partition by len(city) order by city) rank
        from station
    )
select city, len
from data
where rank = 1
order by  len

