# LAB12 — Final Challenge: Developer Meets DBA

## Cel
Połączyć wszystkie elementy warsztatu w jedną analizę problemu.

## Czas
20 min w agendzie 8h (skondensowany capstone). Instruktor może wydłużyć, jeśli grupa pracuje szybciej.

## Przed startem
- LAB01–LAB11 powinny być zakończone albo przynajmniej omówione.
- Przygotuj własne worksheets i evidence z wcześniejszych labów.
- Nie zaczynaj od kodu — zacznij od objawów i danych z SQL Servera.

## Scenariusz
> API działa funkcjonalnie poprawnie, ale pod obciążeniem rośnie czas odpowiedzi i występują timeouty.

## Zadania
### Aplikacja
Przejrzyj:
- `/workshop1/customers-bad`
- `/workshop2/orders/customer/{id}`
- `/workshop2/customers/search-bad/{name}`
- `/workshop3/blocking/{id}`
- `/workshop3/deadlock/session-a` + `session-b`
- `/workshop4/customer/{id}/orders-bad`
- `/workshop4/customer/{id}/orders-nplus1`

### SQL Server
Sprawdź:
- execution plans,
- Query Store,
- logical reads,
- waits,
- blocking,
- locks,
- indeksy.

### Klasyfikacja
Każdy problem oznacz jako Application / Database / Both.

### Priorytet
Nadaj Impact i Effort: Low / Medium / High.

### Raport
| Problem | Evidence | Layer | Fix | Priority |
|---|---|---|---|---|
| Over-fetching |  |  |  |  |
| Missing index |  |  |  |  |
| Non-SARGable predicate |  |  |  |  |
| Long transaction |  |  |  |  |
| N+1 |  |  |  |  |

## Co zapisać
- co najmniej pięć problemów lub obserwacji,
- evidence dla każdego wniosku,
- klasyfikację Application / Database / Both,
- Impact i Effort,
- proponowany fix i sposób walidacji.

## Kryterium zakończenia
Potrafisz przedstawić krótką diagnozę, w której każda rekomendacja ma dowód oraz przypisaną warstwę odpowiedzialności i priorytet.

## Gdy wynik jest inny
- Nie możesz odtworzyć któregoś problemu: użyj evidence zebranego wcześniej zamiast tracić cały czas capstone na ponowne odtwarzanie.
- Nie zgadzacie się co do warstwy: uzasadnij klasyfikację evidence; nie każda odpowiedź musi być wyłącznie Application albo wyłącznie Database.
- Brakuje czasu: priorytetyzuj problemy High Impact i Low/Medium Effort.

## Pytanie końcowe
**What really reaches SQL Server?**

Oczekiwany sens:
SQL Server widzi SQL, parametry, execution pattern i zachowanie transakcyjne wygenerowane przez aplikację — nie intencję zapisaną w C#.

## Arkusz
Wypełnij [../worksheets/LAB12_WORKSHEET.md](../worksheets/LAB12_WORKSHEET.md).
