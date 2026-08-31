#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

build_lang() {
  local lang="$1"
  local out="${ROOT}/docs/${lang}/STUDENT_WORKBOOK.md"
  local ws="${ROOT}/docs/${lang}/worksheets"
  local header

  case "$lang" in
    pl)
      header='# Zeszyt studenta — EF Core Through the Eyes of a DBA

Zapisz pomiary i wnioski ze wszystkich 12 labów.

Ten plik jest generowany z `docs/pl/worksheets/`. Edytuj arkusze poszczególnych labów, potem uruchom `./scripts/Build-StudentWorkbook.sh` albo `./scripts/Build-StudentWorkbook.ps1`.

> Preferuj kształt planu, logical reads, szacunki wierszy, waits i dowody z Query Store zamiast sztywnych progów milisekund.'
      ;;
    de)
      header='# Teilnehmer-Workbook — EF Core Through the Eyes of a DBA

Halten Sie Messungen und Schlussfolgerungen für alle 12 Labs fest.

Diese Datei wird aus `docs/de/worksheets/` erzeugt. Bearbeiten Sie die einzelnen Arbeitsblätter und führen Sie danach `./scripts/Build-StudentWorkbook.sh` oder `./scripts/Build-StudentWorkbook.ps1` aus.

> Bevorzugen Sie Planform, Logical Reads, Zeilenschätzungen, Waits und Query-Store-Nachweise gegenüber festen Millisekundenwerten.'
      ;;
    *)
      header='# Student Workbook — EF Core Through the Eyes of a DBA

Record measurements and conclusions for all 12 labs.

This file is generated from `docs/en/worksheets/`. Edit the per-lab worksheets, then run `./scripts/Build-StudentWorkbook.sh` or `./scripts/Build-StudentWorkbook.ps1`.

> Prefer execution-plan shape, logical reads, row estimates, waits and Query Store evidence over fixed millisecond targets.'
      ;;
  esac

  {
    printf '%s\n' "$header"
    for n in 01 02 03 04 05 06 07 08 09 10 11 12; do
      local f="${ws}/LAB${n}_WORKSHEET.md"
      if [[ ! -f "$f" ]]; then
        echo "Missing worksheet: $f" >&2
        exit 1
      fi
      printf '\n---\n\n'
      cat "$f"
    done
  } > "$out"

  echo "Wrote $out"
}

for lang in pl en de; do
  build_lang "$lang"
done
