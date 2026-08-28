$ErrorActionPreference = 'Stop'

$container = 'efcore-dba-sql'
$password = 'LabPassword!2026'
$sqlcmd = '/opt/mssql-tools18/bin/sqlcmd'

Write-Host 'Waiting for SQL Server...'
for ($i = 0; $i -lt 30; $i++) {
    docker exec $container $sqlcmd -C -S localhost -U sa -P $password -Q "SELECT 1" *> $null
    if ($LASTEXITCODE -eq 0) { break }
    Start-Sleep -Seconds 2
}

if ($LASTEXITCODE -ne 0) {
    throw 'SQL Server is not ready.'
}

$orderedScripts = @(
    '01_CreateDatabase.sql',
    '02_CreateSchema.sql',
    '03_SeedData.sql',
    '04_EnableQueryStore.sql'
)

foreach ($script in $orderedScripts) {
    Write-Host "Running $script..."
    $path = Join-Path $PSScriptRoot "sql/$script"
    Get-Content -Raw $path | docker exec -i $container $sqlcmd -C -S localhost -U sa -P $password -b
    if ($LASTEXITCODE -ne 0) {
        throw "Script failed: $script"
    }
}

Write-Host ''
Write-Host 'Lab database is ready.'
Write-Host 'Connection: localhost,14333'
Write-Host 'Database: EfCoreDbaLab'
