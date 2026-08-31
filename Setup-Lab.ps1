$ErrorActionPreference = 'Stop'

$container = 'efcore-dba-sql'
$password = 'LabPassword!2026'
$server = 'localhost,14333'

function Test-DockerContainer {
    $names = docker ps --format '{{.Names}}' 2>$null
    return $names -contains $container
}

function Wait-LabSql {
    Write-Host 'Starting SQL Server (docker compose up --wait)...'
    docker compose up -d --wait
    if ($LASTEXITCODE -ne 0) {
        throw @'
Docker Compose could not start the lab environment.

A common cause is that TCP port 14333 is already in use by another container or process.
Check:
  docker ps
  Get-NetTCPConnection -LocalPort 14333 -ErrorAction SilentlyContinue

Stop the conflicting service, then run Setup-Lab.ps1 again.
'@
    }

    Write-Host 'Waiting until SQL Server accepts queries...'
    for ($i = 0; $i -lt 60; $i++) {
        try {
            Invoke-LabSqlQuery 'SELECT 1' | Out-Null
            if ($LASTEXITCODE -eq 0) { return }
        } catch {
            # keep waiting
        }
        Start-Sleep -Seconds 2
    }

    throw 'SQL Server is not ready. Check: docker logs efcore-dba-sql'
}

function Get-ContainerSqlcmdPath {
    foreach ($path in @(
            '/opt/mssql-tools18/bin/sqlcmd',
            '/opt/mssql-tools/bin/sqlcmd')) {
        docker exec $container sh -c "test -x '$path'" 2>$null
        if ($LASTEXITCODE -eq 0) { return $path }
    }
    return $null
}

function Invoke-LabSqlQuery {
    param([Parameter(Mandatory = $true)][string]$Query)

    $containerSqlcmd = Get-ContainerSqlcmdPath
    if ($containerSqlcmd) {
        docker exec $container $containerSqlcmd -C -S localhost -U sa -P $password -Q $Query
        return
    }

    if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
        sqlcmd -C -S $server -U sa -P $password -Q $Query
        return
    }

    docker run --rm --network "container:$container" mcr.microsoft.com/mssql-tools `
        /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $password -Q $Query
}

function Invoke-LabSqlFile {
    param([Parameter(Mandatory = $true)][string]$Path)

    $containerSqlcmd = Get-ContainerSqlcmdPath
    if ($containerSqlcmd) {
        Get-Content -Raw $Path | docker exec -i $container $containerSqlcmd -C -S localhost -U sa -P $password -b
        if ($LASTEXITCODE -ne 0) { throw "sqlcmd failed for $Path" }
        return
    }

    if (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
        sqlcmd -C -S $server -U sa -P $password -b -i $Path
        if ($LASTEXITCODE -ne 0) { throw "sqlcmd failed for $Path" }
        return
    }

    Get-Content -Raw $Path | docker run --rm -i --network "container:$container" mcr.microsoft.com/mssql-tools `
        /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $password -b
    if ($LASTEXITCODE -ne 0) { throw "sqlcmd failed for $Path" }
}

Wait-LabSql

$orderedScripts = @(
    '01_CreateDatabase.sql',
    '02_CreateSchema.sql',
    '03_SeedData.sql',
    '04_EnableQueryStore.sql'
)

foreach ($script in $orderedScripts) {
    Write-Host "Running $script..."
    $path = Join-Path $PSScriptRoot "sql/$script"
    Invoke-LabSqlFile -Path $path
}

Write-Host ''
Write-Host 'Lab database is ready.'
Write-Host 'Connection: localhost,14333'
Write-Host 'Database: EfCoreDbaLab'
Write-Host 'Hot customer: 123'
