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
from revenue;

select period, actual_revenue,
    actual_revenue - LAG(actual_revenue) over (order by period asc) as delta
from revenue;

