```sql
/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group products and customers into meaningful segments.
    - To analyze product distribution by cost range.
    - To classify customers based on spending and purchase history.

SQL Functions Used:
    - CASE: Defines segmentation rules.
    - Aggregate Functions: COUNT(), SUM(), MIN(), MAX()
    - Date Functions: TIMESTAMPDIFF()
    - CTEs: Organize intermediate query results.
===============================================================================
*/


-- 1. Segment Products by Cost Range
-- Count the number of products in each cost segment.

WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost < 500 THEN '100-500'
            WHEN cost <= 1000 THEN '500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold_dim_products
)

SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY
    cost_range
ORDER BY
    total_products DESC;


-- 2. Segment Customers by Spending and Purchase History
/*
Customer segmentation rules:
    - VIP: Lifespan >= 12 months and total spending > 5000.
    - Regular: Lifespan >= 12 months and total spending <= 5000.
    - New: Lifespan < 12 months.
*/

WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(f.order_date) AS first_order,
        MAX(f.order_date) AS last_order,
        TIMESTAMPDIFF(
            MONTH,
            MIN(f.order_date),
            MAX(f.order_date)
        ) AS lifespan
    FROM gold_fact_sales AS f
    LEFT JOIN gold_dim_customers AS c
        ON f.customer_key = c.customer_key
    GROUP BY
        c.customer_key
),

segmented_customers AS (
    SELECT
        customer_key,
        CASE
            WHEN lifespan >= 12
                 AND total_spending > 5000
                THEN 'VIP'

            WHEN lifespan >= 12
                 AND total_spending <= 5000
                THEN 'Regular'

            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
)

SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM segmented_customers
GROUP BY
    customer_segment
ORDER BY
    total_customers DESC;
```
