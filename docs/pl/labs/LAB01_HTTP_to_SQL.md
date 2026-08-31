# LAB01 — From HTTP Request to SQL Server

## Cel
Prześledzić pełną ścieżkę **HTTP request → ASP.NET Core → EF Core → SQL Server** i zobaczyć SQL generowany przez ORM.

## Czas
35–40 min.

## Przed startem
- Docker i API muszą działać.
- Baza `EfCoreDbaLab` musi być utworzona przez `Setup-Lab.ps1` / `Setup-Lab.sh`.
- Przygotuj `Workshop.Api.http` albo Swagger oraz połączenie SQL w VS Code.

## Kroki
1. Uruchom środowisko:

Windows:
```powershell
docker compose up -d --wait
.\Setup-Lab.ps1
cd .\src\Workshop.Api
dotnet run
```

macOS / Linux:
```bash
docker compose up -d --wait
./Setup-Lab.sh
cd src/Workshop.Api
dotnet run
```

API nasłuchuje na `http://localhost:5000` (patrz `Properties/launchSettings.json`).

2. W Swagger albo `Workshop.Api.http` wywołaj `GET /workshop1/customers-bad`.
3. W **konsoli `dotnet run`** (nie w logu Dockera) znajdź `Microsoft.EntityFrameworkCore.Database.Command`.
4. Skopiuj SQL i wskaż tabelę główną, JOIN, listę kolumn i TOP.
5. Otwórz `Workshop1Endpoints.cs` i znajdź `Include` + `Take(100)`.
6. Ustal, co buduje zapytanie, a co powoduje jego wykonanie.
7. W VS Code połącz się z `localhost,14333` / `EfCoreDbaLab` i wklej SQL z logu — porównaj go z tym, co wygenerował EF Core.

Porównanie z `customers-good` zostaw na LAB03, chyba że instruktor powie inaczej.

## Co zapisać
- endpoint,
- wygenerowany SQL,
- tabelę główną i JOIN-y,
- wybrane kolumny,
- metodę, która powoduje materializację,
- krótką odpowiedź: co naprawdę dociera do SQL Servera?

## Oczekiwany wynik
SQL Server nie widzi C# ani LINQ — widzi końcowy SQL, parametry i zachowanie transakcyjne aplikacji.

## Kryterium zakończenia
Lab jest zakończony, gdy potrafisz wskazać konkretny request HTTP, odpowiadający mu SQL i miejsce w kodzie, w którym zapytanie zostaje wykonane.

## Gdy wynik jest inny
- Brak SQL w konsoli: upewnij się, że patrzysz na proces `dotnet run`, a nie log kontenera SQL Server.
- Endpoint nie odpowiada: sprawdź `GET /` i port `5000`.
- Brak połączenia SQL: sprawdź port `14333` i stan kontenera.

## Pytania kontrolne
- Czy `Include()` samo wykonuje SQL?
- Co dokładnie dociera do SQL Servera?
- Jak znaleźć SQL wygenerowany przez EF Core?

## Arkusz
Wypełnij [../worksheets/LAB01_WORKSHEET.md](../worksheets/LAB01_WORKSHEET.md).
