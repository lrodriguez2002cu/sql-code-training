
use ApplicationDB;
GO
-- https://learnsql.com/blog/advanced-sql-interview-questions/?gad_source=1&gclid=CjwKCAjw6c63BhAiEiwAF0EH1EZlCSRAiVnLVb7HqSdY9L-GsysNfCCOVoSpstI3PMJIhyUvza5ejRoCw70QAvD_BwE

drop table if EXISTS football_players

create table football_players
(
    id INT primary key not null,
    first_name nvarchar(200) not null,
    last_name nvarchar (200) not null,
    national_team_id int,
    games_played int
)

insert into football_players
values
    (1, 'Gianfranco', 'Zola'	, 1	, 35),
    (2, 'Virgil', 'van Dijk'	, 2	, 53),
    (3, 'Marcus', 'Rashford'	, 3	, 51),
    (4, 'Kylian', 'Mbappé'	, 5	, 66),
    (5, 'Phil', 'Foden'	, 3	, 22),
    (6, 'Frenkie', 'de Jong', 2	, 22),
    (7, 'Mario'	, 'Balotelli'	, 1	, 36),
    (8, 'Erling' , 'Haaland'	, 6	, 23)

GO

drop table if EXISTS national_team;

create table national_team
(
    id int PRIMARY key not null,
    country nvarchar(200) not null
)
GO
insert into national_team
values
    (1, 'Italy'),
    (2, 'Netherlands'),
    (3, 'England'),
    (4, 'Croatia')

--delete football_players
--select * from football_players


GO

drop table if exists employee;

create table employee
(
    id int PRIMARY key,
    first_name nvarchar(50),
    last_name nvarchar(50)
)

GO
insert into employee
values
    (1	, 'Steve', 'Bergman'),
    (2	, 'Steve', 'Johnson'),
    (3	, 'Steve', 'King')

drop table if exists customer;
create table customer
(
    id int PRIMARY key,
    first_name nvarchar(50),
    last_name nvarchar(50)
)
GO

insert into customer
values
    (1, 'Ann', 'Coleman'),
    (2, 'Steve', 'Bergman'),
    (3, 'Steve', 'Young'),
    (4, 'Donna', 'Winter'),
    (5, 'Steve', 'King')

GO
drop table if exists mobile_user;

create table mobile_user
(
    id int PRIMARY key not null,
    first_name nvarchar(50),
    last_name NVARCHAR(50),
    mobile_data_limit int
);

insert  into mobile_user
VALUES
    (1, 'Michael', 'Watson', 5000),
    (2, 'Nicole', 'Gomez', 10000),
    (3, 'Sam', 'Stone', 8000)

GO

drop table if exists data_usage;

create table data_usage
(
    id int PRIMARY key not null,
    mobile_user_id int not null,
    data_used int,
    period nvarchar(50)
);

insert into data_usage
values
    (1, 1, 4987, '2022_10'),
    (2, 2, 6875, '2022_10'),
    (3, 3, 12547, '2022_10'),
    (4, 1, 5037, '2022_11'),
    (5, 2, 11111, '2022_11'),
    (6, 3, 4897, '2022_11')

--select * from data_usage


