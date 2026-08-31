# Szybka ściąga diagnostyczna SQL Server

## Narzędzia
- SQL: `localhost,14333` / `EfCoreDbaLab` / `sa` / `LabPassword!2026`
- Plan: Include Actual Execution Plan, potem uruchom zapytanie
- Reads: Messages po `SET STATISTICS IO, TIME ON`
- Log EF: konsola `dotnet run` → `Microsoft.EntityFrameworkCore.Database.Command`
- Dwa requesty: `src/Workshop.Api/Workshop.Api.http`, nie Swagger
- Query Store w `sql/05_Diagnostics.sql`: **trzeci** result set (`-- Query Store: recent resource consumers`)

## Bieżące requesty / blocking
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

## I/O i czas
```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```

## Operatory planu, na które zwracać uwagę
- Clustered Index Scan
- Index Scan
- Index Seek
- Key Lookup
- Sort
- Nested Loops
- Hash Match

## Pytania diagnostyczne
1. Jaki SQL dotarł do SQL Server?
2. Estimated vs actual rows?
3. Jaka metoda dostępu została użyta?
4. Ile logical reads?
5. Czy query shape jest większy niż potrzebuje API?
6. Czy transakcja jest otwarta zbyt długo?
7. Application, Database, czy Both?

## Domyślne ustawienia labu
- API: `http://localhost:5000`
- SQL: `localhost,14333` / `EfCoreDbaLab`
- Hot customer: `123`
- Query Store: capture `ALL`, interwał 1 minuta
