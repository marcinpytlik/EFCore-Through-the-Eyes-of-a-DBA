# LAB09 — Deadlock

## Ziel
Absichtlich einen Deadlock mit zwei HTTP-Requests erzeugen, Victim und Abhängigkeitszyklus bestimmen und Evidence aus `system_health` sammeln.

## Zeit
35–40 min.

## Vor dem Start
- API und Datenbank müssen laufen.
- Die beiden LAB09-Requests in `Workshop.Api.http` vorbereiten.
- `sql/06_Deadlock_From_System_Health.sql` und `scripts/Convert-DeadlockXdlToHtml.ps1` öffnen.

## Variante A — EF Core (bevorzugt)
Die beiden Requests nahezu gleichzeitig senden:
```text
POST /workshop3/deadlock/session-a?customerId=1&orderId=1
POST /workshop3/deadlock/session-b?customerId=1&orderId=1
```
Session A: `Customers` → `Orders`  
Session B: `Orders` → `Customers`

Eine Antwort sollte HTTP `409` mit SQL-Fehler `1205` sein, die andere sollte committen. Das Victim kann variieren.

## Variante B — manueller T-SQL-Fallback
Zwei SQL-Sessions verwenden, die `Customers` und `Orders` in umgekehrter Reihenfolge aktualisieren und zwischen erstem und zweitem Update kurz warten. Ziel ist derselbe Ressourcenzyklus wie in der API-Variante.

## Aufgaben
1. Victim identifizieren.
2. Den Zyklus `Customers ↔ Orders` zeichnen.
3. Eine feste Zugriffsreihenfolge vorschlagen, z. B. `Customers → Orders`.
4. Retry nach Fehler 1205 besprechen und erklären, warum globales Retry in diesem Demo-Lab nicht aktiviert ist.
5. `sql/06_Deadlock_From_System_Health.sql` in VS Code ausführen und den neuesten `xml_deadlock_report` lesen.
6. XML als `.xdl` speichern und mit `scripts/Convert-DeadlockXdlToHtml.ps1` visualisieren.

## Was notieren?
- Victim-Session,
- HTTP `409` / SQL `1205`,
- erste und zweite Ressource jeder Session,
- Abhängigkeitszyklus,
- Schlussfolgerung aus dem Deadlock Graph,
- Präventions- und Retry-Strategie.

## Abschlusskriterium
Sie können den Deadlock reproduzieren, mit `system_health` belegen, den Zyklus aus dem Graph lesen und eine Präventionsstrategie vorschlagen.

## Wenn das Ergebnis anders ist
- Beide Sessions committen: sie haben sich zeitlich nicht genug überlappt; erneut testen.
- Kein Event sichtbar: kurz warten und die Helper-Query erneut ausführen.
- Eine andere Session ist Victim: das ist gültig; Victim nicht fest codieren.

## Fragen
- Wie unterscheidet sich Deadlock von Blocking?
- Warum wählt SQL Server ein Victim?
- Warum ist ein Deadlock Graph stärkere Evidence als Fehler 1205 allein?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB09_WORKSHEET.md](../worksheets/LAB09_WORKSHEET.md).
