Key Lessons Learned
1. Aggregation summarizes business data

I learned that aggregate functions help convert detailed transactional data into business-level summaries.

Functions like:

SUM()
AVG()
COUNT()

are used to answer high-level business questions.

2. GROUP BY defines the level of analysis

One of the most important lessons was understanding that GROUP BY controls how data is summarized.

Examples:

grouping by year gives yearly metrics,
grouping by customer gives customer-level metrics,
grouping by region gives regional metrics.

The grouping columns determine the granularity of the output.

3. SUM() is useful for revenue analysis

Using:

SUM(SalesAmount)

made it possible to calculate:

total sales,
yearly revenue,
and regional performance.

This is one of the most common calculations in business analytics.

4. Average Order Value (AOV) requires business understanding

I learned that Average Order Value is not simply the average of sales rows.

AOV is better calculated as:

Total Revenue / Number of Orders

This avoids misleading results when orders contain multiple transaction rows.

5. COUNT() helps measure business activity

Using:

COUNT(DISTINCT SalesOrderNumber)

helps measure:

order volume,
customer activity,
and regional demand.

Using DISTINCT is important to avoid counting duplicated order rows.

6. Aggregations are foundational for analytics

This challenge showed that many business questions begin with aggregation.

Before advanced analytics, it is important to understand:

how to summarize data,
how to group correctly,
and how business metrics are calculated.
