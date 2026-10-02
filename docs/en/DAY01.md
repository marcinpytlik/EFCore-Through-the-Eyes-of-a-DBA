# Day 1 — From HTTP Request to SQL Server

## Goal

Build the full path from an HTTP request to the SQL statement that SQL Server actually executes.

## Start of day

1. Complete the [Student Setup Guide](STUDENT_SETUP_GUIDE.md).
2. Keep the API console visible.
3. Open a SQL editor connected to `EfCoreDbaLab`.
4. Open `src/Workshop.Api/Workshop.Api.http`.
5. Open `src/Workshop.Api/Endpoints/Workshop1Endpoints.cs`.
6. Keep [QUICK_REFERENCE.md](QUICK_REFERENCE.md) nearby.

## Labs

### LAB01 — From HTTP Request to SQL Server
Trace request → EF Core → generated SQL → C# source.

[Open LAB01](labs/LAB01_HTTP_to_SQL.md)

### LAB02 — Deferred Execution
Separate query composition from query execution.

[Open LAB02](labs/LAB02_Deferred_Execution.md)

### LAB03 — Over-fetching vs Projection
Compare a wide entity graph with a projection shaped for the endpoint.

[Open LAB03](labs/LAB03_Overfetching_and_Projection.md)

### LAB04 — Missing Index: Scan vs Seek
Introduce execution-plan evidence and compare the same query before and after an index change.

[Open LAB04](labs/LAB04_Missing_Index.md)

## End-of-day checkpoint

Before moving to Day 2, make sure you can answer:

1. What does SQL Server receive from EF Core?
2. What causes an `IQueryable` to execute?
3. Why can `Take(100)` still produce more than 100 relational rows after a join?
4. What does projection change?
5. Why should you compare plan shape and logical reads instead of relying on one elapsed-time measurement?
