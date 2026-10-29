# SQL Data Analytics Project — Analysis Results

## Project Overview

This document summarizes the results of exploratory data analysis (EDA) and advanced analytics performed using MySQL on the data warehouse.

The analysis covers database exploration, dimensions, date ranges, key business measures, magnitude, ranking, changes over time, cumulative performance, product performance, category contributions, customer and product segmentation, and customer and product reporting.

The purpose is to understand the dataset, identify sales patterns, evaluate product and customer performance, and demonstrate practical SQL analytics techniques.

## 1. Database Exploration

### Objective
Explore the database structure and identify the tables available for analysis.

### Analysis Focus
- Identify the database and relevant tables.
- Understand the structure of the Gold layer.
- Identify the fact table and dimension tables used in analytical queries.

### Data Sources
The analysis uses the following Gold-layer tables:
- `gold_fact_sales`
- `gold_dim_products`
- `gold_dim_customers`

### Notes
The data warehouse uses a Bronze, Silver, and Gold organization. The Gold layer provides the tables used for business-oriented analysis.

## 2. Dimensions Exploration

### Objective
Explore categorical attributes and identify the distinct values available for analysis.

### Key Findings
The country dimension contains the following recorded values:
- Australia
- Canada
- France
- Germany
- United Kingdom
- United States
- `n/a`

A total of seven distinct country values were identified, including the `n/a` value.

### Interpretation
The country attribute can be used to analyze customer distribution and sales quantity across markets. The `n/a` value should be treated as a recorded missing or unavailable category rather than an actual country.

## 3. Date Range Exploration

### Objective
Identify the available date ranges and understand the temporal coverage of the dataset.

### Results

| Metric | Result |
|---|---|
| Earliest sales date | 2010-12-29 |
| Latest sales date | 2014-01-28 |
| Date span using `TIMESTAMPDIFF(MONTH)` | 36 months |
| Earliest customer birthdate | 1916-02-10 |
| Latest customer birthdate | 1986-06-25 |

### Interpretation
The sales dataset spans December 2010 through January 2014. Since 2014 contains only January sales through the 28th, comparisons between 2014 and complete calendar years should be interpreted carefully.

The birthdate range can support demographic analysis, including customer age calculations.

## 4. Measure Exploration

### Objective
Calculate the principal business measures available in the sales dataset.

### Results

| Measure | Result |
|---|---:|
| Total Sales | 29,356,250 |
| Total Quantity | 60,423 |
| Average Price | 486.0378 |
| Distinct Orders | 27,659 |
| Distinct Products | 295 |
| Non-NULL Customer Keys | 18,484 |

### Interpretation
These measures provide a baseline for subsequent analyses. Total sales and quantity describe overall sales activity, while distinct orders, products, and customer keys help characterize the scale of the dataset.

The average price is an aggregate metric and should not be interpreted as the average order value.

## 5. Magnitude Analysis

### Objective
Measure the distribution of customers, products, and sales quantities across important categories.

### 5.1 Customers by Country

| Country | Customers |
|---|---:|
| United States | 7,482 |
| Australia | 3,591 |
| United Kingdom | 1,913 |
| France | 1,810 |
| Germany | 1,780 |
| Canada | 1,571 |
| `n/a` | 337 |
| **Total** | **18,484** |

The United States has the largest recorded customer count, followed by Australia. The `n/a` category accounts for 337 records and should be considered when assessing data completeness.

### 5.2 Customers by Gender

| Gender | Customers |
|---|---:|
| Male | 9,341 |
| Female | 9,128 |
| `n/a` | 15 |
| **Total** | **18,484** |

The recorded male and female customer counts are relatively close. Fifteen records have an unavailable gender value.

### 5.3 Products by Category

| Category | Products |
|---|---:|
| Components | 127 |
| Bikes | 97 |
| Clothing | 35 |
| Accessories | 29 |
| Blank category | 7 |
| **Total** | **295** |

Components is the largest product category by product count. Seven products have a blank category value.

### 5.4 Average Cost by Category

| Category | Average Cost |
|---|---:|
| Bikes | 949.4433 |
| Components | 264.7165 |
| Blank category | 28.5714 |
| Clothing | 24.8000 |
| Accessories | 13.1724 |

Bikes have the highest average recorded cost among the categories shown. These figures describe product cost, not sales revenue or profit.

### 5.5 Revenue by Category

| Category | Total Sales |
|---|---:|
| Bikes | 28,316,272 |
| Accessories | 700,262 |
| Clothing | 339,716 |
| **Total of reported categories** | **29,356,250** |

Bikes contribute approximately 96.46% of total sales, followed by Accessories at 2.39% and Clothing at 1.16%.

Components does not appear in this particular result. Its absence should not be interpreted as proof of zero sales without further validation.

### 5.6 Quantity Sold by Country

| Country | Quantity Sold |
|---|---:|
| United States | 20,481 |
| Australia | 13,346 |
| Canada | 7,630 |
| United Kingdom | 6,910 |
| Germany | 5,626 |
| France | 5,559 |
| `n/a` | 871 |
| **Total** | **60,423** |

The United States has the highest recorded sales quantity, followed by Australia.

## 6. Ranking Analysis

### Objective
Rank products or customers based on business measures such as sales and spending.

### Analysis Focus
Ranking analysis can identify the highest-performing products and customers according to the selected metric.

### Interpretation
Ranking helps identify entities with the highest or lowest recorded values. The meaning of a ranking depends on the metric used: the highest sales value does not necessarily indicate the highest profit.

*The complete ranked output and exact ranking results are not reproduced here because they are not available in the current context.*

## 7. Change Over Time Analysis

### Objective
Analyze sales trends over time to identify changes in business performance.

### Analysis Focus
The analysis examines sales over time using date-based aggregation, including monthly or yearly comparisons.

### Interpretation
Time-based analysis helps reveal whether sales increase or decrease between periods. Comparisons should account for the incomplete 2014 observation period, which ends on January 28.

*The complete monthly and yearly output for this section is not available in the current context. Exact values are therefore not reconstructed.*

## 8. Cumulative Analysis

### Objective
Calculate running sales totals and cumulative average-price measures over time.

### SQL Techniques Used
- `SUM()`
- `AVG()`
- Window functions with `OVER()`
- `PARTITION BY`
- `ORDER BY`

### Yearly Results

| Year | Total Sales | Average Price | Cumulative Sales | Running Average of Annual Average Price |
|---|---:|---:|---:|---:|
| 2010 | 43,419 | 3,101.3571 | 43,419 | 3,101.3571 |
| 2011 | 7,075,088 | 3,192.7292 | 7,118,507 | 3,147.0432 |
| 2012 | 5,842,231 | 1,719.8207 | 12,960,738 | 2,671.3023 |
| 2013 | 16,344,878 | 309.6574 | 29,305,616 | 2,080.8911 |
| 2014 | 45,642 | 23.1685 | 29,351,258 | 1,669.3466 |

### Key Findings
1. 2013 has the highest yearly sales total among the years shown.
2. Cumulative sales increase across the recorded years.
3. The 2014 value represents only a partial year.
4. The running average price is the average of annual average prices, not a transaction-weighted average price.

### Validation Note
The cumulative yearly sales total is 29,351,258, while the overall measure previously reported is 29,356,250. The difference is 4,992 and remains unreconciled.

## 9. Performance Analysis

### Objective
Compare yearly product sales against each product's historical average and its previous available observation.

### SQL Techniques Used
- Common Table Expressions (CTEs)
- `SUM()`
- `AVG() OVER()`
- `LAG()`
- `CASE`
- Yearly aggregation

### Selected Results

| Product | Year | Sales | Change from Previous Available Year |
|---|---:|---:|---:|
| All-Purpose Bike Stand | 2012 | 159 | — |
| All-Purpose Bike Stand | 2013 | 37,683 | +37,524 |
| All-Purpose Bike Stand | 2014 | 1,749 | -35,934 |
| AWC Logo Cap | 2012 | 72 | — |
| AWC Logo Cap | 2013 | 18,891 | +18,819 |
| AWC Logo Cap | 2014 | 747 | -18,144 |
| Fender Set - Mountain | 2012 | 110 | — |
| Fender Set - Mountain | 2013 | 44,484 | +44,374 |
| Fender Set - Mountain | 2014 | 2,068 | -42,416 |
| HL Mountain Tire | 2012 | 140 | — |
| HL Mountain Tire | 2013 | 46,935 | +46,795 |
| HL Mountain Tire | 2014 | 1,785 | -45,150 |
| Mountain-200 Black-38 | 2011 | 4,098 | — |
| Mountain-200 Black-38 | 2012 | 342,921 | +338,823 |
| Mountain-200 Black-38 | 2013 | 945,540 | +602,619 |
| Road-250 Black-52 | 2011 | 4,364 | — |
| Road-250 Black-52 | 2012 | 378,269 | +373,905 |
| Road-250 Black-52 | 2013 | 351,792 | -26,477 |

### Key Findings
1. Several products experienced substantial increases in sales in 2013.
2. Some products show lower sales in the available 2014 observation.
3. Because 2014 data ends on January 28, these lower values must not be interpreted as evidence of a full-year decline.
4. `LAG()` compares with the previous available row for a product. If a year is missing, that row may not represent the immediately preceding calendar year.

### Validation Note
If the SQL labels a product with no previous observation as `No Change`, consider adjusting the `CASE` expression to handle `NULL` from `LAG()` explicitly.

## 10. Part-to-Whole Analysis

### Objective
Calculate each product category's contribution to total sales.

### SQL Techniques Used
- `SUM()`
- `SUM() OVER()`
- `ROUND()`
- `CAST()`
- `NULLIF()`
- CTEs

### Results

| Category | Total Sales | Overall Sales | Contribution |
|---|---:|---:|---:|
| Bikes | 28,316,272 | 29,356,250 | 96.46% |
| Accessories | 700,262 | 29,356,250 | 2.39% |
| Clothing | 339,716 | 29,356,250 | 1.16% |

### Key Findings
Bikes contribute the largest share of the reported sales, at 96.46%. Accessories account for 2.39%, while Clothing accounts for 1.16%.

### Interpretation
Sales are highly concentrated in the Bikes category in the reported results. This demonstrates revenue concentration, but does not by itself establish profitability or explain the causes of the difference between categories.

The displayed percentages sum to 100.01% because of rounding.

## 11. Data Segmentation Analysis

### Objective
Classify products by cost range and customers by spending and recorded purchase-history lifespan.

### 11.1 Product Segmentation by Cost

| Cost Range | Products | Share of Products |
|---|---:|---:|
| Below 100 | 110 | 37.29% |
| 100–500 | 101 | 34.24% |
| 500–1000 | 45 | 15.25% |
| Above 1000 | 39 | 13.22% |
| **Total** | **295** | **100.00%** |

The two segments below 500 contain 211 products, approximately 71.53% of the product catalog.

### 11.2 Customer Segmentation

The SQL uses these rules:
- **VIP:** Lifespan of at least 12 months and total spending above 5,000.
- **Regular:** Lifespan of at least 12 months and total spending of 5,000 or less.
- **New:** Lifespan below 12 months.

### Results

| Customer Segment | Customers | Share of Customers |
|---|---:|---:|
| New | 14,828 | 80.22% |
| Regular | 2,037 | 11.02% |
| VIP | 1,619 | 8.76% |
| **Total** | **18,484** | **100.00%** |

### Key Findings
1. Below 100 is the largest product cost segment, with 110 products.
2. The two lower cost segments contain approximately 71.53% of products.
3. New is the largest customer segment under the SQL's classification rules.
4. The VIP segment contains 1,619 customers who meet the spending and lifespan thresholds.

### Interpretation and Limitations
The customer lifespan is calculated from the first and last recorded order dates. It is not the same as time since customer registration. A customer with only one recorded order can have a lifespan of zero months and be classified as New.

The spending threshold of 5,000 is a classification rule and does not independently establish profitability or customer loyalty.

## 12. Report Customers

### Objective
Consolidate customer attributes, demographics, purchase history, spending, and customer segmentation into a customer-level report.

### Data Scope
The uploaded `customer report.csv` contains 1,000 customer records and 15 columns. It represents the top 1,000 records displayed or exported from MySQL Workbench, not the full population of 18,484 customer keys identified in the broader exploration.

The results below apply only to the exported records.

### Customer Segment Distribution

| Customer Segment | Customers | Share of Export |
|---|---:|---:|
| New | 614 | 61.40% |
| VIP | 367 | 36.70% |
| Regular | 19 | 1.90% |
| **Total** | **1,000** | **100.00%** |

### Sales by Customer Segment

| Customer Segment | Total Sales | Total Orders | Total Quantity |
|---|---:|---:|---:|
| VIP | 2,609,992 | 1,009 | 2,194 |
| New | 401,382 | 1,914 | 4,140 |
| Regular | 90,388 | 52 | 102 |
| **Total** | **3,101,762** | **2,975** | **6,436** |

### Age Group Distribution

| Age Group | Customers | Share of Export |
|---|---:|---:|
| 40–49 | 325 | 32.50% |
| 50 and above | 667 | 66.70% |
| Missing age group | 8 | 0.80% |
| **Total** | **1,000** | **100.00%** |

### Key Findings
1. New is the largest segment by customer count in the exported subset.
2. VIP customers contribute approximately 84.14% of sales in the exported report.
3. New customers account for the largest number of orders and total quantity in this subset.
4. Eight records have missing age-group values.

### Limitations
These figures describe the 1,000 exported records, not the entire customer population. The segment distribution and sales contribution should not be generalized to all customers without running an appropriate full-dataset aggregation.

## 13. Report Products

### Objective
Consolidate product attributes, sales performance, customer reach, and product segmentation into a product-level report.

### Data Scope
The uploaded `poduct report.csv` contains 130 product records and 16 columns. The earlier product-dimension exploration identified 295 products. The reason for the difference has not been established from the available export alone.

### Product Segment Distribution

| Product Segment | Products | Share of Export |
|---|---:|---:|
| High-Performer | 66 | 50.77% |
| Mid-Range | 58 | 44.62% |
| Low-Performer | 6 | 4.62% |
| **Total** | **130** | **100.01%** |

### Sales by Product Segment

| Product Segment | Total Sales | Total Orders | Total Quantity |
|---|---:|---:|---:|
| High-Performer | 27,643,724 | 20,321 | 20,322 |
| Mid-Range | 1,671,837 | 31,531 | 31,554 |
| Low-Performer | 35,697 | 8,527 | 8,528 |
| **Total** | **29,351,258** | **60,379** | **60,404** |

### Top 5 Products by Total Sales

| Product | Category | Total Sales |
|---|---|---:|
| Mountain-200 Black-46 | Bikes | 1,373,454 |
| Mountain-200 Black-42 | Bikes | 1,363,128 |
| Mountain-200 Silver-38 | Bikes | 1,339,394 |
| Mountain-200 Silver-46 | Bikes | 1,298,709 |
| Mountain-200 Black-38 | Bikes | 1,292,559 |

### Key Findings
1. High-Performer products account for approximately 94.18% of sales in the exported report.
2. Mid-Range products contribute 1,671,837 in sales.
3. Low-Performer products contribute 35,697 in sales, approximately 0.12% of the report total.
4. The top five products by total sales are all Mountain-200 variants in the Bikes category.

### Limitations and Validation
The report's total sales are 29,351,258, which is 4,992 lower than the previously calculated overall sales of 29,356,250. Its total quantity is 60,404, which is 19 lower than the previously calculated overall quantity of 60,423.

These differences remain unreconciled. The report query, joins, filters, aggregation level, and export settings should be checked before the report totals are treated as consistent with the full dataset.

The 130 product records in the export should not be assumed to represent the full 295-product dimension.

---

## Overall Conclusion

The analyses show that sales are heavily concentrated in the Bikes category, which contributes 96.46% of the reported category sales. The United States has the highest recorded customer count and sales quantity among the listed countries.

Product segmentation shows that most products fall below a recorded cost of 500, while customer segmentation classifies most customers as New based on the observed purchase-history lifespan and the SQL rules.

The customer and product reports provide more detailed views of customer spending and product performance. However, the customer report contains only 1,000 exported records and the product report contains 130 records. These subsets should not be treated as full-dataset summaries.

Before finalizing the project, reconcile the differences between the overall sales and quantity metrics and the corresponding cumulative and product-report totals. Also verify the complete outputs for Ranking Analysis and Change Over Time Analysis so their exact findings can be documented accurately.
