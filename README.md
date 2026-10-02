# EF Core Through the Eyes of a DBA — Student Package

This repository contains the **student-facing package** for the course:

# EF Core Through the Eyes of a DBA — What Really Reaches SQL Server?

The recommended delivery format is **3 days**.

The course connects application-side decisions in C#, LINQ and Entity Framework Core with what SQL Server actually receives and executes: generated SQL, execution plans, logical reads, locks, waits, deadlocks and Query Store workload.

## Start here

1. Complete the [software requirements](docs/WORKSHOP_SOFTWARE_REQUIREMENTS.md).
2. Choose your language in the [Student Guide Index](docs/STUDENT_GUIDE_INDEX.md).
3. For the English 3-day track, open the [Course Map](docs/en/COURSE_MAP.md).
4. Start with [Day 1](docs/en/DAY01.md).

## 3-day English track

| Day | Focus | Labs |
|---|---|---|
| Day 1 | HTTP → EF Core → generated SQL → first plan evidence | LAB01–LAB04 |
| Day 2 | Plans, indexes, SARGability and concurrency | LAB05–LAB09 |
| Day 3 | Query Store and real workload diagnosis | LAB10–LAB12 |

Quick links:

- [Course Map](docs/en/COURSE_MAP.md)
- [Day 1](docs/en/DAY01.md)
- [Day 2](docs/en/DAY02.md)
- [Day 3](docs/en/DAY03.md)
- [Quick Reference](docs/en/QUICK_REFERENCE.md)
- [All labs](docs/en/LABS_INDEX.md)

## Languages

| Language | Student materials |
|---|---|
| Polski | [docs/pl/](docs/pl/) |
| English | [docs/en/](docs/en/) |
| Deutsch | [docs/de/](docs/de/) |

Lab titles and HTTP endpoints stay English in every track.

## Quick start

Windows:

```powershell
docker compose up -d --wait
.\Setup-Lab.ps1
cd .\src\Workshop.Api
dotnet restore
dotnet run
```

macOS / Linux:

```bash
docker compose up -d --wait
./Setup-Lab.sh
cd ./src/Workshop.Api
dotnet restore
dotnet run
```

API: `http://localhost:5000`  
Swagger: `http://localhost:5000/swagger`

## Student / instructor boundary

This public repository intentionally contains only material needed by participants.

It does **not** contain:

- instructor solutions,
- calibrated expected values,
- instructor test guides,
- presentation speaker notes,
- rehearsal scripts,
- fallback notes,
- quiz answer keys.

The goal is to let students collect evidence, explain what they observe and defend their conclusions themselves.

> **Diagnose first. Optimize second.**
