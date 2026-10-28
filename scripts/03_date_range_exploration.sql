
/*
===============================================================================
Date Range Exploration
===============================================================================
Purpose:
    - Determine the temporal boundaries of sales transactions.
    - Calculate the historical sales data range in months.
    - Identify the oldest and youngest customers based on birthdates.

SQL Functions Used:
    - MIN()
    - MAX()
    - TIMESTAMPDIFF()
    - CURDATE()
===============================================================================
*/

-- 1. Determine the first and last order dates and the duration in months

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    TIMESTAMPDIFF(
        MONTH,
        MIN(order_date),
        MAX(order_date)
    ) AS order_range_months
FROM gold_fact_sales;


-- 2. Find the oldest and youngest customers based on birthdates

SELECT
    MIN(birthdate) AS oldest_birthdate,
    TIMESTAMPDIFF(
        YEAR,
        MIN(birthdate),
        CURDATE()
    ) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    TIMESTAMPDIFF(
        YEAR,
        MAX(birthdate),
        CURDATE()
    ) AS youngest_age
FROM gold_dim_customers;
