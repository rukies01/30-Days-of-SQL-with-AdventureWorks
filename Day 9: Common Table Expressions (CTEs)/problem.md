On Day 9, I focused on using Common Table Expressions (CTEs) and window functions to move from simple aggregation to advanced customer intelligence analysis.

The objectives were:
1. Use a CTE to calculate total sales per customer.
2. From that result, rank customers by spend.
3. Identify customers above the 75th percentile.

These problems required thinking beyond syntax and focusing on:

Data grain control (transaction-level → customer-level)

Relative performance (percentiles instead of fixed thresholds)

Customer behavioral analysis
