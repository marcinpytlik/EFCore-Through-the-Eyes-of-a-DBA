# LAB08 — Isolation Levels

## Cel
Zobaczyć wpływ poziomu izolacji na równoczesny dostęp — z API EF Core i z ręcznego T-SQL.

## Czas
35 min.

## Przed startem
- API i baza muszą działać.
- Przygotuj dwa requesty LAB08 w `Workshop.Api.http`.
- Do wariantu T-SQL użyj dwóch okien SQL w VS Code lub innym kliencie SQL.

## Wariant A — EF Core (preferowany)
1. Wywołaj i zostaw w locie `POST /workshop3/isolation/hold/10`.
2. Zanim hold skończy 30 s, wywołaj `GET /workshop3/isolation/read-committed/10` i zapisz zachowanie.
3. Ponownie uruchom hold, a następnie wywołaj `GET /workshop3/isolation/read-uncommitted/10`.
4. Po rollbacku wywołaj ponownie `read-committed` i zapisz trwałą wartość.

## Wariant B — ręczny T-SQL (fallback)
Użyj dwóch osobnych sesji SQL. W Session A otwórz transakcję, ustaw `Status = 'Processing'` dla `OrderId = 10` i pozostaw transakcję otwartą. W Session B porównaj zwykły SELECT z odczytem po ustawieniu `READ UNCOMMITTED`. Na końcu wykonaj `ROLLBACK` w Session A.

## Co zapisać
- zachowanie READ COMMITTED,
- zachowanie READ UNCOMMITTED,
- wartość widzianą w czasie otwartej transakcji,
- wartość po rollbacku,
- czy wystąpił dirty read i jakie niesie ryzyko.

## Kryterium zakończenia
Potrafisz pokazać różnicę między oczekiwaniem przy READ COMMITTED a odczytem niezatwierdzonej wartości przy READ UNCOMMITTED i wyjaśnić, dlaczego ta wartość może nigdy nie zostać zatwierdzona.

## Gdy wynik jest inny
- READ COMMITTED nie czeka: hold prawdopodobnie już się skończył; powtórz test szybciej.
- READ UNCOMMITTED nie pokazuje `Processing`: wyślij odczyt, gdy hold nadal trwa.
- Po ręcznym T-SQL nie możesz kontynuować: upewnij się, że Session A wykonała `ROLLBACK`.

## Dyskusja
- Co zobaczyła Session B przy READ COMMITTED?
- Co zobaczyła przy READ UNCOMMITTED?
- Co oznacza dirty read?
- Dlaczego `NOLOCK` nie jest lekarstwem na każdy blocking?

## Arkusz
Wypełnij [../worksheets/LAB08_WORKSHEET.md](../worksheets/LAB08_WORKSHEET.md).
