Day 16 Insights — Running Totals

Today’s exercises focused on window functions, particularly how SUM() OVER() can be used to calculate cumulative metrics without collapsing rows like traditional aggregation.

A key takeaway was understanding the roles of ORDER BY and PARTITION BY inside window functions.

ORDER BY controls the sequence in which the cumulative calculation progresses.

PARTITION BY resets the running total for each group (e.g., per customer or product category).

Another important concept was identifying threshold crossing points using cumulative values. By combining a running total with a benchmark and ranking rows using ROW_NUMBER(), it becomes possible to detect the first moment a metric surpasses a target.

This pattern is widely used in analytics scenarios such as tracking revenue milestones, monitoring customer lifetime value growth, and identifying when performance targets are achieved.
