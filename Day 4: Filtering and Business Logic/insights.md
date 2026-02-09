Data-Anchored Thinking

When working with historical datasets, “last 12 months” should be anchored to the maximum available date in the dataset and not the system date. This ensures analytical accuracy.

 WHERE vs HAVING

This challenge strengthened my understanding of SQL execution order:

WHERE filters before aggregation

HAVING filters after aggregation

Understanding this distinction is critical for writing correct analytical queries.

 Window Functions for Business Logic

Using:

AVG(...) OVER (PARTITION BY ...)


allowed me to compare each product’s price to its category’s average without losing row-level detail.

This represents a shift from basic aggregation to category-aware analytical reasoning.

Analyst Mindset Development

This exercise reinforced that SQL is not just about syntax. It requires:

Clarifying business intent (dataset-relative vs system-relative time)

Choosing correct comparison levels (transaction vs product vs category)

Avoiding unstable grouping fields (names vs keys)

Understanding how SQL processes data internally

I am moving from writing queries to structuring business logic using SQL.
