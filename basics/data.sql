
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


drop table if exists loan;

create table loans(
  loan_id int primary key not null,
  loan_duration int not null
);

insert into loans values 
(100112, 60),
(100205,	60),
(100208,	48),
(100333,	120),
(100357,	48),
(100398,	120)

GO

drop table if exists salaries

create table salaries (
   id int primary key not null,
  first_name nvarchar(50) not null,
  last_name nvarchar(50),
  salary decimal not null,
  department nvarchar(50) 

);

insert into salaries VALUES
(1,	'Nicholas',	'Poirot',	4798.44,	'IT'),
(2,	'Samantha',	'Wolf',	5419.24,	'IT'),
(3,	'Stewart',	'Johnsons',	5419.24,	'IT'),
(4,	'Jackie',	'Biden',	8474.54,	'Sales'),
(5,	'Mark',	'Hamilton',	10574.84,	'Sales'),
(6,	'Mariana',	'Costa',	9747.54,	'Sales'),
(7,	'Paul',	'Stewart',	3498.12,	'Accounting'),
(8,	'Mary',	'Rutte',	4187.23,	'Accounting'),
(9,	'Thomas',	'Schwarz',	3748.55,	'Accounting')


drop table if exists contributors

create table contributors(
    id int primary key not null,
    first_name nvarchar(50),
    last_name nvarchar(50),
    start_date datetime2,	
    termination_date datetime2
)


insert into contributors values
(1,	'Valeria',	'Bogdanov',	'2022-10-11',	NULL),
(2,	'Nicholas',	'Bertolucci',	'2022-04-07',	'2022-11-11'),
(3,	'Mathilde',	'Bauman',	'2022-05-25',	'2022-10-01'),
(4,	'Trevor',	'Trucks',	'2022-01-28',	NULL),
(5,	'Maria',	'Szabo',	'2022-03-15',	NULL)


GO

 drop table if exists artist

 create table artist (
    id int primary key not null,
    artist_name nvarchar(50)
 )

insert into artist values
(1,	'Prince'),
(2,	'Jimi Hendrix'),
(3,	'Santana'),
(4,	'Otis Redding'),
(5,	'Lou Rawls')

drop table if exists song

create table song (

    id int primary key not null,
    artist_id int not null,
    song_title nvarchar(200)
)

insert into song values 
(1,	1,	'Purple Rain'),
(2,	2,	'Purple Haze'),
(3,	3,	'Europa'),
(4,	1,	'Cream'),
(5,	1,	'Bambi'),
(6,	1,	'Why You Wanna Treat Me So Bad?'),
(7,	2,	'Spanish Castle Magic'),
(8,	3,	'Taboo'),
(9,	3,	'Incident at Neshabur'),
(10,3,	'Flor D'' Luna')


