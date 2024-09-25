use ApplicationDB;
GO

-- join or inner join
select *
from football_players fp
    join national_team nt
    on fp.national_team_id = nt.id


-- left join
-- the left  table is included in full
-- even if does not satisfy the condition
select *
from football_players fp
    left join national_team nt
    on fp.national_team_id = nt.id


-- right join
-- the right table is included in full
-- even if does not satisfy the condition
select *
from football_players fp
    right join national_team nt
    on fp.national_team_id = nt.id


-- full join
-- all the data in both tables are included,
-- missing data is included as NULL 
select *
from football_players fp
    full join national_team nt
    on fp.national_team_id = nt.id


-- cross join
select *
from football_players fp
    cross join national_team nt
order by fp.first_name


-- self join
select fp1.first_name as fp1_first_name, fp2.first_name as fp2_first_name from
  football_players fp1 
join  football_players fp2 
on fp1.id <> fp2.id and fp1.national_team_id = fp2.national_team_id


-- Your task is to return all the employees that are also the company’s customers.
select e.*
from employee e
    inner join customer c
    on e.first_name = c.first_name and e.last_name = c.last_name