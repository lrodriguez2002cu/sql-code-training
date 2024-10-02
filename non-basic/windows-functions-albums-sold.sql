
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



