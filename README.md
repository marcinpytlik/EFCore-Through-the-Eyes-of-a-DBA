# EF Core Through the Eyes of a DBA — Lab Environment

Wspólne środowisko laboratoryjne do 8-godzinnego warsztatu:

1. **From HTTP Request to SQL Server**
2. **Execution Plans and Indexes**
3. **Transactions, Locking and Concurrency**
4. **Diagnosing a Real EF Core Workload**

## Założenia

- .NET 10
- ASP.NET Core Web API
- Entity Framework Core 10
- Microsoft SQL Server 2022 Developer
- Query Store
- jedna wspólna baza: `EfCoreDbaLab`
- celowo przygotowane problemy wydajnościowe

> Repo ma zawierać problemy, a nie wyłącznie ich rozwiązania. Studenci najpierw obserwują zachowanie aplikacji i SQL Servera, a dopiero później poprawiają kod lub bazę.

## Szybki start

### 1. Uruchom SQL Server

```powershell
docker compose up -d
```

### 2. Zbuduj bazę i dane laboratoryjne

Windows / PowerShell:

```powershell
./Setup-Lab.ps1
```

Skrypt tworzy bazę, tabele, dane testowe i włącza Query Store.

### 3. Uruchom API

```powershell
cd src/Workshop.Api
dotnet restore
dotnet run
```

API domyślnie łączy się do:

```text
Server=localhost,14333;Database=EfCoreDbaLab;User Id=sa;Password=LabPassword!2026;TrustServerCertificate=True
```

### 4. Otwórz Swagger

Adres zostanie pokazany przez `dotnet run`, zwykle:

```text
http://localhost:5000/swagger
```

## Reset środowiska

```powershell
./Reset-Lab.ps1
```

## Struktura

```text
EFCore-DBA-Lab/
├── docker-compose.yml
├── Setup-Lab.ps1
├── Reset-Lab.ps1
├── sql/
│   ├── 01_CreateDatabase.sql
│   ├── 02_CreateSchema.sql
│   ├── 03_SeedData.sql
│   ├── 04_EnableQueryStore.sql
│   ├── 05_Diagnostics.sql
│   └── solutions/
│       ├── Workshop2_Indexes.sql
│       └── Workshop3_Deadlock.sql
├── src/
│   └── Workshop.Api/
└── docs/
    ├── INSTRUCTOR_GUIDE.md
    └── STUDENT_LABS.md
```

## Ważne

Hasło `LabPassword!2026` jest celowo proste i służy wyłącznie do lokalnego laboratorium. Nie używać tego ustawienia w środowisku produkcyjnym.


## Detailed labs
See `docs/LABS_INDEX.md` and `docs/labs/LAB01`–`LAB12`.


## Version 0.3

Version 0.3 adds separate:
- `docs/student/` instructions,
- `docs/instructor/` solutions,
- `docs/expected-results/` observations,
- `docs/V0.3_GUIDE.md`.


## Version 0.4
Adds per-lab worksheets, consolidated student workbook, assessment rubric and diagnostic quick reference.


## Version 0.5

Adds a 28-slide instructor PowerPoint deck, minute-by-minute 8-hour agenda, speaker notes and a slide map under `docs/presentation/`.

## Version 0.6
Adds Student/Instructor packages, pre-flight checklist, troubleshooting, offline fallback, final quiz and feedback form.
