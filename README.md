# EF Core Through the Eyes of a DBA — Student Package

This package contains the lab API, SQL environment and student-facing workshop materials.

Before the workshop, complete: `docs/WORKSHOP_SOFTWARE_REQUIREMENTS.md`

Then start here: `docs/STUDENT_GUIDE_INDEX.md`

| Language | Labs and worksheets |
|---|---|
| Polski | `docs/pl/` |
| English | `docs/en/` |
| Deutsch | `docs/de/` |

Lab titles and HTTP endpoints are English in every track. The slides, if your instructor shows them, stay English.

Quick start:

```powershell
docker compose up -d --wait
./Setup-Lab.ps1
cd .\src\Workshop.Api
dotnet run
```

API: `http://localhost:5000`
Swagger: `http://localhost:5000/swagger`

Instructor solutions, expected results, instructor test guides, presentation notes and the quiz answer key are intentionally excluded.
