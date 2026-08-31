# Setup-Leitfaden für Teilnehmer

## Voraussetzungen
- Docker Desktop / Docker Engine
- .NET 10 SDK
- Visual Studio Code, Visual Studio oder Rider
- SSMS oder ein anderer SQL-Client mit Unterstützung für Execution Plans
- Optional: PowerShell 7 (`pwsh`) unter macOS/Linux, wenn Sie die `.ps1`-Skripte bevorzugen

## 1. SQL Server starten
```bash
docker compose up -d --wait
```
SQL Server: `localhost,14333`  
Login: `sa`  
Passwort: `LabPassword!2026`  
Datenbank: `EfCoreDbaLab`

## 2. Datenbank aufbauen
Windows:

```powershell
.\Setup-Lab.ps1
```

macOS / Linux:

```bash
./Setup-Lab.sh
```

## 3. API starten
```bash
cd src/Workshop.Api
dotnet restore
dotnet run
```
Öffnen Sie `http://localhost:5000/swagger` oder `src/Workshop.Api/Workshop.Api.http`.

## 3a. Werkzeuge öffnen (einmal am Tagesbeginn)

**SQL-Verbindung** — in VS Code (MSSQL-Erweiterung) oder SSMS:

```text
Server: localhost,14333
Database: EfCoreDbaLab
Login: sa
Password: LabPassword!2026
```

**Actual Execution Plan** — im SQL-Editor Include Actual Execution Plan (oder Explain / Actual Plan) einschalten, dann die Abfrage ausführen. Logical Reads stehen nach `SET STATISTICS IO, TIME ON` auf der Registerkarte Messages.

**EF-Core-Log** — das SQL steht in der **Konsole**, in der `dotnet run` läuft. Suchen Sie nach `Microsoft.EntityFrameworkCore.Database.Command`. Das ist nicht das Docker-Log.

**Zwei Requests gleichzeitig** (Blocking, Isolation, Deadlock) — öffnen Sie `src/Workshop.Api/Workshop.Api.http` (REST Client). In Swagger kommt der zweite Request oft zu spät. Senden Sie den zweiten, bevor das 30-s-Fenster endet (LAB07 / LAB08), oder fast zusammen mit dem ersten (LAB09).

## 4. Prüfen
Rufen Sie `GET /` und anschließend `GET /workshop1/customers-bad` auf.  
Beginnen Sie nicht mit den `*-good`-Endpoints — die dienen dem Vergleich, nachdem Sie Nachweise gesammelt haben.

## 5. Bei Bedarf zurücksetzen
```bash
./Reset-Lab.sh
```

```powershell
.\Reset-Lab.ps1
```
