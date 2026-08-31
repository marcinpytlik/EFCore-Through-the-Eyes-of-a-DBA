# LAB06 — Query Shape and SARGability

## Cel
Pokazać wpływ sposobu zapisu warunku na użycie indeksu — w SQL **i** w EF Core.

## Czas
30–35 min.

## Przed startem
- Workshop 2 powinien być w stanie po LAB05.
- Indeks `IX_Customers_Name` powinien istnieć po `Setup-Lab.ps1` / `Setup-Lab.sh`.
- Przygotuj VS Code z Actual Execution Plan oraz `Workshop.Api.http`.

## Przygotowanie
Indeks `IX_Customers_Name` powinien już istnieć. Zweryfikuj go przed pomiarem; nie twórz duplikatu.

```sql
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID(N'dbo.Customers')
  AND name = N'IX_Customers_Name';
```

## Kroki
1. W VS Code uruchom:
```sql
USE EfCoreDbaLab;
GO
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

DECLARE @name nvarchar(150) = N'Customer 123';

SELECT TOP(20)
    CustomerId,
    City,
    CreatedAt,
    Email,
    Name
FROM dbo.Customers
WHERE Name = @name;
```
2. Porównaj z:
```sql
DECLARE @name nvarchar(150) = N'Customer 123';

SELECT TOP(20)
    CustomerId,
    City,
    CreatedAt,
    Email,
    Name
FROM dbo.Customers
WHERE UPPER(Name) = UPPER(@name);
```
3. Wywołaj odpowiedniki EF Core:
   - `GET /workshop2/customers/search-bad/Customer%20123` — `ToUpper()` po obu stronach,
   - `GET /workshop2/customers/search-good/Customer%20123` — bez funkcji na indeksowanej kolumnie.
4. W VS Code porównaj plany wykonania i `STATISTICS IO/TIME`.
5. Zapisz operator dla `IX_Customers_Name` i logical reads. Porównuj kształt planu (Scan vs Seek) i reads, nie jedną liczbę milisekund.

## Co zapisać
- SQL dla wariantu direct equality i `UPPER()`,
- operator dostępu dla obu wariantów,
- logical reads,
- SQL wygenerowany przez oba endpointy EF Core,
- proponowaną zmianę predykatu.

## Oczekiwany wynik
Poprawny funkcjonalnie LINQ (`ToUpper()`) może wygenerować mniej efektywny SQL. SARGability to kształt predykatu, nie „magia EF”.

## Kryterium zakończenia
Potrafisz połączyć konkretny zapis LINQ z wygenerowanym SQL oraz wyjaśnić różnicę Scan/Seek na podstawie kształtu predykatu.

## Gdy wynik jest inny
- Brak `IX_Customers_Name`: uruchom ponownie setup zamiast tworzyć drugi indeks o innej nazwie.
- Plan różni się od oczekiwanego: sprawdź collation, actual plan i reads; nie wymuszaj wyniku.
- Oba endpointy zwracają ten sam rekord: to poprawne — porównujemy koszt dojścia do wyniku, nie wynik biznesowy.

## Pytania
- Co SQL Server widzi zamiast `c.Name.ToUpper()`?
- Dlaczego funkcja na indeksowanej kolumnie utrudnia Seek?
- Czy collation może wpłynąć na semantykę porównania? Sprawdź środowisko, nie zgaduj.

## Arkusz
Wypełnij [../worksheets/LAB06_WORKSHEET.md](../worksheets/LAB06_WORKSHEET.md).
