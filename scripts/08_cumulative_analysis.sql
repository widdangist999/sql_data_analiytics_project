```sql
/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate cumulative metrics over time.
    - To track running totals of sales across monthly and yearly periods.
    - To observe cumulative sales and average price trends.

SQL Functions Used:
    - Date Functions: YEAR(), DATE_FORMAT()
    - Aggregate Functions: SUM(), AVG()
    - Window Functions: SUM() OVER(), AVG() OVER()
    - Clauses: WHERE, GROUP BY, ORDER BY
===============================================================================
*/

-- 1. Calculate Monthly Sales and Running Total
-- The running total restarts at the beginning of each year.
SELECT
    order_date_month,
    total_sales,
    SUM(total_sales) OVER (
        PARTITION BY YEAR(order_date_month)
        ORDER BY order_date_month
    ) AS running_total_sales
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_date_month,
        SUM(sales_amount) AS total_sales
    FROM gold_fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY
        DATE_FORMAT(order_date, '%Y-%m-01')
) AS monthly_sales
ORDER BY
    order_date_month;


-- 2. Calculate Yearly Sales and Cumulative Metrics
-- The running totals continue across the entire period.
SELECT
    order_date_year,
    total_sales,
    average_price,
    SUM(total_sales) OVER (
        ORDER BY order_date_year
    ) AS running_total_sales,
    AVG(average_price) OVER (
        ORDER BY order_date_year
    ) AS running_average_price
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-01-01') AS order_date_year,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS average_price
    FROM gold_fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY
        DATE_FORMAT(order_date, '%Y-01-01')
) AS yearly_sales
ORDER BY
    order_date_year;
```
