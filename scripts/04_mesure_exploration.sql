
/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated business metrics.
    - To distinguish sales transaction rows from unique orders.
    - To measure sales, quantity, price, products, and customers.
    - To consolidate key business metrics into a single report.

SQL Functions Used:
    - COUNT()
    - COUNT(DISTINCT)
    - SUM()
    - AVG()
===============================================================================
*/

-- 1. Calculate total sales
SELECT
    SUM(sales_amount) AS total_sales
FROM gold_fact_sales;


-- 2. Calculate total quantity sold
SELECT
    SUM(quantity) AS total_quantity
FROM gold_fact_sales;


-- 3. Calculate average selling price per sales row
SELECT
    AVG(price) AS avg_price
FROM gold_fact_sales;


-- 4. Count non-NULL order numbers and unique orders
SELECT
    COUNT(order_number) AS order_number_rows,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold_fact_sales;


-- 5. Count product records and unique product names
SELECT
    COUNT(product_name) AS product_name_rows,
    COUNT(DISTINCT product_name) AS unique_product_names
FROM gold_dim_products;


-- 6. Count customers in the customer dimension
SELECT
    COUNT(customer_key) AS total_customers
FROM gold_dim_customers;


-- 7. Count unique customers who placed an order
SELECT
    COUNT(DISTINCT customer_key) AS customers_with_orders
FROM gold_fact_sales;


-- 8. Consolidate key business metrics into a single report
SELECT
    'Total Sales' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM gold_fact_sales

UNION ALL

SELECT
    'Total Quantity',
    SUM(quantity)
FROM gold_fact_sales

UNION ALL

SELECT
    'Average Price',
    AVG(price)
FROM gold_fact_sales

UNION ALL

SELECT
    'Total Orders',
    COUNT(DISTINCT order_number)
FROM gold_fact_sales

UNION ALL

SELECT
    'Total Products',
    COUNT(DISTINCT product_name)
FROM gold_dim_products

UNION ALL

SELECT
    'Total Customers',
    COUNT(customer_key)
FROM gold_dim_customers;
