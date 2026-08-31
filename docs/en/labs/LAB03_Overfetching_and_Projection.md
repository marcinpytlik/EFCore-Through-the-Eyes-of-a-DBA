# LAB03 — Over-fetching vs Projection

## Objective
Compare loading full entities with projecting only the data the endpoint needs.

## Time
35–40 min.

## Before you start
- The API and database must be running.
- Prepare `Workshop.Api.http` or Swagger, the `dotnet run` log, and a SQL connection in VS Code.
- Do not change endpoint code before the first measurement.

## Steps
1. Call `GET /workshop1/customers-bad`.
2. Record the number of tables/JOINs, SELECT width, and HTTP response size.
3. Call `GET /workshop1/customers-good`.
4. Compare generated SQL and response shape.
5. In VS Code use `SET STATISTICS IO ON;` and `SET STATISTICS TIME ON;` for equivalent SQL.
6. Compare logical reads, CPU, elapsed time, and payload. Do not assume payload reduction must produce the same reduction in logical reads.
7. Add `City` to the good projection without loading the full entity graph.

This lab does not depend on hot customer 123 — the endpoint takes the first 100 customers. The goal is wide graph vs projection.

## What to record
- BAD and GOOD SQL,
- JOIN count and selected columns,
- logical reads / CPU / elapsed,
- HTTP payload size,
- which fields the API client actually needs.

## Expected result
Projection reduces transferred data and materialization cost even when SQL Server I/O does not fall proportionally.

## Exit criterion
You can show what was removed from the data shape and prove the difference with at least two kinds of evidence: SQL/plan/I/O and payload.

## If the result is different
- Timing varies: prioritize SQL shape, reads, and payload.
- Payload looks the same: verify that you compared `customers-bad` with `customers-good`.
- The project does not compile after the DTO change: revert and add `City` only to the intended projection.

## Questions
- Is `Include()` always wrong?
- When is projection better?
- Why can a much smaller payload still have similar logical reads?

## Worksheet
Fill [../worksheets/LAB03_WORKSHEET.md](../worksheets/LAB03_WORKSHEET.md).
