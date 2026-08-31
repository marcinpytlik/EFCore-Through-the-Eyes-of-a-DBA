# LAB10 — Query Store Basics

## Cel
Nauczyć się znajdować zapytania aplikacyjne w Query Store i łączyć je z konkretnym workloadem EF Core.

## Czas
35 min.

## Przed startem
- API i baza muszą działać.
- Query Store powinien być w stanie `READ_WRITE` z `QUERY_CAPTURE_MODE = ALL`.
- Przygotuj VS Code, `sql/05_Diagnostics.sql` i log `dotnet run`.

## Kroki
1. Wywołaj:
   - `GET /workshop4/customer/123/orders-bad`
   - `GET /workshop4/customer/123/orders-nplus1`
   - `GET /workshop2/orders/customer/123`
2. W VS Code uruchom cały `sql/05_Diagnostics.sql`. Plik ma **trzy** batche: requests/blocking, locki, dopiero **trzeci** result set to Query Store (komentarz `-- Query Store: recent resource consumers`). Po wywołaniu endpointów poczekaj do 1 minuty, potem odśwież.
3. W tym trzecim zestawie znajdź zapytania dotyczące `Customers`, `Orders` i `OrderLines`.
4. Zapisz:
   - `query_id`,
   - `count_executions`,
   - avg duration,
   - avg CPU,
   - avg logical reads,
   - SQL shape.
5. Rozpoznaj dwa różne problemy:
   - szeroki graph query dla `orders-bad`,
   - powtarzane `COUNT(*) FROM OrderLines` dla `orders-nplus1`.
6. Jeżeli Query Store zawiera stare długie wpisy po Workshop 3, zidentyfikuj je po SQL shape i nie przypisuj ich automatycznie do W4.

Query Store w tym labie jest ustawiony na `QUERY_CAPTURE_MODE = ALL` i interwał **1 minuta**.

`query_id` może zmienić się po odbudowie bazy. Identyfikuj scenariusz po `query_sql_text`, `count_executions` i kształcie SQL, nie po stałym numerze.

## Co zapisać
- SQL shape dla najważniejszych wpisów,
- `count_executions`, avg duration, avg CPU i avg logical reads,
- które wpisy należą do szerokiego graph query, a które do N+1,
- które wpisy mogą pochodzić ze starszego workloadu.

## Oczekiwany wynik
Student potrafi przejść od „aplikacja jest wolna” do konkretnego SQL, execution count i mierzalnego evidence w Query Store.

## Kryterium zakończenia
Potrafisz rozpoznać workload po SQL shape i execution count bez polegania na stałym `query_id`.

## Gdy wynik jest inny
- Query Store jest pusty: wykonaj workload ponownie, poczekaj do 1 minuty i odśwież.
- Widzisz długie stare wpisy: porównaj SQL shape z endpointami zamiast zakładać, że najdroższy wpis pochodzi z W4.
- Nie widzisz N+1: uruchom `orders-nplus1` ponownie i porównaj execution count podobnych zapytań.

## Arkusz
Wypełnij [../worksheets/LAB10_WORKSHEET.md](../worksheets/LAB10_WORKSHEET.md).
