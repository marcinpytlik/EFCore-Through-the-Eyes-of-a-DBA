# LAB05 — Covering Index and Key Lookup

## Cel
Zrozumieć, dlaczego `Index Seek` nie zawsze oznacza optymalny plan.

## Czas
30–35 min.

## Przed startem
- LAB04 powinien być zakończony.
- Indeks `IX_Orders_CustomerId` powinien istnieć w prostej wersji bez `INCLUDE`.
- Włącz Actual Execution Plan oraz `STATISTICS IO` w VS Code.

## Kroki
1. Pozostaw indeks `IX_Orders_CustomerId`.
2. Uruchom:
```sql
SET STATISTICS IO ON;

SELECT OrderId, OrderDate, Status, TotalAmount
FROM dbo.Orders
WHERE CustomerId = 123
ORDER BY OrderDate DESC;
```
3. Obejrzyj plan i poszukaj `Key Lookup`. Zapisz liczbę actual rows i logical reads.
4. Zmień indeks:
```sql
DROP INDEX IF EXISTS IX_Orders_CustomerId ON dbo.Orders;

CREATE INDEX IX_Orders_CustomerId
ON dbo.Orders(CustomerId)
INCLUDE(OrderDate, Status, TotalAmount);
```
5. Powtórz pomiar tym samym zapytaniem.

Customer 123 ma dużo wierszy — Key Lookup powinien być dobrze widoczny w actual rows i reads.

## Co zapisać
- czy Key Lookup występuje BEFORE,
- logical reads BEFORE i AFTER,
- czy lookup znika po dodaniu `INCLUDE`,
- kolumny `INCLUDE`,
- korzyść i koszt szerszego indeksu.

## Kryterium zakończenia
Potrafisz wyjaśnić, dlaczego Seek może prowadzić do dodatkowych lookupów oraz kiedy covering index usuwa tę pracę.

## Gdy wynik jest inny
- Nie widzisz Key Lookup: sprawdź, czy indeks nie jest już coveringiem po wcześniejszej próbie.
- Plan wybiera inną strategię: zapisz rzeczywisty plan i uzasadnij go na podstawie liczby wierszy i kosztu.
- Po utworzeniu indeksu plan się nie zmienia: upewnij się, że wykonujesz dokładnie to samo zapytanie.

## Pytania
- Co oznacza covering index?
- Jaki jest koszt szerokich indeksów?
- Dlaczego `INCLUDE` nie powinno być automatyczną odpowiedzią na każdy Key Lookup?

## Arkusz
Wypełnij [../worksheets/LAB05_WORKSHEET.md](../worksheets/LAB05_WORKSHEET.md).
