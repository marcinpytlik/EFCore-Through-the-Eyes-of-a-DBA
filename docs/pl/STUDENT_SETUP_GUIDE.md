# Przewodnik setupu dla studenta

## Wymagania
- Docker Desktop / Docker Engine
- .NET 10 SDK
- Visual Studio Code, Visual Studio lub Rider
- SSMS lub inny klient SQL z obsługą execution plan
- Opcjonalnie: PowerShell 7 (`pwsh`) na macOS/Linux, jeśli wolisz skrypty `.ps1`

## 1. Uruchom SQL Server
```bash
docker compose up -d --wait
```
SQL Server: `localhost,14333`  
Login: `sa`  
Hasło: `LabPassword!2026`  
Baza: `EfCoreDbaLab`

## 2. Zbuduj bazę
Windows:

```powershell
.\Setup-Lab.ps1
```

macOS / Linux:

```bash
./Setup-Lab.sh
```

## 3. Uruchom API
```bash
cd src/Workshop.Api
dotnet restore
dotnet run
```
Otwórz `http://localhost:5000/swagger` lub `src/Workshop.Api/Workshop.Api.http`.

## 3a. Jak otworzyć narzędzia (zrób to raz na starcie dnia)

**Połączenie SQL** — w VS Code (rozszerzenie MSSQL) albo SSMS:

```text
Server: localhost,14333
Database: EfCoreDbaLab
Login: sa
Password: LabPassword!2026
```

**Actual execution plan** — w edytorze SQL włącz Include Actual Execution Plan (albo Explain / actual plan), potem uruchom zapytanie. Logical reads są na zakładce Messages po `SET STATISTICS IO, TIME ON`.

**Log EF Core** — SQL jest w **konsoli**, w której działa `dotnet run`. Szukaj `Microsoft.EntityFrameworkCore.Database.Command`. To nie jest log Dockera.

**Dwa requesty naraz** (blocking, isolation, deadlock) — otwórz `src/Workshop.Api/Workshop.Api.http` (REST Client). Swagger łatwo spóźnia drugi request. Wyślij drugi, zanim skończy się okno 30 s (LAB07 / LAB08) albo prawie razem z pierwszym (LAB09).

## 4. Weryfikacja
Wywołaj `GET /`, a następnie `GET /workshop1/customers-bad`.  
Nie zaczynaj od endpointów `*-good` — te służą do porównania dopiero po zebraniu dowodów.

## 5. Reset w razie potrzeby
```bash
./Reset-Lab.sh
```

```powershell
.\Reset-Lab.ps1
```
