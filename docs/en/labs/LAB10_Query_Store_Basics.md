# LAB10 — Query Store Basics

## Objective
Learn to find application queries in Query Store and connect them to a specific EF Core workload.

## Time
35 min.

## Before you start
- The API and database must be running.
- Query Store should be `READ_WRITE` with `QUERY_CAPTURE_MODE = ALL`.
- Prepare VS Code, `sql/05_Diagnostics.sql`, and the `dotnet run` log.

## Steps
1. Call:
   - `GET /workshop4/customer/123/orders-bad`
   - `GET /workshop4/customer/123/orders-nplus1`
   - `GET /workshop2/orders/customer/123`
2. Run all of `sql/05_Diagnostics.sql`. The **third** result set is Query Store. After generating workload, wait up to 1 minute and refresh.
3. Find queries related to `Customers`, `Orders`, and `OrderLines`.
4. Record `query_id`, `count_executions`, avg duration, avg CPU, avg logical reads, and SQL shape.
5. Distinguish a wide graph query from repeated `COUNT(*) FROM OrderLines` statements.
6. Identify old Workshop 3 rows by SQL shape rather than automatically attributing them to W4.

`query_id` may change after a rebuild. Identify scenarios by `query_sql_text`, `count_executions`, and SQL shape.

## What to record
- SQL shape for the important entries,
- execution count, duration, CPU, and logical reads,
- which rows belong to the wide graph vs N+1,
- which rows may belong to earlier workload.

## Expected result
You can move from “the application is slow” to a concrete SQL statement, execution count, and measurable Query Store evidence.

## Exit criterion
You can identify the workload without relying on a fixed `query_id`.

## If the result is different
- Query Store is empty: regenerate workload, wait up to 1 minute, and refresh.
- Old long-running rows dominate: identify entries by SQL shape.
- N+1 is not visible: run `orders-nplus1` again and compare execution counts.

## Worksheet
Fill [../worksheets/LAB10_WORKSHEET.md](../worksheets/LAB10_WORKSHEET.md).
