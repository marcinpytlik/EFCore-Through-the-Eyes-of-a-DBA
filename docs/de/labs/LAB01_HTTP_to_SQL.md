# LAB01 — From HTTP Request to SQL Server

## Ziel
Den vollständigen Pfad **HTTP request → ASP.NET Core → EF Core → SQL Server** nachvollziehen und das vom ORM erzeugte SQL untersuchen.

## Zeit
35–40 min.

## Vor dem Start
- Docker und API müssen laufen.
- `EfCoreDbaLab` muss durch `Setup-Lab.ps1` / `Setup-Lab.sh` erstellt sein.
- `Workshop.Api.http` oder Swagger und eine SQL-Verbindung in VS Code vorbereiten.

## Schritte
1. `GET /workshop1/customers-bad` aufrufen.
2. In der **`dotnet run`-Konsole** `Microsoft.EntityFrameworkCore.Database.Command` finden.
3. SQL kopieren und Haupttabelle, JOIN, ausgewählte Spalten und TOP markieren.
4. `Workshop1Endpoints.cs` öffnen und `Include` + `Take(100)` finden.
5. Feststellen, was die Query zusammensetzt und was die Ausführung auslöst.
6. In VS Code mit `localhost,14333` / `EfCoreDbaLab` verbinden und das SQL aus dem EF-Core-Log ausführen.

`customers-good` erst in LAB03 vergleichen, sofern die Kursleitung nichts anderes sagt.

## Was notieren?
- Endpoint,
- generiertes SQL,
- Haupttabelle und JOINs,
- ausgewählte Spalten,
- Materialisierungsmethode,
- kurze Antwort: Was erreicht SQL Server tatsächlich?

## Erwartetes Ergebnis
SQL Server sieht weder C# noch LINQ, sondern finales SQL, Parameter und das transaktionale Verhalten der Anwendung.

## Abschlusskriterium
Sie können einen HTTP-Request mit dem erzeugten SQL verbinden und die Stelle im Code zeigen, an der die Query ausgeführt wird.

## Wenn das Ergebnis anders ist
- Kein SQL in der Konsole: prüfen, ob Sie `dotnet run` und nicht den SQL-Container-Log ansehen.
- Endpoint antwortet nicht: `GET /` und Port `5000` prüfen.
- SQL-Verbindung schlägt fehl: Port `14333` und Containerstatus prüfen.

## Fragen
- Führt `Include()` selbst SQL aus?
- Was erreicht SQL Server genau?
- Wie findet man von EF Core erzeugtes SQL?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB01_WORKSHEET.md](../worksheets/LAB01_WORKSHEET.md).
