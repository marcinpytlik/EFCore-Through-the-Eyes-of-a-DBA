# Przewodnik rozwiązywania problemów

## Kontener się nie uruchamia
```bash
docker ps -a
docker logs efcore-dba-sql
```
Sprawdź Docker, pamięć i port 14333.

## Port 14333 jest zajęty
Windows:
```powershell
Get-NetTCPConnection -LocalPort 14333 -ErrorAction SilentlyContinue
```
macOS / Linux:
```bash
ss -ltnp | grep 14333 || lsof -iTCP:14333 -sTCP:LISTEN
```
Zmień port hosta w `docker-compose.yml` i connection string API razem.

## Setup-Lab nie może się połączyć
SQL Server może być jeszcze w trakcie startu. Skrypty czekają na udane `SELECT 1`. Sprawdź `docker logs efcore-dba-sql` i spróbuj ponownie. Próbują, w tej kolejności:

1. `sqlcmd` wewnątrz kontenera SQL (`mssql-tools` / `mssql-tools18`)
2. `sqlcmd` na hoście (`localhost,14333`)
3. `mcr.microsoft.com/mssql-tools` podłączony do sieci kontenera

## Healthcheck przechodzi, ale zapytania padają
Healthcheck w compose potwierdza tylko, że TCP 1433 jest otwarty. Setup czeka potem na prawdziwe `SELECT 1`.

## dotnet restore kończy się błędem
```bash
dotnet --info
```
Sprawdź .NET 10 SDK. Jeśli pakiety są niedostępne offline, przejdź na wariant awaryjny prowadzącego.

## API nie może się połączyć
Sprawdź `appsettings.json` i ręcznie przetestuj `localhost,14333` w SSMS. API nasłuchuje na `http://localhost:5000`.

## Swagger się nie otwiera
Użyj `http://localhost:5000/swagger`. `/workshop4/.../orders-good` jest celowo pominięty w Swaggerze.

## Query Store jest pusty
```sql
SELECT actual_state_desc, query_capture_mode_desc, interval_length_minutes
FROM sys.database_query_store_options;
```
Oczekuj `ALL` i interwału 1 minuty. Wygeneruj workload, poczekaj jeden interwał i odśwież raporty Query Store.

## Demo blocking / isolation kończy się zbyt szybko
Uruchom drugi request natychmiast po pierwszym. Oba endpointy hold czekają 30 sekund.

## Deadlock nie występuje
Uruchom `session-a` i `session-b` w ciągu około jednej sekundy. Zwiększ opóźnienie w endpoincie tylko wtedy, gdy sieć w sali jest wolna. Wariant SSMS jest w notatkach labu.

## Key Lookup się nie pojawia
Sprawdź, że prosty indeks jest obecny, covering index nie istnieje, a zapytanie żąda kolumn spoza indeksu. Customer 123 ma dużo wierszy, więc lookup powinien być wyraźny. Plany i tak mogą się różnić.

## Endpoint incydentu nie wydaje się wolny
Preferuj kształt planu, logical reads, rozmiar payload i dowody z Query Store zamiast milisekund wall-clock. Customer 123 jest zasilony dodatkowymi zamówieniami i szerokimi `Notes`, więc graph query jest ciężkie nawet na szybkiej maszynie.

## Czasy się różnią
To oczekiwane. Preferuj kształt planu, logical reads, estimates, waits i dowody z Query Store zamiast stałych milisekund.
