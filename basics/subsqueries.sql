-- We’ll use a subquery and show the total quantity by product category,
-- but only for the individual products whose quantity is above the average
-- quantity for all products.

select product_category, sum(quantity)
from products
where quantity > (select avg(quantity)
from products)
group by product_category

-- Your task is to use a correlated subquery and
-- return the salesperson’s full name, their monthly sales
-- and the periods where their sales are above their personal average.

select sp.first_name, sp.last_name, s.monthly_sales, s.period
from salesperson sp
join sales s on sp.id = s.salesperson_id
where s.monthly_sales > 
(
select avg(s1.monthly_sales) 
from sales s1 where s1.salesperson_id = sp.id
) 

