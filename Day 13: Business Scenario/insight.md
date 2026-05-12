## Key Lessons Learned

### 1. Window functions require the correct entity partition

One of the biggest lessons today was understanding that window functions must follow the correct business entity.

For product sales trends:
e.g
PARTITION BY ProductName

was necessary because each product has its own timeline.

Without partitioning, `LAG()` and `LEAD()` compare rows across different products, producing incorrect results.

---

### 2. `DATEDIFF()` measures time forward

I learned that:

DATEDIFF(start_date, end_date)

works like:
interval between too dates, business context defines direction

For customer inactivity analysis:

* CustomerLastOrderDate must come first
* MaxOrderDate must come second

This correctly measures how long a customer has been inactive.

---

### 3. Window functions preserve row-level detail

Functions like:

* `LAG()`
* `LEAD()`
* `RANK()`
* `MAX() OVER()`

allow calculations across rows without collapsing the dataset like aggregation functions do.

This makes it possible to:

* compare periods,
* detect trends,
* classify customers,
* and rank business performance while still keeping detailed rows.

---

### 4. Business problems require business definitions

I also learned that terms like:

* “inactive customer”
* “declining sales”
* “high-performing region”

must first be clearly defined before writing SQL.

Example:

* inactive customer = no purchase in 90+ days
* declining product = current revenue lower than next/current comparison period

The SQL logic depends entirely on the business definition.

---

### 5. Cleaner SQL comes from layered thinking

Breaking the solution into multiple CTEs made the logic easier to understand and debug.

A better workflow was:

1. Build base business metrics
2. Extend calculations with window functions
3. Apply classification logic
4. Filter final output

This produced cleaner and more readable SQL.
