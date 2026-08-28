# Troubleshooting Guide

## Container does not start
```powershell
docker ps -a
docker logs efcore-dba-sql
```
Check Docker, memory and port 14333.

## Port 14333 is busy
```powershell
Get-NetTCPConnection -LocalPort 14333 -ErrorAction SilentlyContinue
```
Change the host port in `docker-compose.yml` and the API connection string together.

## Setup-Lab cannot connect
SQL Server may still be starting. Check `docker logs efcore-dba-sql`, wait and retry.

## dotnet restore fails
```powershell
dotnet --info
```
Verify .NET 10 SDK. If packages are unavailable offline, switch to the instructor fallback.

## API cannot connect
Verify `appsettings.json` and manually test `localhost,14333` in SSMS.

## Swagger does not open
Use the URL printed by `dotnet run`; do not assume port 5000.

## Query Store is empty
```sql
SELECT actual_state_desc
FROM sys.database_query_store_options;
```
Generate workload, wait briefly and refresh Query Store reports.

## Blocking demo finishes too quickly
Start the second request immediately after the first.

## Deadlock does not occur
Start both sessions closer together or increase the `WAITFOR` delay.

## Key Lookup does not appear
Verify the simple index is present, the covering index is absent and the query requests non-index columns. Plans may legitimately vary.

## Timings differ
Expected. Prefer plan shape, logical reads, estimates, waits and Query Store evidence over fixed milliseconds.
