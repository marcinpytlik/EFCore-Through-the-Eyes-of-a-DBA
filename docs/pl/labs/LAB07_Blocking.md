# LAB07 — Blocking Caused by Application Transaction

## Cel
Zdiagnozować blocking spowodowany zbyt długo otwartą transakcją.

## Czas
40 min.

## Przed startem
- API i baza muszą działać.
- Użyj `src/Workshop.Api/Workshop.Api.http`; dwa requesty trzeba wysłać w krótkim oknie czasowym.
- Otwórz drugie okno SQL w VS Code do obserwacji requests i locków.

## Kroki
1. Wywołaj `POST /workshop3/blocking/1`.
2. **Od razu**, w ciągu 30 s, wywołaj `POST /workshop3/update/1?status=Completed`. Drugi request ma czekać.
3. W VS Code uruchom:
```sql
SELECT r.session_id, r.status, r.wait_type, r.wait_time,
       r.blocking_session_id, t.text
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
WHERE r.session_id <> @@SPID;
```
4. Sprawdź locki:
```sql
SELECT request_session_id, resource_type, resource_description,
       request_mode, request_status
FROM sys.dm_tran_locks
WHERE resource_database_id = DB_ID(N'EfCoreDbaLab');
```
5. Wskaż blocker i blocked session.
6. Znajdź `Task.Delay(30s)` wewnątrz transakcji.
7. Zaproponuj skrócenie zakresu transakcji.

## Co zapisać
- `session_id` blockera i sesji blokowanej,
- `wait_type` i `blocking_session_id`,
- tryby locków i typ zasobu,
- czas życia transakcji,
- root cause oraz proponowany fix.

## Kryterium zakończenia
Potrafisz pokazać aktywny blocking, wskazać obie sesje i wyjaśnić, dlaczego request czeka jeszcze przed zakończeniem transakcji aplikacyjnej.

## Gdy wynik jest inny
- Drugi request wraca natychmiast: hold już się skończył; powtórz i wyślij drugi request szybciej.
- Nie widzisz waita: uruchom zapytanie diagnostyczne w czasie, gdy drugi request nadal czeka.
- Trudno trafić w timing: użyj dwóch requestów w `Workshop.Api.http`, nie Swaggera.

## Pytania
- Czy SQL Server jest przyczyną, czy miejscem ujawnienia problemu?
- Jakich operacji nie trzymać w długiej transakcji?
- Dlaczego blocked request może czekać już na SELECT?

## Arkusz
Wypełnij [../worksheets/LAB07_WORKSHEET.md](../worksheets/LAB07_WORKSHEET.md).
