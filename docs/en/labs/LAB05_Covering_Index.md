# LAB05 — Covering Index and Key Lookup

## Objective
Understand why `Index Seek` does not automatically mean an optimal plan.

## Time
30–35 min.

## Before you start
- LAB04 should be complete.
- `IX_Orders_CustomerId` should exist in its simple form without `INCLUDE`.
- Enable Actual Execution Plan and `STATISTICS IO` in VS Code.

## Steps
1. Keep the simple `IX_Orders_CustomerId` index.
2. Run the customer 123 order query and inspect the plan for `Key Lookup`.
3. Record actual rows and logical reads.
4. Replace the index with:
```sql
CREATE INDEX IX_Orders_CustomerId
ON dbo.Orders(CustomerId)
INCLUDE(OrderDate, Status, TotalAmount);
```
5. Run the same query again and compare.

## What to record
- whether Key Lookup exists BEFORE,
- logical reads BEFORE and AFTER,
- whether the lookup disappears,
- `INCLUDE` columns,
- benefit and write/storage trade-off.

## Exit criterion
You can explain why a Seek can drive repeated lookups and when a covering index removes that work.

## If the result is different
- No Key Lookup: verify the index is not already covering from an earlier run.
- The optimizer chooses another strategy: record the actual plan and explain it using row count and cost.
- The plan does not change: verify you executed the same query after rebuilding the index.

## Questions
- What is a covering index?
- What is the cost of wider indexes?
- Why should `INCLUDE` not be the automatic answer to every Key Lookup?

## Worksheet
Fill [../worksheets/LAB05_WORKSHEET.md](../worksheets/LAB05_WORKSHEET.md).
