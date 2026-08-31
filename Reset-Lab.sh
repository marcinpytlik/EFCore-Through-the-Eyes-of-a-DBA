#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

container='efcore-dba-sql'
password='LabPassword!2026'
server='localhost,14333'

container_sqlcmd() {
  for path in /opt/mssql-tools18/bin/sqlcmd /opt/mssql-tools/bin/sqlcmd; do
    if docker exec "$container" sh -c "test -x '$path'" >/dev/null 2>&1; then
      printf '%s' "$path"
      return 0
    fi
  done
  return 1
}

run_sqlcmd_query() {
  local query="$1"
  local path
  if path="$(container_sqlcmd)"; then
    docker exec -i "$container" "$path" -C -S localhost -U sa -P "$password" -b <<<"$query"
  elif command -v sqlcmd >/dev/null 2>&1; then
    sqlcmd -C -S "$server" -U sa -P "$password" -b <<<"$query"
  else
    docker run --rm -i --network "container:${container}" mcr.microsoft.com/mssql-tools \
      /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P "$password" -b <<<"$query"
  fi
}

echo 'Dropping lab database...'
run_sqlcmd_query "IF DB_ID(N'EfCoreDbaLab') IS NOT NULL
BEGIN
    ALTER DATABASE EfCoreDbaLab SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EfCoreDbaLab;
END"

exec "$ROOT/Setup-Lab.sh"
