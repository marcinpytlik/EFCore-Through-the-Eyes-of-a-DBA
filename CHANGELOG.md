# Changelog

All notable changes to this workshop repository are documented here.

## [1.0.1] — 2026-09-01

Student preparation and packaging update.

### Added
- `docs/WORKSHOP_SOFTWARE_REQUIREMENTS.md` with the complete workstation preparation checklist.
- Required and recommended VS Code extensions for C#, SQL Server diagnostics, REST requests, Docker and PowerShell.
- Visual Studio alternative setup guidance.
- Explicit checks for Docker, .NET 10 SDK, local ports, SQL connectivity and the workshop API.
- `Publish-StudentRepository.ps1` for one-command publishing of the validated student package to the public `marcinpytlik/EFCore-Through-the-Eyes-of-a-DBA` repository.
- A second instructor-content leak validation before the public repository is committed or pushed.

### Changed
- Student package entry documentation now points to the software-requirements checklist before the lab guide.
- The private instructor repository is documented as the source of truth; the public student repository is treated as generated output.
- Release metadata updated from `v1.0.0` to `v1.0.1`.

## [1.0.0] — 2026-09-01

First complete workshop release.

### Included
- 8-hour workshop structure with 4 workshops and 12 labs.
- English HTML presentation with instructor notes and canonical agenda.
- Three complete student tracks: Polish, English and German.
- Student worksheets and generated workbooks for each language track.
- Docker-based SQL Server 2022 lab environment with .NET 10 / EF Core 10 API.
- Query Store configured for workshop diagnostics.
- Labs covering generated SQL, deferred execution, projection, execution plans, indexes, SARGability, blocking, isolation levels, deadlocks, Query Store, incident investigation and a final developer/DBA capstone.
- `system_health` deadlock extraction and XDL visualization workflow.
- Setup, reset, troubleshooting and diagnostic helper scripts.
- Instructor-only clean-room QA guides, expected results and solutions.
- Student package generation with validation against instructor-material leaks.

### Workshop principle
> SQL Server sees the SQL, parameters, execution pattern, and transaction behaviour produced by the application — not the original C# intent.
