# LAB03 — Over-fetching vs Projection

## Ziel
Das Laden vollständiger Entities mit einer Projektion nur der tatsächlich benötigten Daten vergleichen.

## Zeit
35–40 min.

## Vor dem Start
- API und Datenbank müssen laufen.
- `Workshop.Api.http` oder Swagger, `dotnet run`-Log und SQL-Verbindung in VS Code vorbereiten.
- Vor der ersten Messung keinen Endpoint-Code ändern.

## Schritte
1. `GET /workshop1/customers-bad` aufrufen.
2. Anzahl Tabellen/JOINs, SELECT-Breite und Größe der HTTP-Antwort notieren.
3. `GET /workshop1/customers-good` aufrufen.
4. Generiertes SQL und Response-Form vergleichen.
5. In VS Code für äquivalente SQL-Abfragen `SET STATISTICS IO ON;` und `SET STATISTICS TIME ON;` verwenden.
6. Logical Reads, CPU, Elapsed Time und Payload vergleichen. Eine Payload-Reduktion muss nicht zu derselben Reduktion der Logical Reads führen.
7. `City` zur guten Projektion hinzufügen, ohne den vollständigen Entity-Graph zu laden.

Dieses Lab hängt nicht von Hot Customer 123 ab — der Endpoint nimmt die ersten 100 Kunden. Ziel ist der Vergleich zwischen breitem Graph und Projektion.

## Was notieren?
- BAD- und GOOD-SQL,
- JOIN-Anzahl und ausgewählte Spalten,
- Logical Reads / CPU / Elapsed,
- HTTP-Payload-Größe,
- welche Felder der API-Client tatsächlich benötigt.

## Erwartetes Ergebnis
Eine Projektion reduziert übertragene Daten und Materialisierungskosten, auch wenn die I/O-Reduktion auf SQL-Server-Seite nicht proportional ist.

## Abschlusskriterium
Sie können zeigen, was aus der Datenform entfernt wurde, und den Unterschied mit mindestens zwei Arten von Evidence belegen: SQL/Plan/I/O und Payload.

## Wenn das Ergebnis anders ist
- Zeiten schwanken: SQL shape, Reads und Payload priorisieren.
- Payload ist gleich: prüfen, ob wirklich `customers-bad` und `customers-good` verglichen wurden.
- Projekt kompiliert nach DTO-Änderung nicht: Änderung zurücknehmen und `City` nur in der gewünschten Projektion ergänzen.

## Fragen
- Ist `Include()` immer falsch?
- Wann ist Projection besser?
- Warum kann ein deutlich kleinerer Payload ähnliche Logical Reads haben?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB03_WORKSHEET.md](../worksheets/LAB03_WORKSHEET.md).
