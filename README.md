# SQL Exploratory Data Analysis (EDA)

## Overview

This project focuses on performing Exploratory Data Analysis (EDA) using MySQL 8.0. The analysis examines data stored in the Gold layer of a data warehouse to explore customer and product dimensions, date ranges, and key metrics.

This project builds upon my previous SQL Data Warehouse project and focuses on exploring the data through SQL queries.

## Objectives

- Explore distinct values in customer and product dimensions.
- Examine the date ranges of sales transactions and customer birthdates.
- Calculate key metrics, including total sales, total quantity sold, average price, total orders, total products, and total customers.
- Practice writing SQL queries for data exploration and aggregation.

## Tools & Technologies

- **Database:** MySQL 8.0
- **Query Language:** SQL
- **Database Management Tool:** MySQL Workbench
- **Version Control:** Git and GitHub

## Data Sources

The analysis uses the following Gold layer views from the `DataWarehouseProject` database.

| View | Description |
|---|---|
| `gold_dim_customers` | Contains customer dimension data. |
| `gold_dim_products` | Contains product dimension data. |
| `gold_fact_sales` | Contains sales transaction data. |

## Analysis Performed

### 1. Dimensions Exploration

Examines distinct values and combinations in the customer and product dimensions.

- Retrieves distinct customer countries.
- Explores combinations of product categories, subcategories, and product names.

### 2. Date Range Exploration

Examines the date boundaries recorded in the dataset.

- Identifies the earliest and latest order dates.
- Calculates the order date range in months.
- Retrieves the earliest and latest customer birthdates.
- Calculates customer ages using MySQL date functions.

### 3. Measures Exploration

Calculates key metrics from the Gold layer views.

- Total sales
- Total quantity sold
- Average price
- Total orders
- Total products
- Total customers

## Repository Structure

```text
sql_exploratory_data_analysis/
├── sql/
│   ├── 01_database_exploration.sql
│   ├── 02_dimensions_exploration.sql
│   ├── 03_date_exploration.sql
│   ├── 04_measures_exploration.sql
├── results/
│   └── analysis_results.md
└── README.md
```

*Note: Adjust the file list to match the scripts and folders actually available in the repository.*

## Results

The following table summarizes the results obtained from the executed SQL queries.

| Metric | Result |
|---|---:|
| Total Sales | 29,356,250 |
| Total Quantity Sold | 60,423 |
| Average Price | 486.0378 |
| Total Orders | 27,659 |
| Total Products | 295 |
| Total Customers | 18,484 |

The sales transaction date range is from December 29, 2010, to January 28, 2014.

For additional details, see [`results/analysis_results.md`](results/analysis_results.md).

## Related Project

This project uses the Gold layer views from my previous SQL Data Warehouse project.

- **SQL Data Warehouse Project:** [View Repository](https://github.com/widdangist999/sql_data_warehouse_project)

## How to Run

1. Install MySQL Server 8.0 and MySQL Workbench.
2. Ensure that the `DataWarehouseProject` database and the required Gold layer views are available.
3. Clone or download this repository.
4. Open the SQL scripts in MySQL Workbench.
5. Execute the queries against the appropriate database.
6. Review the query outputs and compare them with the documented results.

## Notes

- This repository focuses on exploratory data analysis rather than data warehouse construction.
- The SQL scripts query existing Gold layer views.
- The documented results reflect the outputs provided by the executed queries.
- The total sales value is presented in the dataset's units because the currency has not been specified.

## Connect

- **LinkedIn:** [My LinkedIn Profile](https://www.linkedin.com/in/gist-widdan-anasis-3a0a5b39a?utm_source=share_via&utm_content=profile&utm_medium=member_android)
- **GitHub:** [My GitHub Profile](https://github.com/widdangist999)

