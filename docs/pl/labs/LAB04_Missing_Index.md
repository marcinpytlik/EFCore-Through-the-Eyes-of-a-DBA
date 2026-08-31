# LAB04 — Missing Index: Scan vs Seek

## Cel
Zobaczyć zmianę planu po dodaniu indeksu bez zmiany kodu C#.

## Czas
40 min.

## Przed startem
- Workshop 1 powinien być zakończony.
- Baza powinna być w stanie bazowym Workshop 2: bez indeksu `IX_Orders_CustomerId`.
- Przygotuj połączenie SQL w VS Code z włączonym Actual Execution Plan.

## Kroki
1. Nie dodawaj jeszcze indeksów z Workshop 2 — zmierz stan *before*.
2. Wywołaj `GET /workshop2/orders/customer/123`.
3. W VS Code uruchom:
```sql
USE EfCoreDbaLab;
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT OrderId, CustomerId, OrderDate, Status, TotalAmount, Notes
FROM dbo.Orders
WHERE CustomerId = 123
ORDER BY OrderDate DESC;
```
4. W edytorze SQL włącz **Include Actual Execution Plan**, uruchom zapytanie i zapisz operator, reads, CPU, elapsed, estimated rows i actual rows. Reads są na zakładce Messages.
5. Dodaj:
```sql
CREATE INDEX IX_Orders_CustomerId
ON dbo.Orders(CustomerId);
```
6. Powtórz pomiar tym samym zapytaniem.

Customer 123 ma celowo dużo zamówień — Seek nadal czyta wiele wierszy, ale **nie skanuje całej tabeli**.

Nie używaj jednej wartości czasu w ms jako warunku PASS. Najważniejsze są operator dostępu, logical reads i kształt planu.

## Co zapisać
- operator BEFORE i AFTER,
- logical reads BEFORE i AFTER,
- estimated rows i actual rows,
- CPU/elapsed jako dane pomocnicze,
- nazwę dodanego indeksu.

## Wniosek
Kod C# pozostał ten sam — zmieniła się struktura dostępu w bazie.

## Kryterium zakończenia
Potrafisz pokazać dwa plany dla tego samego zapytania i wyjaśnić, dlaczego po dodaniu indeksu SQL Server może użyć Seek.

## Gdy wynik jest inny
- Już widzisz Seek przed krokiem 5: sprawdź, czy `IX_Orders_CustomerId` nie pozostał po wcześniejszym labie; w razie potrzeby zresetuj środowisko.
- Plan nie jest widoczny: upewnij się, że włączyłeś Actual Execution Plan przed wykonaniem zapytania.
- Czasy są niestabilne: oprzyj wniosek na operatorze i logical reads.

## Arkusz
Wypełnij [../worksheets/LAB04_WORKSHEET.md](../worksheets/LAB04_WORKSHEET.md).
