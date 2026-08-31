# LAB05 — Covering Index and Key Lookup

## Ziel
Verstehen, warum `Index Seek` nicht automatisch einen optimalen Plan bedeutet.

## Zeit
30–35 min.

## Vor dem Start
- LAB04 sollte abgeschlossen sein.
- `IX_Orders_CustomerId` sollte in der einfachen Variante ohne `INCLUDE` existieren.
- Actual Execution Plan und `STATISTICS IO` in VS Code aktivieren.

## Schritte
1. Den einfachen Index `IX_Orders_CustomerId` beibehalten.
2. Die Order-Query für Customer 123 ausführen und im Plan nach `Key Lookup` suchen.
3. Actual Rows und Logical Reads notieren.
4. Den Index durch eine Covering-Variante mit `INCLUDE(OrderDate, Status, TotalAmount)` ersetzen.
5. Dieselbe Query erneut ausführen und vergleichen.

## Was notieren?
- ob BEFORE ein Key Lookup vorhanden ist,
- Logical Reads BEFORE und AFTER,
- ob der Lookup nach `INCLUDE` verschwindet,
- `INCLUDE`-Spalten,
- Nutzen sowie Write-/Storage-Kosten.

## Abschlusskriterium
Sie können erklären, warum ein Seek wiederholte Lookups auslösen kann und wann ein Covering Index diese Arbeit entfernt.

## Wenn das Ergebnis anders ist
- Kein Key Lookup: prüfen, ob der Index bereits aus einem früheren Lauf covering ist.
- Optimizer wählt eine andere Strategie: Actual Plan sichern und mit Zeilenanzahl und Kosten erklären.
- Plan ändert sich nicht: sicherstellen, dass nach dem Index-Neuaufbau dieselbe Query ausgeführt wurde.

## Fragen
- Was ist ein Covering Index?
- Was kosten breitere Indizes?
- Warum ist `INCLUDE` nicht die automatische Antwort auf jeden Key Lookup?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB05_WORKSHEET.md](../worksheets/LAB05_WORKSHEET.md).
