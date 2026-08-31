# Student Setup Guide

## Requirements
- Docker Desktop / Docker Engine
- .NET 10 SDK
- Visual Studio Code, Visual Studio or Rider
- SSMS or another SQL client with execution-plan support
- Optional: PowerShell 7 (`pwsh`) on macOS/Linux if you prefer the `.ps1` scripts

## 1. Start SQL Server
```bash
docker compose up -d --wait
```
SQL Server: `localhost,14333`  
Login: `sa`  
Password: `LabPassword!2026`  
Database: `EfCoreDbaLab`

## 2. Build the database
Windows:

```powershell
.\Setup-Lab.ps1
```

macOS / Linux:

```bash
./Setup-Lab.sh
```

## 3. Start the API
```bash
cd src/Workshop.Api
dotnet restore
dotnet run
```
Open `http://localhost:5000/swagger` or `src/Workshop.Api/Workshop.Api.http`.

## 3a. How to open the tools (do this once at the start of the day)

**SQL connection** — in VS Code (MSSQL extension) or SSMS:

```text
Server: localhost,14333
Database: EfCoreDbaLab
Login: sa
Password: LabPassword!2026
```

**Actual execution plan** — in the SQL editor turn on Include Actual Execution Plan (or Explain / actual plan), then run the query. Logical reads appear on the Messages tab after `SET STATISTICS IO, TIME ON`.

**EF Core log** — the SQL is in the **console** where `dotnet run` is running. Look for `Microsoft.EntityFrameworkCore.Database.Command`. That is not the Docker log.

**Two requests at once** (blocking, isolation, deadlock) — open `src/Workshop.Api/Workshop.Api.http` (REST Client). Swagger often misses the second request. Send the second one before the 30 s window ends (LAB07 / LAB08), or almost together with the first (LAB09).

## 4. Verify
Call `GET /` and then `GET /workshop1/customers-bad`.  
Do not start with the `*-good` endpoints — those are for comparison after you have evidence.

## 5. Reset when necessary
```bash
./Reset-Lab.sh
```

```powershell
.\Reset-Lab.ps1
```
