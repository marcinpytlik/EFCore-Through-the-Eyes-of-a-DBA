$ErrorActionPreference = 'Stop'

$container = 'efcore-dba-sql'
$password = 'LabPassword!2026'
$server = 'localhost,14333'

Write-Host 'Dropping lab database...'

$query = @"
IF DB_ID(N'EfCoreDbaLab') IS NOT NULL
BEGIN
    ALTER DATABASE EfCoreDbaLab SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EfCoreDbaLab;
END
"@

function Get-ContainerSqlcmdPath {
    foreach ($path in @(
            '/opt/mssql-tools18/bin/sqlcmd',
            '/opt/mssql-tools/bin/sqlcmd')) {
        docker exec $container sh -c "test -x '$path'" 2>$null
        if ($LASTEXITCODE -eq 0) { return $path }
    }
    return $null
}

$containerSqlcmd = Get-ContainerSqlcmdPath
if ($containerSqlcmd) {
    $query | docker exec -i $container $containerSqlcmd -C -S localhost -U sa -P $password -b
} elseif (Get-Command sqlcmd -ErrorAction SilentlyContinue) {
    $query | sqlcmd -C -S $server -U sa -P $password -b
} else {
    $query | docker run --rm -i --network "container:$container" mcr.microsoft.com/mssql-tools `
        /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $password -b
}

if ($LASTEXITCODE -ne 0) {
    throw 'Failed to drop the lab database.'
}

& "$PSScriptRoot/Setup-Lab.ps1"
