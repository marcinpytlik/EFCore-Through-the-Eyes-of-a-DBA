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
    docker exec "$container" "$path" -C -S localhost -U sa -P "$password" -Q "$query"
  elif command -v sqlcmd >/dev/null 2>&1; then
    sqlcmd -C -S "$server" -U sa -P "$password" -Q "$query"
  else
    docker run --rm --network "container:${container}" mcr.microsoft.com/mssql-tools \
      /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P "$password" -Q "$query"
  fi
}

run_sqlcmd_file() {
  local file="$1"
  local path
  if path="$(container_sqlcmd)"; then
    docker exec -i "$container" "$path" -C -S localhost -U sa -P "$password" -b < "$file"
  elif command -v sqlcmd >/dev/null 2>&1; then
    sqlcmd -C -S "$server" -U sa -P "$password" -b -i "$file"
  else
    docker run --rm -i --network "container:${container}" mcr.microsoft.com/mssql-tools \
      /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P "$password" -b < "$file"
  fi
}

echo 'Starting SQL Server (docker compose up --wait)...'
if ! docker compose up -d --wait; then
  docker compose up -d
fi

echo 'Waiting until SQL Server accepts queries...'
ready=0
for _ in $(seq 1 60); do
  if run_sqlcmd_query 'SELECT 1' >/dev/null 2>&1; then
    ready=1
    break
  fi
  sleep 2
done

if [[ "$ready" -ne 1 ]]; then
  echo 'SQL Server is not ready. Check: docker logs efcore-dba-sql' >&2
  exit 1
fi

for script in 01_CreateDatabase.sql 02_CreateSchema.sql 03_SeedData.sql 04_EnableQueryStore.sql; do
  echo "Running ${script}..."
  run_sqlcmd_file "${ROOT}/sql/${script}"
done

echo
echo 'Lab database is ready.'
echo 'Connection: localhost,14333'
echo 'Database: EfCoreDbaLab'
echo 'Hot customer: 123'
