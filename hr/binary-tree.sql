-- https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true

drop table if exists BST;

create table BST
(
    N int,
    P int
);

insert into BST
values
    (1, 2),
    (3, 2),
    (6, 8),
    (9, 8),
    (2, 5),
    (8, 5),
    (5, null);


select b.N, b.P/*, Count(b1.N) as child*/,
    CASE
    WHEN b.P IS NULL THEN 'Root'
    WHEN Count(b1.N) > 0 THEN 'Inner'
    WHEN Count(b1.N) = 0 THEN 'Leaf' 
    END
from bst b
    left outer join bst b1 on b1.P = b.N
group by b.N, b.P;
  