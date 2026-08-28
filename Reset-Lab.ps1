$ErrorActionPreference = 'Stop'

$container = 'efcore-dba-sql'
$password = 'LabPassword!2026'
$sqlcmd = '/opt/mssql-tools18/bin/sqlcmd'

Write-Host 'Dropping lab database...'
$query = @"
IF DB_ID(N'EfCoreDbaLab') IS NOT NULL
BEGIN
    ALTER DATABASE EfCoreDbaLab SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EfCoreDbaLab;
END
"@

$query | docker exec -i $container $sqlcmd -C -S localhost -U sa -P $password -b

& "$PSScriptRoot/Setup-Lab.ps1"
