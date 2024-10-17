-- https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true

drop table if exists wands;

create table wands
(
    id int not null,
    code int not null,
    coins_needed int,
    power int
);

insert into wands values
(1, 4, 3688, 8),
(2, 3, 9365, 3),
(3, 3, 7187, 10),
(4, 3, 734, 8),
(5, 1, 6020, 2),
(6, 2, 6773, 7),
(7, 3, 9873, 9),
(8, 3, 7721, 7),
(9, 1, 1647, 10),
(10, 4, 504, 5),
(11, 2, 7587, 5),
(12, 5, 9897, 10),
(13, 3, 4651, 8),
(14, 2, 5408, 1),
(15, 2, 6018, 7),
(16, 4, 7710, 5),
(17, 2, 8798, 7),
(18, 2, 3312, 3),
(19, 4, 7651, 6),
(20, 5, 5689, 3);

drop table if exists wands_property;

create table wands_property
(
    code int,
    age int,
    is_evil int
);

insert into wands_property values
(1, 45,	0),
(2,	40,	0),
(3,	4,	1),
(4,	20,	0),
(5,	17,	0);

with wands_data as (
    select w.id, wp.age, w.coins_needed, 
    w.power,
    rank() over (partition by concat(age,'-' , power) order by w.coins_needed asc) as rank
    from wands w
        inner join wands_property  wp
        on wp.code = w.code
    where wp.is_evil = 0
)
select wd.id, wd.age, wd.coins_needed, wd.power from wands_data wd 
where rank = 1
order by wd.power desc, wd.age desc



