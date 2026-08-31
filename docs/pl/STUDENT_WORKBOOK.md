# Zeszyt studenta — EF Core Through the Eyes of a DBA

Zapisz pomiary i wnioski ze wszystkich 12 labów.

Ten plik jest generowany z `docs/pl/worksheets/`. Edytuj arkusze poszczególnych labów, potem uruchom `./scripts/Build-StudentWorkbook.sh` albo `./scripts/Build-StudentWorkbook.ps1`.

> Preferuj kształt planu, logical reads, szacunki wierszy, waits i dowody z Query Store zamiast sztywnych progów milisekund.

---

# LAB01 Worksheet — From HTTP Request to SQL Server

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Testowany endpoint |  |
| Przechwycony wygenerowany SQL |  |
| Tabela główna |  |
| Zaobserwowane JOIN |  |
| Wybrane kolumny |  |
| Metoda materializacji |  |
| Co dociera do SQL Server? |  |

## Tabela dowodów

| Obserwacja | Dowód | Wniosek |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB02 Worksheet — Deferred Execution

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Czy SQL został wykonany podczas kompozycji zapytania? |  |
| Metoda materializacji |  |
| Czy SQL został wykonany przy materializacji? |  |
| SQL bez `minId` |  |
| SQL z `?minId=1000` |  |
| Pierwsze ID bez `minId` |  |
| Pierwsze ID z `minId=1000` |  |
| Dodatkowy predykat w tym samym round-trip? |  |

## Tabela dowodów

| Etap | Obserwacja | Dowód | Wniosek |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB03 Worksheet — Over-fetching vs Projection

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Wybrane kolumny BAD |  |
| Wybrane kolumny GOOD |  |
| logical reads BAD |  |
| logical reads GOOD |  |
| elapsed time BAD |  |
| elapsed time GOOD |  |
| Różnica payload |  |

## Tabela dowodów

| Metryka | BAD | GOOD | Interpretacja |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB04 Worksheet — Missing Index: Scan vs Seek

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
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

## Tabela dowodów

| Metryka | Przed | Po | Interpretacja |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB05 Worksheet — Covering Index and Key Lookup

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Key Lookup przed? |  |
| logical reads BEFORE |  |
| logical reads AFTER |  |
| Czy Lookup został usunięty? |  |
| Kolumny INCLUDE |  |
| Korzyść |  |
| Trade-off |  |

## Tabela dowodów

| Metryka | Indeks prosty | Covering index | Interpretacja |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB06 Worksheet — Query Shape and SARGability

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Operator predykatu bezpośredniego |  |
| Operator predykatu z funkcją |  |
| logical reads (predykat bezpośredni) |  |
| logical reads (predykat z funkcją) |  |
| Czy użyto Seek? |  |
| SQL EF `search-bad` |  |
| SQL EF `search-good` |  |
| Wyrażenie non-SARGable |  |
| Proponowany rewrite |  |

## Tabela dowodów

| Forma zapytania | Plan | Reads | Wniosek |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB07 Worksheet — Blocking Caused by Application Transaction

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Blocking session_id |  |
| Blocked session_id |  |
| wait_type |  |
| Lock mode |  |
| Resource type |  |
| Czas trwania transakcji |  |
| Root cause |  |
| Proponowana poprawka |  |

## Tabela dowodów

| Sesja | Status | Wait type | Blocked by | Dowód |
|---|---|---|---|---|
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB08 Worksheet — Isolation Levels

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Zachowanie READ COMMITTED (HTTP) |  |
| Zachowanie READ UNCOMMITTED (HTTP) |  |
| Zaobserwowano dirty read? |  |
| Wartość podczas trwania hold |  |
| Wartość po rollback |  |
| Ryzyko |  |

## Tabela dowodów

| Isolation level | Zaobserwowane zachowanie | Ryzyko / wniosek |
|---|---|---|
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB09 Worksheet — Deadlock

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Deadlock victim (HTTP 409 / sesja) |  |
| Błąd SQL |  |
| Zasób trzymany przez Session A |  |
| Zasób żądany przez Session A |  |
| Zasób trzymany przez Session B |  |
| Zasób żądany przez Session B |  |
| Cykl |  |
| Poprawka zapobiegawcza |  |
| Strategia retry |  |

## Tabela dowodów

| Sesja | Pierwszy zasób | Drugi zasób | Wynik |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB10 Worksheet — Query Store Basics

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| query_id |  |
| Execution count |  |
| Średni duration |  |
| Średnie CPU |  |
| Średnie logical reads |  |
| Tabele główne |  |
| Najdroższe zapytanie |  |
| Dlaczego drogie? |  |

## Tabela dowodów

| query_id | Executions | Duration | CPU | Logical reads | Uwagi |
|---|---|---|---|---|---|
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |
|  |  |  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB11 Worksheet — Incident Investigation

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Symptom |  |
| Dowód z Query Store |  |
| Dowód z planu |  |
| logical reads (`orders-bad`) |  |
| CPU / duration |  |
| Zaobserwowano round-trip N+1? |  |
| Root cause |  |
| Problem Application? |  |
| Problem Database? |  |
| Fix |  |
| Validation |  |

## Tabela dowodów

| Krok | Obserwacja | Dowód | Decyzja |
|---|---|---|---|
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________

---

# LAB12 Worksheet — Final Challenge: Developer Meets DBA

## Student

- Imię i nazwisko: ______________________________
- Data: ______________________________
- Zespół / grupa: ______________________

## Pomiary i obserwacje

| Pozycja | Wynik |
|---|---|
| Problem 1 |  |
| Problem 2 |  |
| Problem 3 |  |
| Finding o największym wpływie (highest-impact) |  |
| Najszybsza poprawa przy niskim wysiłku (low-effort) |  |
| Poprawki Application |  |
| Poprawki Database |  |
| Poprawki cross-layer |  |
| Co naprawdę dociera do SQL Server? |  |

## Tabela dowodów

| Problem | Dowód | Layer | Impact | Effort | Fix | Priority |
|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |

## Przyczyna / interpretacja

______________________________________________________________________________

## Proponowana poprawka

______________________________________________________________________________

## Weryfikacja

Jak wykazałeś, że zmiana poprawiła sytuację?

______________________________________________________________________________

## Wniosek końcowy

______________________________________________________________________________
