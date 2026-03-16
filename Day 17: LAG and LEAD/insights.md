Day 17 Insights — LAG and LEAD

Day 17 focused on understanding how window functions can reference values from other rows without collapsing the dataset. The LAG() function allows access to values from a previous row based on a defined order, making it especially useful for time-series analysis.

One key takeaway was the importance of ordering data correctly when using LAG(). By ordering sales data by year and month, it becomes possible to accurately compare each month’s revenue with the previous month.

Another important concept was calculating Month-over-Month (MoM) growth, which measures how performance changes between periods. This was achieved by subtracting the previous month’s revenue from the current month’s revenue and dividing by the previous month’s value, while using NULLIF() to prevent division-by-zero errors.

Finally, identifying sales decline simply required filtering rows where the current month’s revenue was lower than the previous month’s. This pattern is widely used in business analytics to detect performance drops, customer churn signals, and negative trends in key metrics.
