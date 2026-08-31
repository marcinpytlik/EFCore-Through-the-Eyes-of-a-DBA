# Teilnehmer-Workbook — EF Core Through the Eyes of a DBA

Halten Sie Messungen und Schlussfolgerungen für alle 12 Labs fest.

Diese Datei wird aus `docs/de/worksheets/` erzeugt. Bearbeiten Sie die einzelnen Arbeitsblätter und führen Sie danach `./scripts/Build-StudentWorkbook.sh` oder `./scripts/Build-StudentWorkbook.ps1` aus.

> Bevorzugen Sie Planform, Logical Reads, Zeilenschätzungen, Waits und Query-Store-Nachweise gegenüber festen Millisekundenwerten.

---

# LAB01 Worksheet — From HTTP Request to SQL Server

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Getesteter Endpoint |  |
| Erfasster generierter SQL |  |
| Haupttabelle |  |
| Beobachtete JOIN |  |
| Ausgewählte Spalten |  |
| Materialisierungsmethode |  |
| Was erreicht SQL Server? |  |

## Nachweistabelle

| Beobachtung | Nachweis | Schlussfolgerung |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB02 Worksheet — Deferred Execution

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| SQL während der Query-Komposition ausgeführt? |  |
| Materialisierungsmethode |  |
| SQL bei der Materialisierung ausgeführt? |  |
| SQL ohne `minId` |  |
| SQL mit `?minId=1000` |  |
| Erste IDs ohne `minId` |  |
| Erste IDs mit `minId=1000` |  |
| Zusätzliches Prädikat im selben Round-Trip? |  |

## Nachweistabelle

| Phase | Beobachtung | Nachweis | Schlussfolgerung |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB03 Worksheet — Over-fetching vs Projection

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Ausgewählte Spalten BAD |  |
| Ausgewählte Spalten GOOD |  |
| logical reads BAD |  |
| logical reads GOOD |  |
| elapsed time BAD |  |
| elapsed time GOOD |  |
| Payload-Unterschied |  |

## Nachweistabelle

| Metrik | BAD | GOOD | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB04 Worksheet — Missing Index: Scan vs Seek

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Operator BEFORE |  |
| Operator AFTER |  |
| logical reads BEFORE |  |
| logical reads AFTER |  |
| CPU BEFORE |  |
| CPU AFTER |  |
| Elapsed BEFORE |  |
| Elapsed AFTER |  |
| Estimated rows |  |
| Actual rows |  |

## Nachweistabelle

| Metrik | Vorher | Nachher | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB05 Worksheet — Covering Index and Key Lookup

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Key Lookup vorher? |  |
| logical reads BEFORE |  |
| logical reads AFTER |  |
| Lookup entfernt? |  |
| INCLUDE-Spalten |  |
| Nutzen |  |
| Trade-off |  |

## Nachweistabelle

| Metrik | Einfacher Index | Covering Index | Interpretation |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB06 Worksheet — Query Shape and SARGability

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Operator des direkten Prädikats |  |
| Operator des Funktionsprädikats |  |
| logical reads (direkt) |  |
| logical reads (Funktion) |  |
| Seek verwendet? |  |
| EF-SQL `search-bad` |  |
| EF-SQL `search-good` |  |
| Non-SARGable Ausdruck |  |
| Vorgeschlagener Rewrite |  |

## Nachweistabelle

| Query-Form | Plan | Reads | Schlussfolgerung |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB07 Worksheet — Blocking Caused by Application Transaction

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Blocking session_id |  |
| Blocked session_id |  |
| wait_type |  |
| Lock mode |  |
| Resource type |  |
| Transaktionsdauer |  |
| Root cause |  |
| Vorgeschlagene Korrektur |  |

## Nachweistabelle

| Sitzung | Status | Wait type | Blocked by | Nachweis |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB08 Worksheet — Isolation Levels

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Verhalten READ COMMITTED (HTTP) |  |
| Verhalten READ UNCOMMITTED (HTTP) |  |
| Dirty Read beobachtet? |  |
| Wert während hold in flight |  |
| Wert nach Rollback |  |
| Risiko |  |

## Nachweistabelle

| Isolation Level | Beobachtetes Verhalten | Risiko / Schlussfolgerung |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB09 Worksheet — Deadlock

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Deadlock Victim (HTTP 409 / Sitzung) |  |
| SQL-Fehler |  |
| Von Session A gehaltene Ressource |  |
| Von Session A angeforderte Ressource |  |
| Von Session B gehaltene Ressource |  |
| Von Session B angeforderte Ressource |  |
| Zyklus |  |
| Vorbeugende Korrektur |  |
| Retry-Strategie |  |

## Nachweistabelle

| Sitzung | Erste Ressource | Zweite Ressource | Ergebnis |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB10 Worksheet — Query Store Basics

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| query_id |  |
| Execution count |  |
| Avg duration |  |
| Avg CPU |  |
| Avg logical reads |  |
| Haupttabellen |  |
| Teuerste Query |  |
| Warum teuer? |  |

## Nachweistabelle

| query_id | Executions | Duration | CPU | Logical reads | Hinweise |
|---|---|---|---|---|---|
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB11 Worksheet — Incident Investigation

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Symptom |  |
| Query-Store-Nachweis |  |
| Plan-Nachweis |  |
| logical reads (`orders-bad`) |  |
| CPU / duration |  |
| N+1-Round-Trips beobachtet? |  |
| Root cause |  |
| Application-Problem? |  |
| Database-Problem? |  |
| Fix |  |
| Validation |  |

## Nachweistabelle

| Schritt | Beobachtung | Nachweis | Entscheidung |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________

---

# LAB12 Worksheet — Final Challenge: Developer Meets DBA

## Teilnehmer

- Name: ______________________________
- Datum: ______________________________
- Team / Gruppe: ______________________

## Messungen und Beobachtungen

| Punkt | Ergebnis |
|---|---|
| Problem 1 |  |
| Problem 2 |  |
| Problem 3 |  |
| Finding mit dem höchsten Impact |  |
| Schnellste Verbesserung mit geringem Aufwand (low-effort) |  |
| Application-Korrekturen |  |
| Database-Korrekturen |  |
| Cross-Layer-Korrekturen |  |
| Was erreicht SQL Server wirklich? |  |

## Nachweistabelle

| Problem | Nachweis | Layer | Impact | Effort | Fix | Priority |
|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |

## Ursache / Interpretation

______________________________________________________________________________

## Vorgeschlagene Korrektur

______________________________________________________________________________

## Validierung

Wie haben Sie nachgewiesen, dass die Änderung die Situation verbessert hat?

______________________________________________________________________________

## Schlussfolgerung

______________________________________________________________________________
