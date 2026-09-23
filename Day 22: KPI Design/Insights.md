# Day 22 – Insights & Key Learnings

Day 22 focused on using SQL not only to calculate metrics, but also to understand how KPI definitions, data grain, customer behaviour, and time-based comparisons affect business analysis.

## 1. KPI Definitions Matter

A KPI is only meaningful when its business definition is clear.

Metrics such as Average Order Value, Repeat Purchase Rate, Customer Lifetime Value, and Churn Rate depend heavily on how the numerator, denominator, customer population, and observation period are defined.

For example, calculating a customer metric using all customers in `DimCustomer` can produce a different result from using only customers who actually purchased during the period being analysed.

The main lesson was:

> Define the business meaning of the metric before writing the SQL.

---

## 2. Grain Determines Whether a Calculation Is Correct

Several Day 22 exercises required changing the grain of the data before calculating the final metric.

`FactInternetSales` can contain multiple rows for one sales order because an order may contain several products.

Therefore, a metric such as Average Order Value or Average Days Between Purchases cannot always be calculated correctly directly from the raw fact-table rows.

For Average Days Between Purchases, for example:

* Intermediate grain: one customer + one distinct order
* Final grain: one customer

This reinforced an important principle:

> Aggregation changes the grain. Window functions can perform calculations while preserving the current grain.

Understanding what one row represents at every stage made the longer queries much easier to reason about.

---

## 3. Customer Retention Requires a Time Dimension

Repeat purchasing, inactivity, retention, and churn describe related but different aspects of customer behaviour.

A repeat customer has purchased more than once.

An inactive customer has not purchased within a defined period.

Retention analysis tracks whether customers continue purchasing over time.

Churn requires a defined starting population, time period, and churn condition.

This means that a simple percentage of currently inactive customers should not automatically be described as a churn rate.

---

## 4. Cohort Analysis Provides More Context Than a Single Retention Percentage

Grouping customers by their first purchase period makes it possible to follow customers from the same acquisition period over time.

Instead of asking only:

> "How many customers are still purchasing?"

cohort analysis makes it possible to ask:

> "How does purchasing behaviour change in the months after customers are first acquired?"

Using month offsets also makes cohorts from different calendar periods comparable.

---

## 5. Window Functions Are Valuable for Time-Based Analysis

`LAG()` was useful in several Day 22 problems because many business questions required comparing the current observation with a previous observation.

It was used to:

* Compare current revenue with previous-month revenue.
* Identify sales decline.
* Retrieve a customer's previous purchase date.
* Calculate the interval between consecutive purchases.

A useful question when using `LAG()` is:

> What entity should have its own sequence?

That determines the appropriate `PARTITION BY`.

---

## 6. Leading and Lagging Indicators Depend on the Outcome Being Studied

A metric cannot simply be called a leading indicator without specifying what it is expected to lead.

For this analysis:

* **Monthly Repeat Purchase Rate** was investigated as a potential leading indicator.
* **Month-over-Month Revenue Growth** was treated as the lagging business outcome.

A leading indicator does not guarantee a future result. It may provide an early signal that should be tested against later outcomes.

---

## 7. Repeat Customers and Revenue Showed an Interesting but Limited Relationship

The initial comparison showed that month-over-month revenue growth remained volatile even while the percentage of returning customers increased.

A closer examination of the overall revenue trend provided additional context.

During 2013, the percentage of returning customers generally increased from approximately **29% to 46%**, while monthly revenue increased overall from approximately **1.05M to 1.87M**.

However, month-over-month revenue growth continued to rise and fall during the same period.

This suggests that repeat purchasing may have a relationship with the overall direction of revenue, but increases in repeat customer rate did not consistently correspond with immediate increases in monthly revenue growth.

Other variables such as customer volume, average order value, product mix, seasonality, and promotions may also influence revenue.

The analysis therefore shows an **association worth investigating further, not evidence of causation**.

---

## 8. Same-Month Comparison Does Not Fully Test a Leading Indicator

Joining Monthly Repeat Purchase Rate and Monthly Revenue Growth for the same month was useful for exploring their relationship.

However, a true leading-indicator test should introduce a time shift.

For example:

> Repeat Purchase Rate in Month T → Revenue Performance in Month T+1

This would test whether changes in repeat purchasing occur before changes in the business outcome rather than simply occurring during the same period.

This remains a useful extension for future analysis.

---

## 9. Validation Is Part of the Analysis

A query executing successfully does not prove that the result is correct.

For the Average Days Between Purchases calculation, individual customers were selected and their orders were manually traced.

The validation checked:

* Whether each order appeared only once
* Whether orders were in chronological sequence
* Whether the previous purchase date was correct
* Whether `DATEDIFF()` produced the expected interval
* Whether the final average matched a manual calculation

This provides a repeatable validation approach for more complex metrics:

> Trace a small sample back to the underlying records and manually reproduce the calculation.

---

## 10. Longer SQL Becomes Manageable When the Problem Is Broken Into Stages

One of the biggest lessons from Day 22 was that a long SQL query is often just several smaller analytical problems connected together.

For the repeat-customer and revenue analysis, the logic moved through stages:

**Raw sales → First purchase → Purchase history → Customer classification → Monthly repeat rate → Monthly revenue → Previous-month revenue → Revenue growth → KPI comparison → Business interpretation**

Thinking in stages made it easier to build, debug, validate, and explain the analysis.

---

## SQL Skills Reinforced

Day 22 strengthened practical use of:

* CTEs
* `GROUP BY`
* `COUNT(DISTINCT ...)`
* Conditional aggregation
* `CASE`
* `SUM()`
* `AVG()`
* `MIN()` and `MAX()`
* `LAG()`
* `DATEDIFF()`
* `NULLIF()`
* `CAST()`
* `ROUND()`
* Window functions
* Multi-stage aggregation
* Time-based analysis
* KPI calculation
* Grain management
* Result validation

## Final Takeaway

The biggest lesson from Day 22 was not a particular SQL function.

It was learning to move from:

**Business Question → Metric Definition → Correct Grain → SQL Logic → Validation → Business Interpretation**

SQL produces the numbers, but analytical reasoning determines whether those numbers actually answer the business question.

