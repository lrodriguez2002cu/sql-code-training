
drop table if exists album_sales

create table album_sales
(
    id int PRIMARY key not null,
    artist nvarchar(200),
    album nvarchar(200),
    copies_sold int not null
)

insert into album_sales
values
    (1, 'Eagles', 'Hotel California'	, 42000000),
    (2, 'Led Zeppelin', 'Led Zeppelin IV'	, 37000000),
    (3, 'Shania Twain', 'Come On Over'	, 40000000),
    (4, 'Fleetwood Mac', 'Rumours'	, 40000000),
    (5, 'AC/DC'	, 'Back in Black'	, 50000000),
    (6, 'Bee Gees'	, 'Saturday Night Fever'	, 40000000),
    (7, 'Michael Jackson'	, 'Thriller'	, 70000000),
    (8, 'Pink Floyd'	, 'The Dark Side of the Moon'	, 45000000),
    (9, 'Whitney Houston', 'The Bodyguard'	, 45000000),
    (10, 'Eagles', 'Their Greatest Hits (1971-1975)'	, 4400000)

-- SELECT
--     ROW_NUMBER() OVER (ORDER BY copies_sold DESC) AS rank,
--     artist,
--     album,
--     copies_sold
-- FROM album_sales;

SELECT
    ROW_NUMBER() OVER (ORDER BY copies_sold DESC) AS rank,
    artist,
    album,
    copies_sold
FROM album_sales;

SELECT
    RANK() OVER (ORDER BY copies_sold DESC) AS rank,
    artist,
    album,
    copies_sold
FROM album_sales;


SELECT
    DENSE_RANK() OVER (ORDER BY copies_sold DESC) AS rank,
    artist,
    album,
    copies_sold
FROM album_sales;


drop table if exists salary

create table salary
(
    id int PRIMARY key not null,
    first_name nvarchar(50) not null,
    last_name nvarchar(50),
    salary decimal not null,
    department nvarchar(50) not null
);

insert into salary
values
    (1, 'Tim', 'Thompson', 10524.74, 'Sales'),
    (2, 'Martina', 'Hrabal', 7895.14, 'Accounting'),
    (3, 'Susan', 'Truman', 15478.69, 'Sales'),
    (4, 'Ciro', 'Conte', 8794.41, 'Accounting'),
    (5, 'Jorge', 'De Lucia', 7489.15	, 'Sales'),
    (6, 'Carmen', 'Lopez', 10479.15, 'Accounting'),
    (7, 'Catherine', 'Molnar', 8794.89, 'Sales'),
    (8, 'Richard', 'Buchanan', 12487.69, 'Accounting'),
    (9, 'Mark', 'Wong', 9784.19, 'Sales'),
    (10, 'Silvia', 'Karelias', 9748.64, 'Accounting')


drop table if exists revenue

create table revenue
(
    id int not null,
    actual_revenue decimal,
    period nvarchar(50)
);

insert into revenue
values
    (1, 8748441.22, '2022_07'),
    (2, 10487444.59, '2022_08'),
    (3, 7481457.15, '2022_09'),
    (4, 7497441.89, '2022_10'),
    (5, 8697415.36, '2022_11'),
    (6, 12497441.56, '2022_12')


GO
drop table if exists company_organization

create table company_organization
(
    employee_id int primary key,
    first_name nvarchar(50),
    last_name nvarchar(50),
    manager_id int

)

insert into company_organization
values
    (5529, 'Jack', 'Simmons', 5125),
    (5238, 'Maria', 'Popovich', 5329),
    (5329, 'Dan', 'Jacobsson', 5125),
    (5009, 'Simone', 'Gudbois', 5329),
    (5125, 'Albert', 'Koch', NULL),
    (5500, 'Jackie', 'Carlin', 5529),
    (5118, 'Steve', 'Nicks', 5952),
    (5012, 'Bonnie', 'Presley', 5952),
    (5952, 'Harry', 'Raitt', 5529),
    (5444, 'Sean', 'Elsam', 5329)

