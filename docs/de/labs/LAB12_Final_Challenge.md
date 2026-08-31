# LAB12 — Final Challenge: Developer Meets DBA

## Ziel
Alle Elemente des Workshops in einer evidenzbasierten Diagnose zusammenführen.

## Zeit
20 min in der 8-Stunden-Agenda. Die Kursleitung kann verlängern, wenn die Gruppe schneller arbeitet.

## Vor dem Start
- LAB01–LAB11 sollten abgeschlossen oder mindestens besprochen sein.
- Eigene Worksheets und Evidence aus früheren Labs bereithalten.
- Nicht mit dem C#-Code beginnen, sondern mit Symptomen und SQL-Server-Evidence.

## Szenario
> Die API funktioniert fachlich korrekt, aber unter Last steigt die Antwortzeit und es treten Timeouts auf.

## Aufgaben
Relevante Endpoints und SQL-Server-Evidence prüfen: Execution Plans, Query Store, Logical Reads, Waits, Blocking, Locks und Indizes.

Jeden Befund als **Application / Database / Both** klassifizieren und **Impact** sowie **Effort** als Low / Medium / High bewerten.

## Bericht
| Problem | Evidence | Layer | Fix | Priority |
|---|---|---|---|---|
| Over-fetching |  |  |  |  |
| Missing index |  |  |  |  |
| Non-SARGable predicate |  |  |  |  |
| Long transaction |  |  |  |  |
| N+1 |  |  |  |  |

## Was notieren?
- mindestens fünf Befunde,
- Evidence für jede Schlussfolgerung,
- Klassifizierung Application / Database / Both,
- Impact und Effort,
- vorgeschlagenen Fix und Validierungsmethode.

## Abschlusskriterium
Sie können eine kurze Diagnose präsentieren, bei der jede Empfehlung Evidence, eine Ownership-Schicht und eine Priorität hat.

## Wenn das Ergebnis anders ist
- Ein Problem lässt sich nicht mehr reproduzieren: zuvor gesammelte Evidence verwenden, statt das gesamte Capstone für die Reproduktion zu verbrauchen.
- Uneinigkeit über Ownership: Klassifizierung mit Evidence begründen; manche Befunde gehören legitim zu Both.
- Zeit ist knapp: High Impact mit Low/Medium Effort priorisieren.

## Abschlussfrage
**What really reaches SQL Server?**

Erwarteter Sinn: SQL Server sieht SQL, Parameter, Execution Pattern und transaktionales Verhalten der Anwendung — nicht die in C# formulierte Absicht.

## Arbeitsblatt
Ausfüllen: [../worksheets/LAB12_WORKSHEET.md](../worksheets/LAB12_WORKSHEET.md).
