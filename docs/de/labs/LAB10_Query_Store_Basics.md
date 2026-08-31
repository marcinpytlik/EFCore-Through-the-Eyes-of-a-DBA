# LAB10 — Query Store Basics

## Ziel
Anwendungsabfragen im Query Store finden und sie mit einer konkreten EF-Core-Last verbinden.

## Zeit
35 min.

## Vor dem Start
- API und Datenbank müssen laufen.
- Query Store sollte `READ_WRITE` mit `QUERY_CAPTURE_MODE = ALL` sein.
- VS Code, `sql/05_Diagnostics.sql` und den `dotnet run`-Log vorbereiten.

## Schritte
1. Aufrufen:
   - `GET /workshop4/customer/123/orders-bad`
   - `GET /workshop4/customer/123/orders-nplus1`
   - `GET /workshop2/orders/customer/123`
2. Die gesamte Datei `sql/05_Diagnostics.sql` ausführen. Das **dritte** Resultset ist Query Store. Nach Erzeugen der Last bis zu 1 Minute warten und aktualisieren.
3. Abfragen zu `Customers`, `Orders` und `OrderLines` finden.
4. `query_id`, `count_executions`, avg duration, avg CPU, avg logical reads und SQL shape notieren.
5. Eine breite Graph-Query von wiederholten `COUNT(*) FROM OrderLines`-Statements unterscheiden.
6. Alte Workshop-3-Einträge anhand der SQL-Form erkennen und nicht automatisch W4 zuordnen.

`query_id` kann sich nach einem Neuaufbau ändern. Szenarien anhand von `query_sql_text`, `count_executions` und SQL shape identifizieren.

## Was notieren?
- SQL shape der wichtigsten Einträge,
- Execution Count, Duration, CPU und Logical Reads,
- welche Zeilen zum breiten Graph und welche zu N+1 gehören,
- welche Zeilen aus älterer Last stammen können.

## Erwartetes Ergebnis
Sie können von „die Anwendung ist langsam“ zu einem konkreten SQL-Statement, Execution Count und messbarer Query-Store-Evidence gelangen.

## Abschlusskriterium
Sie können den Workload identifizieren, ohne sich auf eine feste `query_id` zu verlassen.

## Wenn das Ergebnis anders ist
- Query Store ist leer: Last erneut erzeugen, bis zu 1 Minute warten und aktualisieren.
- Alte lange Einträge dominieren: anhand der SQL-Form identifizieren.
- N+1 ist nicht sichtbar: `orders-nplus1` erneut aufrufen und Execution Counts vergleichen.

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB10_WORKSHEET.md](../worksheets/LAB10_WORKSHEET.md).
