# SQL Server — diagnostische Kurzübersicht

## Werkzeuge
- SQL: `localhost,14333` / `EfCoreDbaLab` / `sa` / `LabPassword!2026`
- Plan: Include Actual Execution Plan, dann die Abfrage ausführen
- Reads: Messages nach `SET STATISTICS IO, TIME ON`
- EF-Log: `dotnet run`-Konsole → `Microsoft.EntityFrameworkCore.Database.Command`
- Zwei Requests: `src/Workshop.Api/Workshop.Api.http`, nicht Swagger
- Query Store in `sql/05_Diagnostics.sql`: das **dritte** Resultset (`-- Query Store: recent resource consumers`)

## Aktuelle Requests / Blocking
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

## I/O und Zeit
```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```

## Planoperatoren, auf die Sie achten sollten
- Clustered Index Scan
- Index Scan
- Index Seek
- Key Lookup
- Sort
- Nested Loops
- Hash Match

## Diagnosefragen
1. Welcher SQL hat SQL Server erreicht?
2. Estimated vs actual rows?
3. Welche Zugriffsmethode wurde verwendet?
4. Wie viele logical reads?
5. Ist der Query Shape größer als die API braucht?
6. Ist die Transaktion zu lange offen?
7. Application, Database oder Both?

## Lab-Standards
- API: `http://localhost:5000`
- SQL: `localhost,14333` / `EfCoreDbaLab`
- Hot customer: `123`
- Query Store: Capture `ALL`, Intervall 1 Minute
