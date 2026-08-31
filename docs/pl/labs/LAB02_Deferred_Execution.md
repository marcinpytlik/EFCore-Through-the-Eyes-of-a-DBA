# LAB02 — Deferred Execution

## Cel
Zobaczyć różnicę między budowaniem zapytania LINQ a jego materializacją — **bez edycji kodu**.

## Czas
25–30 min.

## Przed startem
- LAB01 powinien być zakończony.
- API musi działać, a log `dotnet run` powinien być widoczny.
- Otwórz `Workshop1Endpoints.cs` oraz `Workshop.Api.http`.

## Kroki
1. Wywołaj `GET /workshop1/deferred/City%201`.
2. W logu API znajdź SQL. Powinien zawierać filtr `City` i `TOP (50)`, bez `CustomerId > …`.
3. Otwórz `Workshop1Endpoints.cs` i wskaż:
   - które linie **komponują** `IQueryable`,
   - która linia **materializuje** zapytanie (`ToListAsync`).
4. Wywołaj ten sam endpoint z dodatkowym predykatem **przed** materializacją:
   `GET /workshop1/deferred/City%201?minId=1000`
5. Porównaj SQL: parametr `minId` powinien pojawić się w `WHERE`, bo został dodany do expression tree zanim wykonano zapytanie.
6. Zweryfikuj wynik: oba warianty zwracają po 50 rekordów. Zapisz pierwsze ID z każdego wariantu i porównaj, czy dodatkowy filtr zmienił zbiór.
7. (Opcjonalnie) Ustaw breakpoint na `var query = …` i potwierdź, że do `ToListAsync()` nie ma jeszcze round-tripu.

## Co zapisać
- SQL bez `minId`,
- SQL z `minId=1000`,
- pierwsze ID w obu wynikach,
- metodę materializującą,
- czy dodatkowy predykat trafił do tego samego round-tripu.

## Oczekiwany wynik
`Where()` buduje expression tree; wykonanie następuje przy materializacji. Dodatkowy filtr złożony wcześniej trafia do jednego SQL.

## Kryterium zakończenia
Potrafisz wyjaśnić różnicę między kompozycją `IQueryable` a wykonaniem zapytania i pokazać ją na dwóch wygenerowanych SQL-ach.

## Gdy wynik jest inny
- Nie widzisz różnicy w SQL: upewnij się, że drugi request zawiera `?minId=1000`.
- Nie widzisz SQL w logu: wykonaj request ponownie i sprawdź konsolę `dotnet run`.
- Wynik ma mniej niż 50 rekordów: sprawdź, czy baza została przygotowana przez aktualny `Setup-Lab`.

## Pytania
- Dlaczego deferred execution jest ważne?
- Czy każda metoda LINQ powoduje round-trip?

## Arkusz
Wypełnij [../worksheets/LAB02_WORKSHEET.md](../worksheets/LAB02_WORKSHEET.md).
