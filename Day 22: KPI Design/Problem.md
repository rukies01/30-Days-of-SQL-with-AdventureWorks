# Day 22 – Business KPIs, Customer Retention & Leading vs Lagging Indicators

## 1. Define and Calculate Key Sales KPIs

Using the AdventureWorks sales data, define and calculate key business KPIs that can be used to evaluate sales performance from different perspectives.

### Tasks

1. **Total Revenue**

   * Calculate the total revenue generated from sales.

2. **Average Order Value (AOV)**

   * Calculate the average revenue generated per order.

3. **Customer Lifetime Value (Revenue-Based CLV)**

   * Calculate the total revenue contributed by each customer over their observed purchase history.

4. **Repeat Purchase Rate**

   * Determine the percentage of customers who placed more than one distinct order.

5. **Order Volume**

   * Calculate the total number of distinct orders.

6. **Month-over-Month Revenue Growth**

   * Calculate monthly revenue and determine the percentage increase or decrease compared with the previous month.

7. **Revenue by Region**

   * Calculate and compare revenue contribution across geographic regions.

8. **Top-Selling Products**

   * Identify the products generating the highest sales revenue.

9. **Sales Decline Analysis**

   * Identify products, customers, and regions experiencing declining sales by comparing current-period performance with previous-period performance.

10. **Revenue Contribution Analysis**

    * Calculate the percentage of total revenue contributed by:

      * Products
      * Customers
      * Product categories

---

## 2. Create Customer Retention Metrics

Develop metrics that help explain customer purchasing behaviour and retention.

### Tasks

1. **Repeat Purchase Rate**

   * Determine what percentage of customers make more than one purchase.

2. **Active vs Inactive Customers**

   * Classify customers based on the number of days since their most recent purchase.

3. **Average Days Between Purchases**

   * Calculate the average number of days between consecutive purchases for each customer.

4. **Customer Retention Cohort**

   * Group customers by their first purchase period and track purchasing activity in subsequent months.

5. **Customer Churn Rate**

   * Develop a churn metric based on a clearly defined customer population, observation period, and inactivity/churn rule.

---

## 3. Identify Leading vs Lagging Indicators

Investigate the difference between metrics that measure completed business outcomes and metrics that may provide an early signal of future performance.

### Business Question

Can changes in customer repeat-purchase behaviour provide an early indication of changes in revenue performance?

### Metrics

**Potential Leading Indicator:**

* Monthly Repeat Purchase Rate

**Lagging Outcome:**

* Month-over-Month Revenue Growth

### Tasks

1. Calculate the monthly repeat purchase rate.
2. Calculate monthly revenue.
3. Calculate month-over-month revenue growth.
4. Combine both monthly metrics at the same grain.
5. Compare changes in repeat purchase behaviour with revenue performance.
6. Determine whether a visible relationship exists.
7. Distinguish between association and causation when interpreting the results.

---

## Analytical Framework

For each problem, define the analytical logic before writing SQL:

* **One row = ?**
* **Measure = ?**
* **Numerator / Denominator = ?**
* **Filter = ?**
* **Tables / Data Needed = ?**
* **Do I need to aggregate to another level first?**
* **Which SQL approach best fits the problem?**
* **How will I validate the result?**
* **What does the result tell me?**
* **What can I NOT conclude from the result?**

