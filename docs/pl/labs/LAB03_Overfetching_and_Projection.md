# LAB03 — Over-fetching vs Projection

## Cel
Porównać pobieranie całych encji z projekcją tylko potrzebnych danych.

## Czas
35–40 min.

## Przed startem
- API i baza muszą działać.
- Przygotuj `Workshop.Api.http` lub Swagger, log `dotnet run` i połączenie SQL w VS Code.
- Nie zmieniaj jeszcze kodu endpointów przed pierwszym pomiarem.

## Kroki
1. Wywołaj `GET /workshop1/customers-bad`.
2. Zapisz liczbę tabel/JOIN-ów, szerokość SELECT-a i rozmiar odpowiedzi HTTP.
3. Wywołaj `GET /workshop1/customers-good`.
4. Porównaj wygenerowany SQL i kształt odpowiedzi.
5. W VS Code dla równoważnych zapytań włącz:
```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
```
6. Porównaj logical reads, CPU, elapsed time i payload. Nie oczekuj, że spadek payloadu musi oznaczać taki sam spadek logical reads.
7. Dodaj `City` do dobrej projekcji (`CustomerSummaryDto` albo nowy kształt) bez pobierania pełnej encji.

Ten lab nie zależy od hot customera 123 — endpoint bierze pierwszych 100 klientów. Celem jest porównanie szerokiego grafu z projekcją.

## Co zapisać
- SQL dla BAD i GOOD,
- liczba JOIN-ów i wybranych kolumn,
- logical reads / CPU / elapsed,
- rozmiar odpowiedzi HTTP,
- które dane są naprawdę potrzebne klientowi API.

## Oczekiwany wynik
Projekcja zmniejsza ilość przesyłanych danych i koszt materializacji, nawet jeśli I/O po stronie SQL Servera nie maleje proporcjonalnie.

## Kryterium zakończenia
Potrafisz wskazać, co zostało usunięte z kształtu danych i udowodnić różnicę co najmniej dwoma rodzajami evidence: SQL/plan/I/O oraz payload.

## Gdy wynik jest inny
- Czasy różnią się między uruchomieniami: porównuj przede wszystkim SQL shape, reads i payload.
- Nie widzisz różnicy w payloadzie: upewnij się, że porównujesz `customers-bad` z `customers-good`.
- Po zmianie DTO projekt nie kompiluje się: cofnij zmianę i dodaj `City` tylko do właściwej projekcji.

## Pytania
- Czy `Include()` jest zawsze błędem?
- Kiedy projekcja jest lepsza?
- Dlaczego mniejszy payload nie musi oznaczać proporcjonalnie mniejszego I/O?

## Arkusz
Wypełnij [../worksheets/LAB03_WORKSHEET.md](../worksheets/LAB03_WORKSHEET.md).
