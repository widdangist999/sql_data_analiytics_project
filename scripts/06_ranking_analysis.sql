
/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank products and customers based on their performance.
    - To identify top-performing and low-performing products.
    - To identify customers based on revenue and order frequency.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), COUNT(DISTINCT)
    - Window Functions: RANK()
    - Clauses: GROUP BY, ORDER BY, LIMIT
    - Other Functions: COALESCE()
===============================================================================
*/


-- 1. Find the Top 5 Products by Revenue
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold_fact_sales AS f
LEFT JOIN gold_dim_products AS p
    ON p.product_key = f.product_key
GROUP BY
    p.product_name
ORDER BY
    total_revenue DESC
LIMIT 5;


-- 2. Rank Products by Revenue Using RANK()
-- Include all products with a ranking of 5 or better.
SELECT *
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_revenue,
        RANK() OVER (
            ORDER BY SUM(f.sales_amount) DESC
        ) AS rank_products
    FROM gold_fact_sales AS f
    LEFT JOIN gold_dim_products AS p
        ON p.product_key = f.product_key
    GROUP BY
        p.product_name
) AS ranked_products
WHERE rank_products <= 5
ORDER BY rank_products;


-- 3. Find the Bottom 5 Products by Revenue
-- Only products with sales records are included.
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold_fact_sales AS f
LEFT JOIN gold_dim_products AS p
    ON p.product_key = f.product_key
GROUP BY
    p.product_name
ORDER BY
    total_revenue ASC
LIMIT 5;


-- 4. Find the Bottom 5 Products by Revenue
-- Include products that have never been sold.
SELECT
    p.product_name,
    COALESCE(SUM(f.sales_amount), 0) AS total_revenue
FROM gold_dim_products AS p
LEFT JOIN gold_fact_sales AS f
    ON p.product_key = f.product_key
GROUP BY
    p.product_name
ORDER BY
    total_revenue ASC
LIMIT 5;


-- 5. Find the Top 10 Customers by Revenue
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold_fact_sales AS f
LEFT JOIN gold_dim_customers AS c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY
    total_revenue DESC
LIMIT 10;


-- 6. Find the 3 Customers with the Fewest Orders
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold_fact_sales AS f
LEFT JOIN gold_dim_customers AS c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY
    total_orders ASC
LIMIT 3;


-- 7. Find All Customers with the Fewest Orders Using RANK()
-- Return all customers tied at the lowest order count.
SELECT *
FROM (
    SELECT
        c.customer_key,
        c.first_name,
        c.last_name,
        COUNT(DISTINCT f.order_number) AS total_orders,
        RANK() OVER (
            ORDER BY COUNT(DISTINCT f.order_number) ASC
        ) AS rank_orders
    FROM gold_fact_sales AS f
    LEFT JOIN gold_dim_customers AS c
        ON c.customer_key = f.customer_key
    GROUP BY
        c.customer_key,
        c.first_name,
        c.last_name
) AS ranked_customers
WHERE rank_orders = 1
ORDER BY customer_key;
