-- https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true

drop table if exists employee;

create table employee (
   employee_id int,
   name nvarchar(50),
   months int,
   salary int 
);


drop table if exists employee;

create table employee
(
    employee_id int,
    name nvarchar(50),
    months int,
    salary int
);


INSERT INTO employee
    (employee_id, name, months, salary)
VALUES
    (12228, 'Rose', 15, 1968),
    (33645, 'Angela', 1, 3443),
    (45692, 'Frank', 17, 1608),
    (56118, 'Patrick', 7, 1345),
    (59725, 'Lisa', 11, 2330),
    (74197, 'Kimberly', 16, 4372),
    (78454, 'Bonnie', 8, 1771),
    (83565, 'Michael', 6, 2017),
    (98607, 'Todd', 5, 3396),
    (99989, 'Joe', 9, 3573);


with data as (
    select max(months * salary) over () as max_sal,
    months,
    salary,
    employee_id 
  from employee 
)
select max_sal, count(*) from data
where months * salary = max_sal
group by max_sal