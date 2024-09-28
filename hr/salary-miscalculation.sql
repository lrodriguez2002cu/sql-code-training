-- Samantha was tasked with calculating the average monthly salaries for 
-- all employees in the EMPLOYEES table, but did not realize her keyboard's  
-- key was broken until after completing the calculation. 

-- She wants your help finding the difference between her miscalculation 
-- (using salaries with any zeros removed), and the actual average salary.

-- Write a query calculating the amount of error (i.e.:  average monthly salaries), and round it up to the next integer.

drop table if exists Employees


create table Employees
(
    ID int,
    Name nvarchar(200),
    Salary int
)

truncate table Employees;

insert into Employees 
values
    (1, 'Kristeen', 1420),
    (2, 'Ashley', 2006),
    (3, 'Julia', 2210),
    (4, 'Maria', 3000);

SELECT CEILING(avg(salary)- avg(cast (replace(cast(salary as  nvarchar), '0', '') as int)))
 -- ,avg(cast(replace (cast (salary as nvarchar) , '0', '')as decimal))
from Employees



