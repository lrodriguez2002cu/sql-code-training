drop table if exists Company

create table Company
(
    company_code nvarchar(50),
    founder nvarchar(50)
)

insert into Company
VALUES
    ('C1', 'Monika'),
    ('C2', 'Samantha')


drop table if exists Lead_Manager
create table Lead_Manager
(
    lead_manager_code nvarchar(50),
    company_code NVARCHAR(50)
)

insert into Lead_Manager
values
    ('LM1', 'C1'),
    ('LM2', 'C2')


drop table if exists Senior_Manager
create table Senior_Manager
(
    senior_manager_code nvarchar(50),
    lead_manager_code nvarchar(50),
    company_code NVARCHAR(50)
)

insert into Senior_Manager
values
    ('SM1', 'LM1', 'C1'),
    ('SM2', 'LM1', 'C1'),
    ('SM3', 'LM2', 'C2')


drop table if exists Manager
create table Manager
(
    manager_code nvarchar (50),
    senior_manager_code nvarchar(50),
    lead_manager_code nvarchar(50),
    company_code NVARCHAR(50)
)

insert into Manager
values
    ('M1', 'SM1', 'LM1', 'C1'),
    ('M2', 'SM3', 'LM2', 'C2'),
    ('M3', 'SM3', 'LM2', 'C2')

drop table if exists Employee
create table Employee
(
    employee_code nvarchar (50),
    manager_code nvarchar (50),
    senior_manager_code nvarchar (50),
    lead_manager_code nvarchar (50),
    company_code nvarchar (50)
)

insert into Employee
values
    ('E1', 'M1', 'SM1', 'LM1', 'C1'),
    ('E2', 'M1', 'SM1', 'LM1', 'C1'),
    ('E3', 'M2', 'SM3', 'LM2', 'C2'),
    ('E4', 'M3', 'SM3', 'LM2', 'C2')


--Given the table schemas below, write a query to print the
--company_code, founder name, total number of lead managers, total number of senior managers,
-- total number of managers, and total number of employees. Order your output by ascending company_code.

select c.company_code, c.founder,
    count(distinct L.lead_manager_code) as lead_manager_count,
    count(distinct S.senior_manager_code) as senior_manager_count,
    count(distinct M.manager_code) as manager_count,
    count(distinct E.employee_code) as employee_count
from Company C
    left outer join Lead_Manager L on C.Company_Code = L.company_code
    left outer join Senior_Manager S on L.Lead_Manager_Code = S.lead_manager_code --and S.Company_Code = L.company_code
    left outer join Manager M on M.Senior_Manager_Code = S.senior_manager_code -- and M.Lead_Manager_Code = S.lead_manager_code and M.Company_Code = S.company_code
    left outer join Employee E on E.manager_code = M.Manager_Code
--and E.Senior_Manager_Code = M.senior_manager_code and E.Lead_Manager_Code = M.lead_manager_code and E.Company_Code = M.company_code
group by c.company_code, c.founder
order by c.company_code

-- Expected output 
-- C1 Monika 1 2 1 2
-- C2 Samantha 1 1 2 2