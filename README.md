# EF Core Through the Eyes of a DBA

## What Really Reaches SQL Server

Hands-on workshop exploring the relationship between:

**ASP.NET Core → Entity Framework Core → Microsoft SQL Server**

The workshop focuses on how application code affects generated SQL, execution plans, indexes, query performance, transactions, locking, blocking, deadlocks and Query Store.

## Workshop structure

1. From HTTP Request to SQL Server
2. Execution Plans and Indexes
3. Transactions, Locking and Concurrency
4. Diagnosing a Real EF Core Workload

## Technology

- .NET 10
- ASP.NET Core Web API
- Entity Framework Core 10
- Microsoft SQL Server 2022 Developer
- Query Store

## Quick start

```powershell
docker compose up -d
.\Setup-Lab.ps1
cd .\src\Workshop.Api
dotnet restore
dotnet run
```

SQL Server is exposed on `localhost,14333` and the training database is `EfCoreDbaLab`.

> The password used by the local SQL Server container is intentionally simple and is intended only for this isolated training environment.

## Student materials

Start with:

- `docs/STUDENT_SETUP_GUIDE.md`
- `docs/student/`
- `docs/worksheets/`
- `docs/STUDENT_WORKBOOK.md`
- `docs/DIAGNOSTIC_QUICK_REFERENCE.md`

Instructor solutions and answer keys are intentionally not included in this public repository.
