# SQL Server Diagnostic Quick Reference

## Tools
- SQL: `localhost,14333` / `EfCoreDbaLab` / `sa` / `LabPassword!2026`
- Plan: Include Actual Execution Plan, then run the query
- Reads: Messages after `SET STATISTICS IO, TIME ON`
- EF log: `dotnet run` console → `Microsoft.EntityFrameworkCore.Database.Command`
- Two requests: `src/Workshop.Api/Workshop.Api.http`, not Swagger
- Query Store in `sql/05_Diagnostics.sql`: the **third** result set (`-- Query Store: recent resource consumers`)

## Current requests / blocking
```sql
SELECT r.session_id, r.status, r.wait_type, r.wait_time,
       r.blocking_session_id, t.text
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE r.session_id <> @@SPID;
```

## Locks
```sql
SELECT request_session_id, resource_type, resource_description,
       request_mode, request_status
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID(N'EfCoreDbaLab');
```

## I/O and time
```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```

## Plan operators to watch
- Clustered Index Scan
- Index Scan
- Index Seek
- Key Lookup
- Sort
- Nested Loops
- Hash Match

## Diagnostic questions
1. What SQL reached SQL Server?
2. Estimated vs actual rows?
3. What access method was used?
4. How many logical reads?
5. Is the query shape larger than the API needs?
6. Is the transaction open too long?
7. Application, Database, or Both?

## Lab defaults
- API: `http://localhost:5000`
- SQL: `localhost,14333` / `EfCoreDbaLab`
- Hot customer: `123`
- Query Store: capture `ALL`, interval 1 minute

