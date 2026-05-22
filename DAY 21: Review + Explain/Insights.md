- Explain window functions **without writing code**.

If you wanted to see each order and also know that customer’s total spend, 
a window function would let you keep every order row and add the customer total next to it. 
That is different from grouping, where you would only get one row per customer.

A window calculation usually has three ideas:
--Partitioning: split the data into groups, like by customer or product.
--Ordering: decide the sequence inside each group, like by date.
--Frame: define exactly which nearby rows are included in the calculation.

What they help with

They are useful when you want to:
Calculate running totals or moving averages.
Rank rows within a group.
Compare a row to the previous or next row.
Show a customer’s total or average beside each individual order.
Avoid self-joins and complicated nested queries.

How they differ from aggregates

Regular aggregates like SUM or AVG with GROUP BY reduce many rows into one row per group. 
Window functions do not remove rows; they add a new calculated column while preserving the original row count
Window functions let you do calculations across a set of related rows while still keeping one result per row. 
The big idea is: they give you context without collapsing your data the way GROUP BY does.

- Practice explaining to a non-technical audience.
