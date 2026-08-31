# LAB09 — Deadlock

## Objective
Intentionally reproduce a deadlock from two HTTP requests, identify the victim and dependency cycle, and collect evidence from `system_health`.

## Time
35–40 min.

## Before you start
- The API and database must be running.
- Prepare the two LAB09 requests in `Workshop.Api.http`.
- Open `sql/06_Deadlock_From_System_Health.sql` and `scripts/Convert-DeadlockXdlToHtml.ps1`.

## Variant A — EF Core (preferred)
Send the two requests almost at the same time:
```text
POST /workshop3/deadlock/session-a?customerId=1&orderId=1
POST /workshop3/deadlock/session-b?customerId=1&orderId=1
```
Session A: `Customers` → `Orders`  
Session B: `Orders` → `Customers`

One response should be HTTP `409` with SQL error `1205`; the other should commit. The victim may vary.

## Variant B — Manual T-SQL fallback
Use two SQL sessions that update `Customers` and `Orders` in reverse order with a short delay between the first and second update, reproducing the same resource cycle.

## Tasks
1. Identify the victim.
2. Draw the `Customers ↔ Orders` dependency cycle.
3. Propose a consistent access order, for example `Customers → Orders`.
4. Discuss retry after error 1205 and why global retry is not enabled for this demo.
5. Run `sql/06_Deadlock_From_System_Health.sql` in VS Code and read the newest `xml_deadlock_report`.
6. Save the XML as `.xdl` and visualize it with `scripts/Convert-DeadlockXdlToHtml.ps1`.

## What to record
- victim session,
- HTTP `409` / SQL `1205`,
- first and second resource for each session,
- dependency cycle,
- conclusion from the deadlock graph,
- prevention and retry strategy.

## Exit criterion
You can reproduce the deadlock, prove it from `system_health`, read the cycle from the graph, and propose a prevention strategy.

## If the result is different
- Both sessions commit: they did not overlap enough; retry.
- No event appears: wait briefly and rerun the helper query.
- A different session is the victim: that is valid; do not hard-code the victim.

## Questions
- How is a deadlock different from blocking?
- Why does SQL Server choose a victim?
- Why is a deadlock graph stronger evidence than error 1205 alone?

## Worksheet
Fill [../worksheets/LAB09_WORKSHEET.md](../worksheets/LAB09_WORKSHEET.md).
