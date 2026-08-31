# LAB11 — Incident Investigation: The Endpoint Is Slow

## Ziel
Eine vollständige Diagnose durchführen, ohne mit dem C#-Code zu beginnen.

## Zeit
45–50 min.

## Vor dem Start
- LAB10 sollte abgeschlossen sein.
- API und Query Store müssen funktionieren.
- `sql/05_Diagnostics.sql`, Actual Execution Plan und den `dotnet run`-Log vorbereiten.

## Meldung
> Users report that `/workshop4/customer/123/orders-bad` is slow and sometimes times out.

Customer **123** ist absichtlich hot: viele Orders, breite `Notes` und OrderLines. Query shape und Logical Reads vergleichen, nicht nur einen einzelnen Zeitwert.

## Aufgaben
Zuerst SQL Server:
1. Query im Query Store anhand der SQL-Form finden, nicht anhand einer festen `query_id`.
2. Execution Count, Logical Reads, CPU und Duration prüfen.
3. Actual Plan öffnen und Tabellen sowie Scan/Seek/Lookup-Operatoren identifizieren.
4. Breite des zurückgegebenen Graphen bewerten (`Customers` × `Orders` × `OrderLines`, inklusive `Notes`).
5. `GET /workshop4/customer/123/orders-nplus1` aufrufen und `Database.Command`-Zeilen in der `dotnet run`-Konsole zählen.
6. Erst danach den C#-Include-Graph ansehen.
7. Mit `GET /workshop4/customer/123/orders-good` vergleichen; der Endpoint ist absichtlich in Swagger verborgen, daher manuelle URL oder `Workshop.Api.http` verwenden.

## Was notieren?
- Symptom,
- Query-Store-Evidence,
- Plan und Logical Reads,
- N+1-Round-Trip-Count,
- Root cause,
- vorgeschlagenen Fix,
- Validierungsmethode.

## Bericht
1. Symptom.
2. Evidence.
3. Root cause.
4. Fix.
5. Wie die Verbesserung bestätigt wurde.

## Abschlusskriterium
Sie können von der Incident-Meldung zu einem konkreten SQL-/Workload-Pattern gelangen und den Fix mit Evidence statt Intuition begründen.

## Wenn das Ergebnis anders ist
- Erwarteter Query-Store-Eintrag fehlt: Workload erneut erzeugen und anhand der SQL-Form identifizieren.
- `orders-good` fehlt in Swagger: das ist absichtlich so.
- Round-Trip-Count ist anders: nur `Database.Command`-Einträge eines einzelnen N+1-Requests zählen.

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB11_WORKSHEET.md](../worksheets/LAB11_WORKSHEET.md).
