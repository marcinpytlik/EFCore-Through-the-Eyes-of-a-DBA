# LAB02 — Deferred Execution

## Objective
Distinguish between building an IQueryable expression and executing it against SQL Server.

## Student Instructions
1. Call `GET /workshop1/deferred/City%201`.
2. Set a breakpoint on `var query = db.Customers.Where(c => c.City == city);`.
3. Confirm that no SQL has executed yet.
4. Step to `ToListAsync()` and observe when SQL appears in the log.
5. Add another `Where()` before materialization and compare the final SQL.

## Deliverable
Record observations, evidence and a short conclusion for the lab.