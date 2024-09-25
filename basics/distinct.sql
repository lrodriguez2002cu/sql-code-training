select distinct loan_duration from loans

select distinct * from loans

-- We ’ll use GROUP BY and AVG() to find the
-- average salary by department:

select department, AVG(salary) as avg_salary from salaries 
group by department


select department, AVG(salary) as avg_salary
from salaries
group by department  having avg(salary) > 5000

