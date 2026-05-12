Day 19 focused on understanding the difference between aggregation and window functions, especially in terms of data grain and row-level detail.

A major lesson was that aggregation using GROUP BY reduces rows into summarized results, which is useful for reporting totals and summaries. However, window functions make it possible to calculate totals, averages, rankings, and comparisons while still preserving the original rows.

One important concept learned was identifying the correct grain of data at each stage of a query. For example, calculating order value required grouping data at the order level, while customer average order value required calculations across all orders belonging to the same customer. Separating these steps into layered CTEs made the logic clearer and more accurate.

Another key insight was that window functions are especially useful when both detailed records and aggregated metrics are needed in the same result set. This allows analysts to compare individual rows against group-level benchmarks without losing transactional detail.

Overall, this challenge reinforced the importance of:

understanding data grain,
separating calculations by analytical level,
and using window functions to combine detailed and summarized insights in a single query.
