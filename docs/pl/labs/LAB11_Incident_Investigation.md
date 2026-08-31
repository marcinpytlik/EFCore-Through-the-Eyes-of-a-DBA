# LAB11 — Incident Investigation: The Endpoint Is Slow

## Cel
Przeprowadzić pełną diagnostykę bez rozpoczynania od kodu C#.

## Czas
45–50 min.

## Przed startem
- LAB10 powinien być zakończony.
- API i Query Store muszą działać.
- Przygotuj `sql/05_Diagnostics.sql`, Actual Execution Plan i log `dotnet run`.

## Zgłoszenie
> Users report that `/workshop4/customer/123/orders-bad` is slow and sometimes times out.

Customer **123** jest celowo „gorący”: ma dużo zamówień, szerokie `Notes` i linie. Porównuj **kształt zapytania i logical reads**, nie jedną liczbę milisekund.

## Zadania
Najpierw SQL Server (ten sam trzeci result set co w LAB10, `sql/05_Diagnostics.sql`):
1. Znajdź zapytanie w Query Store po kształcie SQL (`Customers` / `Orders` / `OrderLines` / `Notes`), nie po `query_id`.
2. Sprawdź execution count.
3. Sprawdź logical reads, CPU i duration.
4. Otwórz plan (Include Actual Execution Plan na SQL z Query Store albo na odpowiedniku z logu).
5. Wskaż tabele i operatory Scan/Seek/Lookup.
6. Oceń ilość zwracanych danych (JOIN `Customers` × `Orders` × `OrderLines`, kolumna `Notes`).
7. Dla kontrastu wywołaj `GET /workshop4/customer/123/orders-nplus1` i w konsoli `dotnet run` policz linie `Database.Command` — to są round-tripy.

Dopiero potem otwórz:
```csharp
db.Customers
    .Include(c => c.Orders)
        .ThenInclude(o => o.OrderLines)
    .SingleAsync(c => c.CustomerId == id);
```

Porównaj z `GET /workshop4/customer/123/orders-good` (endpoint jest w API, ale **ukryty w Swaggerze** — wpisz URL ręcznie albo użyj `Workshop.Api.http`).

## Co zapisać
- symptom,
- Query Store evidence,
- plan i logical reads,
- liczbę round-tripów dla N+1,
- root cause,
- proponowany fix,
- sposób potwierdzenia poprawy.

## Raport
1. Objaw.
2. Dowód.
3. Root cause.
4. Fix.
5. Jak potwierdzono poprawę.

## Kryterium zakończenia
Potrafisz dojść od zgłoszenia „endpoint is slow” do konkretnego SQL i workload pattern, a następnie uzasadnić fix na podstawie evidence, nie intuicji.

## Gdy wynik jest inny
- Nie widzisz właściwego wpisu w Query Store: wygeneruj workload ponownie i identyfikuj po SQL shape.
- `orders-good` nie pojawia się w Swaggerze: to celowe; użyj ręcznego URL albo `Workshop.Api.http`.
- Liczba round-tripów jest inna: upewnij się, że liczysz tylko `Database.Command` wygenerowane przez pojedynczy request N+1.

## Arkusz
Wypełnij [../worksheets/LAB11_WORKSHEET.md](../worksheets/LAB11_WORKSHEET.md).
