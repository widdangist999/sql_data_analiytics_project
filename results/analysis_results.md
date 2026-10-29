# SQL EDA & Advanced Analytics — Results and Findings

## 1. Overview

This document presents the documented results of SQL-based Exploratory Data Analysis (EDA) performed on the Gold layer of the `DataWarehouseProject` database using MySQL 8.0.

The analysis uses the following views:

- `gold_dim_customers`
- `gold_dim_products`
- `gold_fact_sales`

The project repository contains 13 SQL scripts covering data exploration, magnitude analysis, ranking analysis, change over time analysis, cumulative analysis, performance analysis, part-to-whole analysis, data segmentation, and customer and product reports.

This document currently records the detailed results provided for the initial EDA queries. Results from the Advanced Analytics scripts should be documented separately as their actual query outputs are collected and verified.

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

**Finding:** The query returned seven distinct country values, including `n/a`.

The `n/a` value is retained as it appears in the query output. Its meaning should be verified before treating it as a valid country or a missing-value category.

### 2.2 Product Categories and Names

The query retrieves distinct combinations of `category`, `subcategory`, and `product_name` from `gold_dim_products`.

The results include product groupings such as:

- Accessories
- Bikes
- Clothing
- Components

The query also returns product names within their respective category and subcategory combinations.

**Finding:** The query displays distinct combinations of product categories, subcategories, and product names. It does not independently calculate the number of unique categories or subcategories.

## 3. Date Range Exploration

### 3.1 Sales Transaction Period

The query uses `MIN()`, `MAX()`, and `TIMESTAMPDIFF()` to determine the sales date range.

| Metric | Result |
|---|---|
| First Order Date | 2010-12-29 |
| Last Order Date | 2014-01-28 |
| Order Range (Months) | 36 |

**Finding:** The earliest recorded order date is December 29, 2010, and the latest is January 28, 2014. The month difference calculated by `TIMESTAMPDIFF(MONTH, ...)` is 36.

This value represents the difference in completed months between the two dates, rather than an inclusive count of all calendar months represented in the dataset.

### 3.2 Customer Birthdate Range

The query uses `MIN()`, `MAX()`, `TIMESTAMPDIFF()`, and `CURDATE()` to examine the recorded birthdate range and calculate ages.

| Metric | Result |
|---|---|
| Oldest Birthdate | 1916-02-10 |
| Oldest Calculated Age | 110 years |
| Youngest Birthdate | 1986-06-25 |
| Youngest Calculated Age | 40 years |

**Finding:** The earliest recorded birthdate is February 10, 1916, and the latest is June 25, 1986.

The calculated ages depend on the date when the query is executed because the calculation uses `CURDATE()`. These values should therefore be interpreted as query-time results, not permanent attributes of the dataset.

## 4. Measures Exploration

The queries calculate key metrics from the Gold layer views.

| Metric | Result |
|---|---:|
| Total Sales | 29,356,250 |
| Total Quantity Sold | 60,423 |
| Average Price | 486.0378 |
| Total Orders | 27,659 |
| Total Products | 295 |
| Total Customers | 18,484 |

### 4.1 Metric Definitions

- **Total Sales:** Sum of `sales_amount` in `gold_fact_sales`.
- **Total Quantity Sold:** Sum of `quantity` in `gold_fact_sales`.
- **Average Price:** Average of `price` in `gold_fact_sales`, according to the original query definition.
- **Total Orders:** Count of distinct `order_number` values in `gold_fact_sales`.
- **Total Products:** Count of distinct `product_name` values in `gold_dim_products`.
- **Total Customers:** Count of non-NULL `customer_key` values in `gold_dim_customers`.

### 4.2 Interpretation and Counting Notes

The reported product count is based on distinct product names, not necessarily distinct product keys. Different product records could share the same name.

The reported customer count represents non-NULL customer keys. It should not be described as a distinct customer count unless the original query explicitly uses `COUNT(DISTINCT customer_key)` or the uniqueness of the key is otherwise verified.

The average price result should be interpreted according to the aggregation used in the original SQL query. Its precise meaning depends on whether the query calculates a simple average of transaction-level prices or another price measure.

The currency unit for the sales and price metrics has not been specified in the available documentation.

## 5. Summary of EDA Findings

The completed EDA queries document the following:

- Seven distinct country values appear in the customer dimension, including `n/a`.
- The product dimension contains distinct combinations of categories, subcategories, and product names.
- The recorded sales period runs from December 29, 2010, to January 28, 2014.
- The recorded customer birthdates range from February 10, 1916, to June 25, 1986.
- Total sales are 29,356,250, and total quantity sold is 60,423.
- The reported average price is 486.0378.
- The dataset contains 27,659 distinct order numbers.
- The product metric counts 295 distinct product names.
- The customer metric counts 18,484 non-NULL customer keys.

These findings describe the outputs of the executed EDA queries. They do not, by themselves, establish the causes of business performance or indicate which products and customers perform best.

## 6. Advanced Analytics Documentation Scope

The repository also contains scripts for the following analyses:

| Script | Analysis | Results Documentation |
|---|---|---|
| `05_magnitude_analysis.sql` | Magnitude Analysis | To be documented from query outputs |
| `06_ranking_analysis.sql` | Ranking Analysis | To be documented from query outputs |
| `07_change_over_time_analysis.sql` | Change Over Time Analysis | To be documented from query outputs |
| `08_cumulative_analysis.sql` | Cumulative Analysis | To be documented from query outputs |
| `09_performance_analysis.sql` | Performance Analysis | To be documented from query outputs |
| `10_part_to_whole_analysis.sql` | Part-to-Whole Analysis | To be documented from query outputs |
| `11_data_segmentation.sql` | Data Segmentation | To be documented from query outputs |
| `12_report_customers.sql` | Customer Report | To be documented from query outputs |
| `13_report_products.sql` | Product Report | To be documented from query outputs |

The scripts have been executed in MySQL, but their detailed analytical findings are not included in the EDA results documented above. Actual outputs must be collected before numerical findings, rankings, segment distributions, or business conclusions are added to this document.

## 7. Limitations

- The analysis depends on the completeness and accuracy of the existing Gold layer views.
- The meaning of `n/a` in the country dimension has not been established.
- The total product and customer metrics use the counting definitions specified in the original queries.
- Customer ages calculated using `CURDATE()` change over time.
- Product and customer segmentation results depend on the thresholds and conditions defined in the SQL scripts.
- Historical comparisons depend on the available transaction periods.
- Sales and price values are presented in the dataset's units because the currency has not been specified.
- The documented findings describe the analyzed dataset and should not automatically be generalized to other businesses or datasets.
