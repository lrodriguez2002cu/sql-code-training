-- https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true


-- You are given three tables: Students, Friends and Packages. Students contains two
-- columns: ID and Name.
-- Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
-- Packages contains two columns:ID and Salary (offered salary in $ thousands per month).


-- Write a query to output the names of those students whose best friends got 
-- offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

drop table if exists students;
create table students (
   ID int, 
   name nvarchar(50)
);

insert into students values
(1,	'Ashley'),
(2,	'Samantha'),
(3,	'Julia'),
(4,	'Scarlet');


drop table if exists friends;
create table friends (
    ID int,
    Friend_id int
);

insert into friends values
(1, 2),
(2, 3),
(3, 4),
(4, 1);

drop table if exists packages;
create table packages (
    ID int,
    salary float
);

insert into packages values
(1, 15.20),
(2, 10.06),
(3, 11.55),
(4, 12.12);


select s.name /*, fs.name, p.salary person_salary, fp.salary friend_salary */from students s
inner join friends f on s.id = f.ID
inner join students fs on fs.id = f.Friend_id
inner join packages p on s.ID = p.id
inner join packages fp on f.Friend_id = fp.id
where fp.salary > p.salary
order by fp.salary