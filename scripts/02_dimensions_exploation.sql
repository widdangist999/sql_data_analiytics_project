
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
    - To identify unique countries in the customer dimension.
    - To explore unique combinations of product categories, subcategories,
      and product names.

SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT
    country
FROM gold_dim_customers
ORDER BY country;


-- Retrieve unique combinations of categories, subcategories, and products
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold_dim_products
ORDER BY category, subcategory, product_name;
