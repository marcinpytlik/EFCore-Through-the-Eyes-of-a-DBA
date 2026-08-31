# Leitfaden zur Fehlerbehebung

## Container startet nicht
```bash
docker ps -a
docker logs efcore-dba-sql
```
Prüfen Sie Docker, Speicher und Port 14333.

## Port 14333 ist belegt
Windows:
```powershell
Get-NetTCPConnection -LocalPort 14333 -ErrorAction SilentlyContinue
```
macOS / Linux:
```bash
ss -ltnp | grep 14333 || lsof -iTCP:14333 -sTCP:LISTEN
```
Ändern Sie den Host-Port in `docker-compose.yml` und den API-Connection-String gemeinsam.

## Setup-Lab kann keine Verbindung herstellen
SQL Server startet möglicherweise noch. Die Skripte warten auf ein erfolgreiches `SELECT 1`. Prüfen Sie `docker logs efcore-dba-sql` und versuchen Sie es erneut. Sie versuchen nacheinander:

1. `sqlcmd` im SQL-Container (`mssql-tools` / `mssql-tools18`)
2. `sqlcmd` auf dem Host (`localhost,14333`)
3. `mcr.microsoft.com/mssql-tools` im Containernetzwerk

## Healthcheck ist grün, aber Abfragen schlagen fehl
Der Compose-Healthcheck belegt nur, dass TCP 1433 offen ist. Setup wartet danach auf ein echtes `SELECT 1`.

## dotnet restore schlägt fehl
```bash
dotnet --info
```
Prüfen Sie das .NET 10 SDK. Wenn Pakete offline nicht verfügbar sind, wechseln Sie zum Fallback des Trainers.

## API kann keine Verbindung herstellen
Prüfen Sie `appsettings.json` und testen Sie `localhost,14333` manuell in SSMS. Die API lauscht auf `http://localhost:5000`.

## Swagger öffnet sich nicht
Verwenden Sie `http://localhost:5000/swagger`. `/workshop4/.../orders-good` ist in Swagger absichtlich ausgelassen.

## Query Store ist leer
```sql
SELECT actual_state_desc, query_capture_mode_desc, interval_length_minutes
FROM sys.database_query_store_options;
```
Erwarten Sie `ALL` und ein Intervall von 1 Minute. Erzeugen Sie Workload, warten Sie ein Intervall und aktualisieren Sie die Query-Store-Berichte.

## Blocking- / Isolation-Demo endet zu schnell
Starten Sie den zweiten Request unmittelbar nach dem ersten. Beide Holder-Endpoints warten 30 Sekunden.

## Deadlock tritt nicht auf
Starten Sie `session-a` und `session-b` innerhalb von etwa einer Sekunde. Erhöhen Sie die Verzögerung im Endpoint nur, wenn das Raumnetzwerk langsam ist. Der SSMS-Fallback steht in den Lab-Notizen.

## Key Lookup erscheint nicht
Prüfen Sie, dass der einfache Index vorhanden ist, der Covering Index fehlt und die Query Spalten außerhalb des Index anfordert. Customer 123 hat viele Zeilen, daher sollten Lookups deutlich sein. Pläne können trotzdem variieren.

## Incident-Endpoint fühlt sich nicht langsam an
Bevorzugen Sie Planform, logical reads, Payload-Größe und Query-Store-Nachweise gegenüber Wall-Clock-Millisekunden. Customer 123 ist mit zusätzlichen Orders und breiten `Notes` versehen, sodass die Graph-Query auch auf einer schnellen Maschine schwer ist.

## Zeiten weichen ab
Das ist erwartet. Bevorzugen Sie Planform, logical reads, Estimates, Waits und Query-Store-Nachweise gegenüber festen Millisekunden.
