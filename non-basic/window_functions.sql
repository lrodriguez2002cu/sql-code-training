-- The task here is to  return the top three highest paid employees in each department, together
-- with their salary and department.

WITH
    ranking
    AS
    (
        SELECT
            first_name,
            last_name,
            salary,
            department,
            DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
        FROM salary
    )

SELECT *
FROM ranking
WHERE salary_rank <= 3
ORDER BY department, salary_rank;


-- select * from salary order by department

select *
from revenue

select period, actual_revenue,
    actual_revenue - LAG(actual_revenue) over (order by period asc) as delta
from revenue 



-- recursive query

WITH  subordinates AS (
    SELECT
  employee_id,
      first_name,
      last_name,
      manager_id,
      0 AS level
    FROM company_organization
    WHERE employee_id= 5529
 
    UNION ALL
 
    SELECT
      co.employee_id,
      co.first_name,
      co.last_name,
      co.manager_id,
      level + 1
    FROM company_organization co
JOIN subordinates s
ON co.manager_id = s.employee_id
)
 
SELECT
  s.employee_id,
  s.first_name AS employee_first_name,
  s.last_name AS employee_last_name,
  co.employee_id AS direct_manager_id,
  co.first_name AS direct_manager_first_name,
  co.last_name AS direct_manager_last_name,
  s.level
FROM subordinates s
JOIN company_organization co
ON s.manager_id = co.employee_id
ORDER BY level;