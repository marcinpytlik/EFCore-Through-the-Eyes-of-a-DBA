# LAB04 — Missing Index: Scan vs Seek

## Ziel
Eine Planänderung nach dem Hinzufügen eines Index sehen, ohne den C#-Code zu ändern.

## Zeit
40 min.

## Vor dem Start
- Workshop 1 sollte abgeschlossen sein.
- Im Workshop-2-Baseline-Zustand darf `IX_Orders_CustomerId` noch nicht existieren.
- VS Code mit aktiviertem Actual Execution Plan vorbereiten.

## Schritte
1. Baseline beibehalten und `GET /workshop2/orders/customer/123` aufrufen.
2. In VS Code die äquivalente Query mit `SET STATISTICS IO ON;` und `SET STATISTICS TIME ON;` ausführen.
3. Operator, Logical Reads, CPU, Elapsed Time, Estimated Rows und Actual Rows notieren.
4. Index anlegen:
```sql
CREATE INDEX IX_Orders_CustomerId
ON dbo.Orders(CustomerId);
```
5. Dieselbe Query erneut ausführen und Plan sowie Messwerte vergleichen.

Customer 123 hat absichtlich viele Orders. Ein Seek kann weiterhin viele Zeilen lesen, muss aber nicht mehr die ganze Tabelle scannen.

## Was notieren?
- BEFORE- und AFTER-Operator,
- Logical Reads BEFORE und AFTER,
- Estimated vs Actual Rows,
- CPU/Elapsed als Zusatzwerte,
- Name des hinzugefügten Index.

## Abschlusskriterium
Sie können zwei Pläne derselben Query zeigen und erklären, warum der Index den Access Path ändert.

## Wenn das Ergebnis anders ist
- Schon vor dem Index ein Seek: `IX_Orders_CustomerId` existiert wahrscheinlich aus einem früheren Lauf; Lab-Zustand zurücksetzen.
- Kein Plan sichtbar: Actual Execution Plan vor der Ausführung aktivieren.
- Zeiten schwanken: Schlussfolgerung auf Operator und Logical Reads stützen.

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB04_WORKSHEET.md](../worksheets/LAB04_WORKSHEET.md).
