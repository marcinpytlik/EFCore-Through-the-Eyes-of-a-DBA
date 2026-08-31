# LAB04 — Missing Index: Scan vs Seek

## Objective
Observe an execution-plan change after adding an index without changing the C# code.

## Time
40 min.

## Before you start
- Workshop 1 should be complete.
- The Workshop 2 baseline should not contain `IX_Orders_CustomerId` yet.
- Prepare VS Code with Actual Execution Plan enabled.

## Steps
1. Keep the baseline state and call `GET /workshop2/orders/customer/123`.
2. In VS Code run the equivalent query with `SET STATISTICS IO ON;` and `SET STATISTICS TIME ON;`.
3. Record operator, logical reads, CPU, elapsed time, estimated rows, and actual rows.
4. Create:
```sql
CREATE INDEX IX_Orders_CustomerId
ON dbo.Orders(CustomerId);
```
5. Run the same query again and compare the plan and measurements.

Customer 123 intentionally has many orders. A Seek can still read many rows, but it no longer needs to scan the whole table.

## What to record
- BEFORE and AFTER access operator,
- logical reads BEFORE and AFTER,
- estimated vs actual rows,
- CPU/elapsed as supporting metrics,
- the added index name.

## Exit criterion
You can show two plans for the same query and explain why the index changes the access path.

## If the result is different
- You already see a Seek before creating the index: `IX_Orders_CustomerId` probably exists from an earlier run; reset the lab state.
- No plan is visible: enable Actual Execution Plan before executing the query.
- Timings vary: base the conclusion on operator and logical reads.

## Worksheet
Fill [../worksheets/LAB04_WORKSHEET.md](../worksheets/LAB04_WORKSHEET.md).
