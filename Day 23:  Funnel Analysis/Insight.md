# Day 23 – Funnel Analysis: Insights

## Key Results

The fulfilment funnel produced the following results:

| Funnel Stage | Distinct Orders |
|---|---:|
| Orders Placed | 27,659 |
| Orders Shipped | 27,659 |
| Orders Shipped On Time | 27,659 |

This resulted in:

- **Placed → Shipped drop-off:** 0%
- **Shipped → Shipped On Time drop-off:** 0%

---

## 1. No Observable Drop-Off

All 27,659 orders represented in the dataset had a recorded shipment date.

The same 27,659 orders also had a `ShipDate` that was on or before their `DueDate`.

Therefore, no order loss was observed between the selected funnel stages.

---

## 2. No Bottleneck Was Identified

Because both stage-to-stage drop-off rates were 0%, there was no observable bottleneck within the analysed stages.

However, this does **not** prove that the entire fulfilment process has no bottlenecks.

It only means that the available data and the stages selected for this analysis do not reveal one.

---

## 3. Dataset Limitations Matter

The dataset does not provide an actual delivery date or a delivery status.

Therefore, the analysis cannot determine:

- whether orders were successfully delivered,
- whether customers received orders on time,
- whether delays occurred after shipment,
- or whether cancelled or incomplete orders are represented elsewhere.

`DueDate` represents an expected deadline and should not be treated as proof of actual delivery.

This limits how far the funnel can be extended using the available fields.

---

## 4. A Zero Result Is Still an Analytical Result

The original goal was to identify drop-off and potential bottlenecks.

The data produced no drop-off.

Rather than changing the definition of the funnel simply to create a more interesting result, the correct approach was to report what the data showed and document its limitations.

This reinforced an important analytical principle:

> **Do not force the data to support a story that it cannot support.**

---

## 5. SQL and Analytical Lessons

This exercise reinforced several concepts:

- `COUNT(DISTINCT ...)` is necessary when the source table contains multiple rows for the same order.
- Conditional aggregation allows several funnel stages to be calculated from the same dataset without filtering out earlier stages.
- Funnel percentages should use the previous stage as the denominator.
- `NULLIF()` should protect the denominator, not the numerator.
- Decimal arithmetic is necessary to avoid unintended integer division when calculating percentages.
- Each later funnel stage should logically be a subset of the previous stage.
- A technically correct SQL result still needs to be evaluated against the structure and limitations of the underlying data.

---

## Final Takeaway

Funnel analysis is not only about calculating conversion or drop-off rates.

It requires defining meaningful stages, maintaining the correct grain, choosing the correct denominator, validating that each stage is logically related to the previous one, and understanding what the available data can actually support.

In this analysis, the calculations were valid, but the dataset showed no variation across the selected stages.

The most important conclusion was therefore not that the fulfilment process is perfect, but that:

**No fulfilment bottleneck is observable from the selected stages and available data.**
