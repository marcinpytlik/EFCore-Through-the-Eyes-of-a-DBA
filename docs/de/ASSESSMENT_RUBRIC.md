# Bewertungsrubrik des Workshops

| Bereich | 0 Pkt. | 1 Pkt. | 2 Pkt. | 3 Pkt. |
|---|---|---|---|---|
| Von EF Core erzeugter SQL | Kann nicht identifizieren | Identifiziert nur SQL | Verbindet LINQ mit SQL | Erklärt Query Shape und Folgen |
| Execution Plans | Kann Operatoren nicht lesen | Erkennt Scan/Seek | Erklärt Lookup/Estimates | Nutzt Plan-Nachweise für die Korrektur |
| Indizierung | Kein nützlicher Vorschlag | Index ohne Nachweis | Sinnvolle Schlüsselwahl | Wägt Covering-Nutzen und Kosten ab |
| Transaktionen / Blocking | Kann Blocker nicht identifizieren | Findet den Blocker | Erklärt die Lifetime | Schlägt eine sichere Korrektur vor |
| Isolation / Deadlocks | Verwechselt Konzepte | Erkennt das Konzept | Erklärt Dirty Read/Zyklus | Prevention + Retry-Strategie |
| Query Store | Kann Query nicht finden | Findet die Query | Liest Metriken | Nutzt ihn zur Validierung der Korrektur |
| Root-Cause-Analyse | Rät | Schwache Erklärung | Nutzt Nachweise | Trennt Application/Database/Both korrekt |
| Validation | Keine | Subjektiv | Eine Metrik | Mehrere unabhängige Nachweis-Punkte |

Maximum: **24 Punkte**

- 21–24: Ausgezeichnet
- 17–20: Sehr gut
- 13–16: Gut
- 9–12: Grundlegend bestanden
- 0–8: Weitere Übung nötig
