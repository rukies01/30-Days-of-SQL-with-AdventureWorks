# AdventureWorks Sales & Customer Analytics

### T-SQL | SQL Server | Customer Analytics | Sales Analysis | Window Functions

A business-focused SQL analytics project using the AdventureWorks OLTP and
AdventureWorksDW databases to analyse sales performance, customer behaviour,
product trends and data quality.

The project demonstrates how I use T-SQL to move from business questions to
validated analytical results and interpretable business insights.

## ⭐ Featured Analyses

Selected examples from the project highlighting business-focused and advanced T-SQL work.

### Data Quality & Reporting Reliability
**Day 10 — Data Quality Checks**

Validated analytical data by checking missing customer relationships, duplicate sales records and invalid sales values before downstream reporting.

[View SQL Solution](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2010%3A%20Data%20Quality%20Checks/Solution.sql)  
[View Insights](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2010%3A%20Data%20Quality%20Checks/insights.md)

---

### Customer & Product Ranking
**Day 15 — ROW_NUMBER, RANK & DENSE_RANK**

Used ranking functions to identify high-value customers, rank products within categories and identify top-performing products while accounting for ties.

[View SQL Solution](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2015%3A%20ROW_NUMBER%2C%20RANK%2C%20DENSE_RANK/Solution.sql)  
[View Insights](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2015%3A%20ROW_NUMBER%2C%20RANK%2C%20DENSE_RANK/Insights.md)

---

### Cumulative Sales Analysis
**Day 16 — Running Totals**

Used windowed aggregations to track cumulative sales over time and explore threshold-crossing analytical patterns.

[View SQL Solution](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2016%3A%20Running%20Totals/solution.sql)  
[View Insights](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2016%3A%20Running%20Totals/insights.md)

---

### Month-over-Month Performance
**Day 17 — LAG & LEAD**

Compared current-period revenue with prior periods, calculated month-over-month growth and identified months where sales declined.

[View SQL Solution](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2017%3A%20LAG%20and%20LEAD/solution.sql)  
[View Insights](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2017%3A%20LAG%20and%20LEAD/insights.md)

---

### Customer Behaviour Analytics
**Day 20 — Advanced Analytics**

Analysed repeat purchasing, purchase intervals, customer lifespan and customer lifetime value using transaction-level analysis and window functions.

[View SQL Solution](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2020%3A%20Advanced%20Analytics/Solution.sql)  
[View Insights](https://github.com/rukies01/30-Days-of-SQL-with-AdventureWorks/blob/main/Day%2020%3A%20Advanced%20Analytics/Insights.md)

---

---

## 📌 Project Overview

Business analysts rarely receive a perfectly defined SQL question.

More often, stakeholders ask questions such as:

- Who are our highest-value customers?
- Which products are performing best?
- How is revenue changing over time?
- Which customers may be becoming inactive?
- Which products are declining in sales?
- How does performance vary across regions?
- Are there data-quality issues that could affect reporting?

This project uses AdventureWorks data to investigate these types of questions
using progressively more advanced SQL techniques.

The analysis covers transactional querying, multi-table joins, customer and
product analysis, time-series analysis, data validation and advanced window
functions.

---

## 🎯 Project Objectives

The project aims to demonstrate the ability to:

- Translate business questions into SQL queries
- Navigate relational database structures
- Combine data across multiple tables
- Analyse sales, customer and product performance
- Identify trends and changes over time
- Segment and rank customers
- Perform data-quality validation
- Use window functions for advanced analytical problems
- Validate query results before drawing conclusions
- Translate technical output into business-friendly insights

---

## 🗄️ Data Sources

Two Microsoft sample databases are used.

### AdventureWorks OLTP

Used primarily for transactional analysis involving:

- Sales orders
- Customers
- Products
- Product categories and subcategories
- Geographic information
- Order-level analysis

### AdventureWorksDW

Used for analytical scenarios involving:

- Historical sales performance
- Customer analysis
- Product performance
- Time-series analysis
- Ranking and segmentation
- Advanced window functions

---

## 🔍 Key Areas of Analysis

### 1. Sales Performance Analysis

SQL queries are used to analyse sales at different levels of detail,
including:

- Total sales
- Sales by year
- Sales by customer
- Average order value
- Orders by region
- Monthly sales trends
- Month-over-month performance

This provides a foundation for understanding overall business performance.

---

### 2. Customer Analytics

Customer-level analysis explores purchasing behaviour and customer value.

Examples include:

- Identifying top customers by sales
- Comparing customer spend with average customer spend
- Customer value segmentation
- Ranking customers by performance
- Identifying repeat customers
- Analysing time between purchases
- Approximating customer lifetime value
- Identifying potentially inactive customers

---

### 3. Product Performance

Product analysis is used to understand performance both overall and within
individual categories.

Analysis includes:

- Identifying products that have never been sold
- Comparing product prices with category averages
- Ranking products within categories
- Identifying top-performing products
- Identifying declining products
- Comparing product performance using window functions

---

### 4. Time-Series Analysis

Time-based SQL analysis is used to understand how performance changes over
time.

Techniques include:

- Monthly and yearly aggregation
- Running totals
- Month-over-month comparisons
- `LAG()` and `LEAD()`
- Cumulative sales analysis
- Identification of periods of sales decline

---

### 5. Data Quality Analysis

Before relying on analytical results, SQL is used to investigate potential
data-quality problems.

Checks include:

- Missing customer information
- Duplicate records
- Unexpected zero values
- Negative values where inappropriate
- Validation of relationships between tables

Data-quality validation is treated as part of the analytical process rather
than a separate afterthought.

---

## 🧠 SQL Techniques Demonstrated

| Area | Techniques |
|---|---|
| Core Querying | `SELECT`, `WHERE`, `ORDER BY` |
| Relational Analysis | `INNER JOIN`, `LEFT JOIN`, multi-table joins |
| Aggregation | `SUM`, `AVG`, `COUNT`, `GROUP BY` |
| Business Logic | `CASE` expressions |
| Advanced Filtering | Subqueries |
| Reusable Logic | Common Table Expressions (CTEs) |
| Ranking | `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()` |
| Analytical SQL | `OVER()`, `PARTITION BY` |
| Time-Series Analysis | `LAG()`, `LEAD()` |
| Cumulative Analysis | Running totals |
| Data Validation | Missing values, duplicates and invalid values |
| Customer Analytics | Segmentation, repeat behaviour and purchase frequency |

---

## 💡 Featured Analytical Scenarios

### Customer Value Segmentation

Customer sales performance is aggregated and analysed to distinguish between
different levels of customer value.

Techniques used include:

`SUM()` • `CASE` • CTEs • Ranking Functions

This type of analysis can support customer prioritisation and targeted
business strategies.

---

### Product Ranking Within Categories

Window functions are used to compare products within their respective
categories rather than only across the entire product portfolio.

Techniques used include:

`PARTITION BY` • `ROW_NUMBER()` • `RANK()` • `DENSE_RANK()`

This allows top-performing products to be identified within meaningful
business groups.

---

### Month-over-Month Sales Analysis

Historical sales are compared across consecutive periods to identify changes
in performance.

Techniques used include:

`LAG()` • Date Functions • Aggregation • Window Functions

This makes it possible to identify periods of growth or decline and investigate
changes in sales performance.

---

### Running Sales Performance

Running totals are used to evaluate cumulative sales over time and monitor
progress against performance thresholds.

Techniques used include:

`SUM() OVER()` • `ORDER BY` • `PARTITION BY`

---

### Customer Purchase Behaviour

Customer purchase history is analysed to understand repeat behaviour,
purchase frequency and the time between transactions.

This extends the analysis beyond basic revenue reporting into customer
behaviour analytics.

---

## 🔄 Analytical Workflow

My approach throughout the project follows a consistent process:

**Business Question**

↓

**Identify Relevant Tables**

↓

**Understand Table Relationships**

↓

**Write SQL Query**

↓

**Validate Results**

↓

**Analyse Output**

↓

**Translate Findings Into Business Language**

The objective is not simply to produce syntactically correct SQL, but to use
SQL as an analytical tool for business decision-making.

---

## 📂 Repository Structure

The analysis is organised into individual modules.

Typical structure:

```text
Day XX/
│
├── problem.md
├── solution.sql
└── insights.md
```

### `problem.md`

Documents the analytical questions being investigated.

### `solution.sql`

Contains the T-SQL queries used to solve the analytical problems.

### `insights.md`

Translates query results and observations into understandable analytical
insights.

This structure separates:

**Business Problem → Technical Solution → Analytical Interpretation**

---

## 🛠️ Tools & Technologies

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- AdventureWorks OLTP
- AdventureWorksDW
- Git
- GitHub

---

## 📈 Skills Demonstrated

- SQL & T-SQL
- Relational database analysis
- Multi-table joins
- CTEs
- Window functions
- Customer analytics
- Sales analytics
- Product analysis
- Time-series analysis
- Data-quality validation
- Query refactoring
- Analytical problem solving
- Business insight communication

---

## 🚧 Project Status

This is an ongoing analytical SQL project.

**21 analytical modules have currently been completed**, progressing from
database exploration and relational querying through advanced window functions
and customer analytics.

Future modules will extend the project into KPI design, funnel analysis,
anomaly detection, BI-ready reporting queries and an end-to-end business case.

The existing analysis represents the work completed to date and will continue
to evolve as additional business scenarios are added.

---

## 🎯 Portfolio Purpose

This project demonstrates my ability to use SQL beyond basic data extraction.

The focus is on connecting technical SQL skills with business analysis:
understanding the question, selecting the appropriate data, building and
validating the query, and translating the result into information that can
support decision-making.
