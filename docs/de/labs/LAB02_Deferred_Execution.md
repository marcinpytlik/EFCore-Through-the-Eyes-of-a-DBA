# LAB02 — Deferred Execution

## Ziel
Den Unterschied zwischen dem Zusammensetzen einer LINQ-Query und ihrer Materialisierung sehen — **ohne Code zu ändern**.

## Zeit
25–30 min.

## Vor dem Start
- LAB01 sollte abgeschlossen sein.
- Die API muss laufen und der `dotnet run`-Log sichtbar sein.
- `Workshop1Endpoints.cs` und `Workshop.Api.http` öffnen.

## Schritte
1. `GET /workshop1/deferred/City%201` aufrufen.
2. SQL im API-Log finden. Es sollte den `City`-Filter und `TOP (50)`, aber kein `CustomerId > …` enthalten.
3. In `Workshop1Endpoints.cs` markieren, welche Zeilen `IQueryable` zusammensetzen und welche Zeile materialisiert (`ToListAsync`).
4. `GET /workshop1/deferred/City%201?minId=1000` aufrufen.
5. SQL vergleichen. Das zusätzliche Prädikat sollte Teil desselben finalen Statements sein.
6. Prüfen, dass beide Varianten 50 Zeilen liefern, und die ersten IDs notieren.
7. Optional: per Breakpoint bestätigen, dass vor `ToListAsync()` kein Round-Trip stattfindet.

## Was notieren?
- SQL ohne `minId`,
- SQL mit `minId=1000`,
- erste IDs beider Ergebnisse,
- Materialisierungsmethode,
- ob das zusätzliche Prädikat im selben Round-Trip enthalten ist.

## Erwartetes Ergebnis
`Where()` baut den Expression Tree auf; die Ausführung erfolgt bei der Materialisierung. Ein vorher hinzugefügtes Prädikat landet im selben SQL-Statement.

## Abschlusskriterium
Sie können Query-Komposition und Ausführung erklären und mit zwei erzeugten SQL-Statements belegen.

## Wenn das Ergebnis anders ist
- Kein Unterschied im SQL: prüfen, ob die zweite URL `?minId=1000` enthält.
- Kein SQL im Log: Request erneut senden und `dotnet run` prüfen.
- Weniger als 50 Zeilen: sicherstellen, dass die aktuelle Setup-Version verwendet wurde.

## Fragen
- Warum ist Deferred Execution wichtig?
- Verursacht jede LINQ-Methode einen Round-Trip?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB02_WORKSHEET.md](../worksheets/LAB02_WORKSHEET.md).
