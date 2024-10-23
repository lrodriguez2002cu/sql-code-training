-- https://www.hackerrank.com/challenges/salary-of-employees/problem

drop table if exists employee;

create table employee
(
    employee_id int,
    name NVARCHAR(50),
    months int,
    salary int
);

insert into employee values
(2228, 'Rose', 15, 1968),
(33645, 'Angela', 1, 3443),
(45692, 'Frank', 17, 1608),
(56118, 'Patrick', 7, 1345),
(59725, 'Lisa', 11, 2330),
(74197, 'Kimberly', 16, 4372),
(78454, 'Bonnie', 8, 1771),
(83565, 'Michael', 6, 2017),
(98607, 'Todd', 5, 3396),
(99989, 'Joe', 9, 3573);


-- Write a query
-- that prints a list of employee names
-- (i.e.: the name attribute) for employees in Employee having a salary greater than  2000 per month who have been employees for less than  months.
--  Sort your result by ascending employee_id.

select name from employee where salary > 2000 and months < 10