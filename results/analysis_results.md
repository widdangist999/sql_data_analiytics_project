# EDA Results and Findings

## 1. Overview

This document presents the results of Exploratory Data Analysis (EDA) performed on the Gold layer of the MySQL data warehouse.

The analysis uses the following views:

- `gold_dim_customers`
- `gold_dim_products`
- `gold_fact_sales`

The queries cover dimension exploration, date range exploration, and key business metrics.

## 2. Dimensions Exploration

### 2.1 Customer Countries

The query retrieves distinct country values from `gold_dim_customers`.

| No. | Country |
|---:|---|
| 1 | Australia |
| 2 | Canada |
| 3 | France |
| 4 | Germany |
| 5 | n/a |
| 6 | United Kingdom |
| 7 | United States |

**Result:** The query returned seven distinct country values, including `n/a`.

### 2.2 Product Categories and Names

The query retrieves distinct combinations of `category`, `subcategory`, and `product_name` from `gold_dim_products`.

The results include product groupings such as:

- Accessories
- Bikes
- Clothing
- Components

The query also returns product names within their respective category and subcategory combinations.

**Result:** The query displays distinct combinations of product categories, subcategories, and product names. It does not independently calculate the number of unique categories or subcategories.

## 3. Date Range Exploration

### 3.1 Sales Transaction Period

The query uses `MIN()`, `MAX()`, and `TIMESTAMPDIFF()` to determine the sales date range.

| Metric | Result |
|---|---|
| First Order Date | 2010-12-29 |
| Last Order Date | 2014-01-28 |
| Order Range (Months) | 36 |

**Result:** The earliest order date is December 29, 2010, and the latest order date is January 28, 2014. The `TIMESTAMPDIFF(MONTH, ...)` result is 36 months.

### 3.2 Customer Birthdate Range

The query uses `MIN()`, `MAX()`, `TIMESTAMPDIFF()`, and `CURDATE()` to examine the recorded birthdate range and calculate ages.

| Metric | Result |
|---|---|
| Oldest Birthdate | 1916-02-10 |
| Oldest Calculated Age | 110 years |
| Youngest Birthdate | 1986-06-25 |
| Youngest Calculated Age | 40 years |

**Result:** The earliest recorded birthdate is February 10, 1916, and the latest is June 25, 1986. The calculated ages depend on the date when the query is executed.

## 4. Measures Exploration

The queries calculate key metrics from the sales fact and dimension views.

| Metric | Result |
|---|---:|
| Total Sales | 29,356,250 |
| Total Quantity Sold | 60,423 |
| Average Price | 486.0378 |
| Total Orders | 27,659 |
| Total Products | 295 |
| Total Customers | 18,484 |

### Metric Definitions

- **Total Sales:** Sum of `sales_amount` in `gold_fact_sales`.
- **Total Quantity Sold:** Sum of `quantity` in `gold_fact_sales`.
- **Average Price:** Average of `price` in `gold_fact_sales`.
- **Total Orders:** Count of distinct `order_number` values in `gold_fact_sales`.
- **Total Products:** Count of distinct `product_name` values in `gold_dim_products`.
- **Total Customers:** Count of non-NULL `customer_key` values in `gold_dim_customers`.

The reported product count is based on distinct product names, while the customer count is based on non-NULL customer keys.

## 5. Summary of Results

The completed queries returned the following results:

- Seven distinct country values in the customer dimension.
- Distinct combinations of product categories, subcategories, and product names in the product dimension.
- A sales date range from December 29, 2010, to January 28, 2014.
- A recorded customer birthdate range from February 10, 1916, to June 25, 1986.
- Total sales of 29,356,250.
- Total quantity sold of 60,423.
- Average price of 486.0378.
- 27,659 distinct orders.
- 295 distinct product names.
- 18,484 non-NULL customer keys in the customer dimension.

These results document the outputs of the EDA queries executed against the Gold layer views.

