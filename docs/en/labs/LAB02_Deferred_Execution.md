# LAB02 — Deferred Execution

## Objective
See the difference between composing a LINQ query and materializing it — **without editing the code**.

## Time
25–30 min.

## Before you start
- LAB01 should be complete.
- The API must be running and the `dotnet run` log visible.
- Open `Workshop1Endpoints.cs` and `Workshop.Api.http`.

## Steps
1. Call `GET /workshop1/deferred/City%201`.
2. Find the SQL in the API log. It should contain the `City` filter and `TOP (50)`, but no `CustomerId > …`.
3. In `Workshop1Endpoints.cs`, identify which lines compose `IQueryable` and which line materializes it (`ToListAsync`).
4. Call `GET /workshop1/deferred/City%201?minId=1000`.
5. Compare the SQL. The extra predicate should be part of the same final statement.
6. Confirm that both variants return 50 rows and record the first IDs.
7. Optional: use a breakpoint to confirm there is no round-trip before `ToListAsync()`.

## What to record
- SQL without `minId`,
- SQL with `minId=1000`,
- first IDs from both results,
- materialization method,
- whether the extra predicate is in the same round-trip.

## Expected result
`Where()` composes the expression tree; execution happens at materialization. A predicate added before materialization becomes part of the same SQL statement.

## Exit criterion
You can explain query composition vs execution and prove it with the two generated SQL statements.

## If the result is different
- No SQL difference: verify the second URL contains `?minId=1000`.
- No SQL in the log: repeat the request and check the `dotnet run` console.
- Fewer than 50 rows: verify the database was built with the current setup script.

## Questions
- Why does deferred execution matter?
- Does every LINQ method cause a round-trip?

## Worksheet
Fill [../worksheets/LAB02_WORKSHEET.md](../worksheets/LAB02_WORKSHEET.md).
