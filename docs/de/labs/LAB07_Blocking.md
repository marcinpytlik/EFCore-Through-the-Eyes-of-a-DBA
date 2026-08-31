# LAB07 — Blocking Caused by Application Transaction

## Ziel
Blocking diagnostizieren, das durch eine zu lange offene Transaktion verursacht wird.

## Zeit
40 min.

## Vor dem Start
- API und Datenbank müssen laufen.
- `src/Workshop.Api/Workshop.Api.http` verwenden; beide Requests müssen sich zeitlich überlappen.
- Ein zweites SQL-Fenster in VS Code für Requests- und Lock-Diagnostik öffnen.

## Schritte
1. `POST /workshop3/blocking/1` aufrufen.
2. **Sofort**, innerhalb von 30 s, `POST /workshop3/update/1?status=Completed` aufrufen.
3. Während der zweite Request wartet, `sys.dm_exec_requests` und `sys.dm_tran_locks` in VS Code prüfen.
4. Blocker und geblockte Session identifizieren.
5. `Task.Delay(30s)` innerhalb der Anwendungstransaktion finden.
6. Einen kürzeren Transaktionsumfang vorschlagen.

## Was notieren?
- `session_id` von Blocker und geblockter Session,
- `wait_type` und `blocking_session_id`,
- Lock-Modi und Ressourcentyp,
- Lebensdauer der Transaktion,
- Root cause und vorgeschlagener Fix.

## Abschlusskriterium
Sie können aktives Blocking zeigen, beide Sessions identifizieren und erklären, warum der zweite Request wartet, solange die Anwendungstransaktion offen bleibt.

## Wenn das Ergebnis anders ist
- Zweiter Request kommt sofort zurück: erneut testen und ihn früher starten.
- Kein Wait sichtbar: Diagnostik ausführen, solange der Request noch blockiert ist.
- Timing in Swagger schwierig: die beiden Requests in `Workshop.Api.http` verwenden.

## Fragen
- Ist SQL Server die Ursache oder der Ort, an dem das Problem sichtbar wird?
- Welche Operationen sollte man nicht in einer langen Transaktion halten?
- Warum kann der geblockte Request schon beim SELECT warten?

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB07_WORKSHEET.md](../worksheets/LAB07_WORKSHEET.md).
