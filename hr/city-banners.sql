
-- Data creation prompt: 
-- create tables for cities, customers, banners, the banners include detail (width and height) of banner placed by customers
-- the cities has the cost of banners by sq feet

-- Create table for banners
drop table if exists banners

-- Create table for cities
drop table if exists cities;
-- Create table for customers
drop table if exists customers

CREATE TABLE cities
(
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    cost_per_sqft DECIMAL(10, 2) NOT NULL
);

CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    contact_info VARCHAR(255)
);

CREATE TABLE banners
(
    banner_id INT PRIMARY KEY,
    customer_id INT,
    city_id INT,
    width DECIMAL(10, 2) NOT NULL,
    height DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Insert sample data into cities
INSERT INTO cities
    (city_id, city_name, cost_per_sqft)
VALUES
    (1, 'New York', 10.50),
    (2, 'Los Angeles', 8.75),
    (3, 'Chicago', 7.25);

-- Insert sample data into customers
INSERT INTO customers
    (customer_id, customer_name, contact_info)
VALUES
    (1, 'John Doe', 'john.doe@example.com'),
    (2, 'Jane Smith', 'jane.smith@example.com'),
    (3, 'Acme Corp', 'contact@acmecorp.com');

-- Insert sample data into banners
INSERT INTO banners
    (banner_id, customer_id, city_id, width, height)
VALUES
    (1, 1, 1, 5.0, 10.0),
    (2, 2, 2, 6.0, 12.0),
    (3, 3, 3, 4.0, 8.0),
    (4, 1, 1, 11.0, 10.0),
    (5, 2, 1, 6.0, 12.0),
    (6, 1, 3, 4.0, 8.0);


-- The trick remove the banner from the main query as it leads to repetitions in the city_id
-- This is achieved by pre-aggregating the banners related info, like area.

with
    city_areas_customer
    as
    (
        select cu.customer_id, cu.customer_name as customer_name,
            b.city_id, c.city_name,
            sum(b.height * b.banner_id) as area_in_city,
            max(c.cost_per_sqft) as cost_per_sqft
        from banners b
            inner join customers cu on b.customer_id = cu.customer_id
            inner join cities c on b.city_id = c.city_id
        group by cu.customer_name, cu.customer_id, b.city_id, c.city_name
    )

SELECT cu.customer_name,
    STRING_AGG(cu.city_name, ',') WITHIN GROUP (ORDER BY cu.city_name) AS city_names,
    SUM(cu.area_in_city * cu.cost_per_sqft) AS cost
FROM city_areas_customer cu
GROUP BY cu.customer_id, cu.customer_name;
