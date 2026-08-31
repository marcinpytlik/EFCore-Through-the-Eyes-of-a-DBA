# LAB09 — Deadlock

## Cel
Celowo wywołać deadlock z dwóch requestów HTTP, wskazać victim i cykl zależności oraz zebrać dowód z `system_health`.

## Czas
35–40 min.

## Przed startem
- API i baza muszą działać.
- Przygotuj dwa requesty LAB09 w `Workshop.Api.http`.
- Otwórz `sql/06_Deadlock_From_System_Health.sql` oraz `scripts/Convert-DeadlockXdlToHtml.ps1`.

## Wariant A — EF Core (preferowany)
Powtarzalny sposób: w `src/Workshop.Api/Workshop.Api.http` wyślij **session-a** i **session-b** prawie jednocześnie, w ciągu około 1 s.

```text
POST /workshop3/deadlock/session-a?customerId=1&orderId=1
POST /workshop3/deadlock/session-b?customerId=1&orderId=1
```

Session A: `Customers` → `Orders`  
Session B: `Orders` → `Customers`

Jedna odpowiedź powinna być HTTP `409` z `sqlError: 1205`. Druga powinna się zatwierdzić. Victim może być A albo B.

## Wariant B — ręczny T-SQL (fallback)
W dwóch osobnych sesjach SQL wykonaj transakcje, które aktualizują `Customers` i `Orders` w odwrotnej kolejności, z krótkim opóźnieniem między pierwszym a drugim UPDATE. Celem jest odtworzenie tego samego cyklu zasobów co w wariancie API.

## Zadania
1. Zidentyfikuj victim (HTTP 409 / SQL 1205).
2. Narysuj cykl zależności `Customers ↔ Orders`.
3. Zaproponuj stały porządek dostępu, np. `Customers → Orders`.
4. Omów retry po błędzie 1205 — i dlaczego nie włączamy globalnego retry w tym labie.
5. W VS Code uruchom `sql/06_Deadlock_From_System_Health.sql` i odczytaj najnowszy `xml_deadlock_report`.
6. Zapisz XML jako plik `.xdl` i zwizualizuj go za pomocą `scripts/Convert-DeadlockXdlToHtml.ps1`.

## Co zapisać
- która sesja została victim,
- SQL error `1205` / HTTP `409`,
- pierwszy i drugi zasób każdej sesji,
- cykl zależności,
- wniosek z deadlock graph,
- proponowany stały porządek dostępu i strategię retry.

## Kryterium zakończenia
Potrafisz nie tylko wywołać deadlock, ale również udowodnić go na podstawie `system_health`, odczytać cykl z deadlock graph i zaproponować sposób zapobiegania.

## Gdy wynik jest inny
- Obie sesje się zatwierdzają: requesty nie wystartowały wystarczająco równolegle; powtórz test.
- Nie widzisz eventu: odczekaj chwilę i uruchom ponownie helper `06_Deadlock_From_System_Health.sql`.
- Victim jest inny niż wcześniej: to poprawne — nie zakładaj, że zawsze będzie nim ta sama sesja.

## Pytania
- Czym deadlock różni się od blockingu?
- Dlaczego SQL Server wybiera victim?
- Dlaczego sam błąd 1205 to mniej evidence niż deadlock graph?

## Arkusz
Wypełnij [../worksheets/LAB09_WORKSHEET.md](../worksheets/LAB09_WORKSHEET.md).
