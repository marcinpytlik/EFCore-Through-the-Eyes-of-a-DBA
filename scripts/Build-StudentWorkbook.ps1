$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot

$headers = @{
    pl = @'
# Zeszyt studenta — EF Core Through the Eyes of a DBA

Zapisz pomiary i wnioski ze wszystkich 12 labów.

Ten plik jest generowany z `docs/pl/worksheets/`. Edytuj arkusze poszczególnych labów, potem uruchom `./scripts/Build-StudentWorkbook.sh` albo `./scripts/Build-StudentWorkbook.ps1`.

> Preferuj kształt planu, logical reads, szacunki wierszy, waits i dowody z Query Store zamiast sztywnych progów milisekund.
'@
    en = @'
# Student Workbook — EF Core Through the Eyes of a DBA

Record measurements and conclusions for all 12 labs.

This file is generated from `docs/en/worksheets/`. Edit the per-lab worksheets, then run `./scripts/Build-StudentWorkbook.sh` or `./scripts/Build-StudentWorkbook.ps1`.

> Prefer execution-plan shape, logical reads, row estimates, waits and Query Store evidence over fixed millisecond targets.
'@
    de = @'
# Teilnehmer-Workbook — EF Core Through the Eyes of a DBA

Halten Sie Messungen und Schlussfolgerungen für alle 12 Labs fest.

Diese Datei wird aus `docs/de/worksheets/` erzeugt. Bearbeiten Sie die einzelnen Arbeitsblätter und führen Sie danach `./scripts/Build-StudentWorkbook.sh` oder `./scripts/Build-StudentWorkbook.ps1` aus.

> Bevorzugen Sie Planform, Logical Reads, Zeilenschätzungen, Waits und Query-Store-Nachweise gegenüber festen Millisekundenwerten.
'@
}

foreach ($lang in @('pl', 'en', 'de')) {
    $out = Join-Path $root "docs/$lang/STUDENT_WORKBOOK.md"
    $ws = Join-Path $root "docs/$lang/worksheets"
    $parts = New-Object System.Collections.Generic.List[string]
    $parts.Add($headers[$lang])

    1..12 | ForEach-Object {
        $name = 'LAB{0:D2}_WORKSHEET.md' -f $_
        $path = Join-Path $ws $name
        if (-not (Test-Path $path)) { throw "Missing worksheet: $path" }
        $parts.Add('')
        $parts.Add('---')
        $parts.Add('')
        $parts.Add((Get-Content -Raw -Path $path).TrimEnd())
    }

    $text = ($parts -join "`n") + "`n"
    $utf8 = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($out, $text, $utf8)
    Write-Host "Wrote $out"
}
