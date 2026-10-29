```sql
/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To calculate the contribution of each category to total sales.
    - To identify categories with the largest and smallest sales contributions.

SQL Functions Used:
    - Aggregate Functions: SUM()
    - Window Functions: SUM() OVER()
    - Numeric Functions: ROUND()
    - CTEs: Organize intermediate query results.
===============================================================================
*/

-- Analyze each category's contribution to overall sales.

WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold_fact_sales AS f
    LEFT JOIN gold_dim_products AS p
        ON p.product_key = f.product_key
    GROUP BY
        p.category
)

SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND(
        CAST(total_sales AS DECIMAL(18, 2))
        / NULLIF(SUM(total_sales) OVER (), 0) * 100,
        2
    ) AS percentage_of_total
FROM category_sales
ORDER BY
    total_sales DESC;
```
