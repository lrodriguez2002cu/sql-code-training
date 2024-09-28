drop table if exists city

create table city (
    ID	int,
    NAME NVARCHAR (17),
    COUNTRYCODE	NVARCHAR (3),
    DISTRICT	NVARCHAR (20),
    POPULATION	 int
)

insert into city (ID, NAME, COUNTRYCODE, DISTRICT, POPULATION) 
values
 (1, 'New York', 'USA', 'New York', 8008278),
 (2, 'Los Angeles', 'USA', 'California', 3694820),
 (3, 'Chicago', 'USA', 'Illinois', 2896016),
 (4, 'Houston', 'USA', 'Texas', 1953631),
 (5, 'Phoenix', 'USA', 'Arizona', 1321045)

select max(POPULATION) - min(POPULATION) from city
-- create some sample data for the previous table


