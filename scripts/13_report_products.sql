
/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - Consolidate key product metrics and behaviors.

Highlights:
    1. Retrieve essential product information, including name, category,
       subcategory, and cost.
    2. Segment products by total revenue into High-Performer, Mid-Range,
       and Low-Performer categories.
    3. Aggregate product-level metrics:
       - Total orders
       - Total sales
       - Total quantity sold
       - Total unique customers
       - Lifespan in months
    4. Calculate key performance indicators (KPIs):
       - Recency (months since the last sale)
       - Average selling price
       - Average order revenue (AOR)
       - Average monthly revenue
===============================================================================
*/

-- =============================================================================
-- Create Report: gold_report_products
-- =============================================================================

DROP VIEW IF EXISTS gold_report_products;

CREATE VIEW gold_report_products AS

WITH base_query AS (
    /*
    ---------------------------------------------------------------------------
    1. Base Query: Retrieve core columns from sales and product data
    ---------------------------------------------------------------------------
    */
    SELECT
        f.order_number,
        f.order_date,
        f.customer_key,
        f.sales_amount,
        f.quantity,
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost
    FROM gold_fact_sales AS f
    LEFT JOIN gold_dim_products AS p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
),

product_aggregations AS (
    /*
    ---------------------------------------------------------------------------
    2. Product Aggregations: Calculate product-level metrics
    ---------------------------------------------------------------------------
    */
    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,
        TIMESTAMPDIFF(
            MONTH,
            MIN(order_date),
            MAX(order_date)
        ) AS lifespan,
        MAX(order_date) AS last_sale_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity,
        ROUND(
            AVG(
                CAST(sales_amount AS DECIMAL(18, 2))
                / NULLIF(quantity, 0)
            ),
            1
        ) AS avg_selling_price
    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost
)

 /*
 ---------------------------------------------------------------------------
 3. Final Query: Combine product metrics and calculate performance indicators
 ---------------------------------------------------------------------------
 */
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    TIMESTAMPDIFF(
        MONTH,
        last_sale_date,
        CURDATE()
    ) AS recency_in_months,
    CASE
        WHEN total_sales > 50000 THEN 'High-Performer'
        WHEN total_sales >= 10000 THEN 'Mid-Range'
        ELSE 'Low-Performer'
    END AS product_segment,
    lifespan,
    total_orders,
    total_sales,
    total_quantity,
    total_customers,
    avg_selling_price,

    -- Average Order Revenue (AOR)
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_revenue,

    -- Average Monthly Revenue
    CASE
        WHEN lifespan = 0 THEN total_sales
        ELSE total_sales / lifespan
    END AS avg_monthly_revenue

FROM product_aggregations;
