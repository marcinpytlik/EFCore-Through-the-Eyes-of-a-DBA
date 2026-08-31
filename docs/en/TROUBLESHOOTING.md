# Troubleshooting Guide

## Container does not start
```bash
docker ps -a
docker logs efcore-dba-sql
```
Check Docker, memory and port 14333.

## Port 14333 is busy
Windows:
```powershell
Get-NetTCPConnection -LocalPort 14333 -ErrorAction SilentlyContinue
```
macOS / Linux:
```bash
ss -ltnp | grep 14333 || lsof -iTCP:14333 -sTCP:LISTEN
```
Change the host port in `docker-compose.yml` and the API connection string together.

## Setup-Lab cannot connect
SQL Server may still be starting. The scripts wait for a successful `SELECT 1`. Check `docker logs efcore-dba-sql` and retry. They try, in order:

1. `sqlcmd` inside the SQL container (`mssql-tools` / `mssql-tools18`)
2. `sqlcmd` on the host (`localhost,14333`)
3. `mcr.microsoft.com/mssql-tools` attached to the container network

## Healthcheck passes but queries fail
The compose healthcheck only proves TCP 1433 is open. Setup waits for a real `SELECT 1` after that.

## dotnet restore fails
```bash
dotnet --info
```
Verify .NET 10 SDK. If packages are unavailable offline, switch to the instructor fallback.

## API cannot connect
Verify `appsettings.json` and manually test `localhost,14333` in SSMS. The API listens on `http://localhost:5000`.

## Swagger does not open
Use `http://localhost:5000/swagger`. `/workshop4/.../orders-good` is intentionally omitted from Swagger.

## Query Store is empty
```sql
SELECT actual_state_desc, query_capture_mode_desc, interval_length_minutes
FROM sys.database_query_store_options;
```
Expect `ALL` and a 1-minute interval. Generate workload, wait one interval and refresh Query Store reports.

## Blocking / isolation demo finishes too quickly
Start the second request immediately after the first. Both holder endpoints wait 30 seconds.

## Deadlock does not occur
Start `session-a` and `session-b` within about one second. Increase the delay in the endpoint only if the room network is slow. SSMS fallback is in the lab notes.

## Key Lookup does not appear
Verify the simple index is present, the covering index is absent and the query requests non-index columns. Customer 123 has many rows, so lookups should be obvious. Plans may still vary.

## Incident endpoint does not feel slow
Prefer plan shape, logical reads, payload size and Query Store evidence over wall-clock milliseconds. Customer 123 is seeded with extra orders and wide `Notes` so the graph query is heavy even when the machine is fast.

## Timings differ
Expected. Prefer plan shape, logical reads, estimates, waits and Query Store evidence over fixed milliseconds.
