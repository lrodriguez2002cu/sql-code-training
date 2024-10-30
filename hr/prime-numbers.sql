-- https://www.hackerrank.com/challenges/print-prime-numbers/problem?isFullScreen=true

-- Write a query to print all prime numbers less than or equal to . Print your
-- result on a single line, and use the ampersand character as your separator (instead of a space).

WITH
    numbers
    AS
    (
        SELECT
                1 AS n
        UNION ALL
            SELECT
                n + 1
            FROM numbers
            where  n < 1000
    )
SELECT string_agg(n.n, '&') as numbers--, n1.n as div
FROM numbers n
    Left join numbers n1 on (n.n % n1.n = 0) and n1.n <>1 and n1.n <= n.n/2
where n1.n is null and n.n >1