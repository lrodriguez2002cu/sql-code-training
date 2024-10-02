-- The task here is to  return the top three highest paid employees in each department, together
-- with their salary and department.


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
  (5444, 'Sean', 'Elsam', 5329);

-- recursive query

WITH
  subordinates
  AS
  (
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