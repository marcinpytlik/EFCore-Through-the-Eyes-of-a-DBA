# Quick Reference — Student

## Environment

```text
API:      http://localhost:5000
Swagger:  http://localhost:5000/swagger

SQL Server: localhost,14333
Database:   EfCoreDbaLab
Login:      sa
Password:   LabPassword!2026
```

## Start the lab

From the repository root:

```powershell
docker compose up -d --wait
.\Setup-Lab.ps1
cd .\src\Workshop.Api
dotnet restore
dotnet run
```

macOS / Linux:

```bash
docker compose up -d --wait
./Setup-Lab.sh
cd ./src/Workshop.Api
dotnet restore
dotnet run
```

## Where to look

```text
Generated SQL  → API terminal / Microsoft.EntityFrameworkCore.Database.Command
HTTP requests   → Workshop.Api.http or PowerShell
Execution plan  → SQL editor / Actual Execution Plan
Logical reads   → SQL editor / STATISTICS IO
Blocking        → sys.dm_exec_requests + sys.dm_tran_locks
Deadlock        → system_health
Workload history→ Query Store
C# source       → Workshop1/2/3/4Endpoints.cs
```

## SQL measurement switches

```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```

## Current requests

```sql
SELECT
    session_id,
    status,
    command,
    wait_type,
    wait_time,
    blocking_session_id,
    database_id
FROM sys.dm_exec_requests
WHERE database_id = DB_ID(N'EfCoreDbaLab')
ORDER BY session_id;
```

## Locks

```sql
SELECT
    request_session_id,
    resource_type,
    resource_description,
    request_mode,
    request_status,
    request_owner_type
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID(N'EfCoreDbaLab')
ORDER BY request_session_id, resource_type, request_status;
```

## Diagnostic questions

1. What SQL reached SQL Server?
2. How many times did it execute?
3. What access path did the optimizer choose?
4. How many logical reads did it perform?
5. Is the query shape larger than the API needs?
6. Is the transaction open longer than necessary?
7. Is another session blocking it?
8. Is the issue Application / Database / Both?
9. What evidence will prove the fix worked?

## Rule

> Diagnose first. Optimize second.
