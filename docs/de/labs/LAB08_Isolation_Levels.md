# LAB08 — Isolation Levels

## Ziel
Beobachten, wie das Isolation Level gleichzeitige Reads beeinflusst — mit EF-Core-API und manuellem T-SQL.

## Zeit
35 min.

## Vor dem Start
- API und Datenbank müssen laufen.
- Die beiden LAB08-Requests in `Workshop.Api.http` vorbereiten.
- Für den Fallback zwei SQL-Sessions in VS Code oder einem anderen SQL-Client verwenden.

## Variante A — EF Core (bevorzugt)
1. `POST /workshop3/isolation/hold/10` starten und offen lassen.
2. Bevor die 30 Sekunden vorbei sind, `GET /workshop3/isolation/read-committed/10` aufrufen und Verhalten notieren.
3. Hold erneut starten und danach `GET /workshop3/isolation/read-uncommitted/10` aufrufen.
4. Nach dem Rollback `read-committed` erneut aufrufen und den dauerhaften Wert notieren.

## Variante B — manueller T-SQL-Fallback
Zwei SQL-Sessions verwenden. In Session A eine Transaktion öffnen, `OrderId = 10` auf `Status = 'Processing'` setzen und die Transaktion offen lassen. In Session B einen normalen SELECT mit einem Read unter `READ UNCOMMITTED` vergleichen. Am Ende in Session A `ROLLBACK` ausführen.

## Was notieren?
- Verhalten unter READ COMMITTED,
- Verhalten unter READ UNCOMMITTED,
- Wert während der offenen Transaktion,
- Wert nach Rollback,
- ob ein Dirty Read auftrat und warum er riskant ist.

## Abschlusskriterium
Sie können den Unterschied zwischen Warten unter READ COMMITTED und dem Lesen eines nicht bestätigten Werts unter READ UNCOMMITTED demonstrieren.

## Wenn das Ergebnis anders ist
- READ COMMITTED wartet nicht: der Hold ist wahrscheinlich vorbei; schneller wiederholen.
- READ UNCOMMITTED zeigt `Processing` nicht: Read senden, solange der Hold aktiv ist.
- Manueller T-SQL blockiert spätere Arbeit: prüfen, ob Session A `ROLLBACK` ausgeführt hat.

## Diskussion
- Was sah Session B unter READ COMMITTED?
- Was sah sie unter READ UNCOMMITTED?
- Was ist ein Dirty Read?
- Warum ist `NOLOCK` kein universeller Fix für Blocking?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB08_WORKSHEET.md](../worksheets/LAB08_WORKSHEET.md).
