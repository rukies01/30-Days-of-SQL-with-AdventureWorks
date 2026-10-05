# Day 23 – Funnel Analysis

## Objective

Analyze how orders move through the available fulfilment stages, measure drop-off between stages, and determine whether there is an observable bottleneck in the process.

## Business Questions

1. How many orders reached each stage of the fulfilment process?
2. What percentage of orders dropped off between consecutive stages?
3. Is there an observable bottleneck in the fulfilment process?

## Funnel Definition

Based on the fields available in the dataset, the funnel was defined as:

**Orders Placed → Orders Shipped → Orders Shipped On Time**

Where:

- **Orders Placed:** Distinct orders recorded in the dataset.
- **Orders Shipped:** Distinct orders with a recorded `ShipDate`.
- **Orders Shipped On Time:** Distinct orders where `ShipDate <= DueDate`.

> **Note:** The dataset does not contain an actual delivery date or delivery status. Therefore, `DueDate` was not treated as a delivery date. The analysis is limited to shipment performance.

---

## Task 1: Orders by Stage

### Business Question

How many distinct orders reached each stage of the fulfilment funnel?

### Analytical Approach

- **One row in the final result:** Funnel summary
- **Measure:** Distinct order count
- **Order identifier:** `SalesOrderNumber`
- **Data needed:** `SalesOrderNumber`, `ShipDate`, `DueDate`
- **Table:** `FactInternetSales`

Because an order can contain multiple product rows, orders must be counted using distinct `SalesOrderNumber`.

Conditional aggregation is used to count orders that meet the requirements for each stage without filtering orders needed for the earlier stages.

---

## Task 2: Drop-Off Analysis

### Business Question

What percentage of orders failed to progress from one funnel stage to the next?

### Stage 1 Drop-Off

**Orders Placed → Orders Shipped**

Drop-off rate:

`((Total Orders - Shipped Orders) / Total Orders) × 100`

### Stage 2 Drop-Off

**Orders Shipped → Orders Shipped On Time**

Drop-off rate:

`((Shipped Orders - Orders Shipped On Time) / Shipped Orders) × 100`

The denominator for each calculation represents the number of orders entering that stage.

`NULLIF()` is used on the denominator to protect the calculation from division by zero.

---

## Task 3: Bottleneck Identification

### Business Question

Which stage of the fulfilment process has the greatest loss of orders?

The stage-to-stage drop-off rates are compared to determine whether one stage represents a potential bottleneck.

A higher drop-off would indicate that fewer orders successfully progressed through that part of the process.

The result must also be interpreted within the limitations of the available dataset.
