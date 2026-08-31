[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateScript({ Test-Path -LiteralPath $_ -PathType Leaf })]
    [string]$InputPath,

    [Parameter(Position = 1)]
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function ConvertTo-HtmlEncoded {
    param([AllowNull()][string]$Text)
    if ($null -eq $Text) { return '' }
    return [System.Net.WebUtility]::HtmlEncode($Text)
}

function Get-XmlAttribute {
    param(
        [System.Xml.XmlElement]$Node,
        [string]$Name
    )
    if ($null -eq $Node) { return '' }
    return $Node.GetAttribute($Name)
}

function Get-ShortSqlText {
    param(
        [AllowNull()][string]$Text,
        [int]$Max = 180
    )
    if ([string]::IsNullOrWhiteSpace($Text)) { return '(SQL text unavailable)' }
    $one = ($Text -replace '\s+', ' ').Trim()
    if ($one.Length -le $Max) { return $one }
    return $one.Substring(0, $Max - 3) + '...'
}

$resolvedInput = (Resolve-Path -LiteralPath $InputPath).Path
if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    $dir = Split-Path -Parent $resolvedInput
    $base = [IO.Path]::GetFileNameWithoutExtension($resolvedInput)
    $OutputPath = Join-Path $dir ($base + '.html')
}
elseif (-not [IO.Path]::IsPathRooted($OutputPath)) {
    $OutputPath = Join-Path (Get-Location).Path $OutputPath
}

[xml]$doc = Get-Content -LiteralPath $resolvedInput -Raw -Encoding UTF8
$deadlock = if ($doc.DocumentElement.LocalName -eq 'deadlock') {
    $doc.DocumentElement
} else {
    $doc.SelectSingleNode('//deadlock')
}

if ($null -eq $deadlock) {
    throw 'No <deadlock> element found. Save the xml_deadlock_report payload as XML/XDL and try again.'
}

$victimIds = @()
foreach ($v in $deadlock.SelectNodes('./victim-list/victimProcess')) {
    $id = Get-XmlAttribute $v 'id'
    if ($id) { $victimIds += $id }
}

$processes = @()
$processById = @{}
foreach ($p in $deadlock.SelectNodes('./process-list/process')) {
    $frame = $p.SelectSingleNode('./executionStack/frame[1]')
    $input = $p.SelectSingleNode('./inputbuf')
    $sql = if ($null -ne $frame -and -not [string]::IsNullOrWhiteSpace($frame.InnerText)) {
        $frame.InnerText
    } elseif ($null -ne $input) {
        $input.InnerText
    } else { '' }

    $obj = [pscustomobject]@{
        Id           = Get-XmlAttribute $p 'id'
        Spid         = Get-XmlAttribute $p 'spid'
        Isolation    = Get-XmlAttribute $p 'isolationlevel'
        LockMode     = Get-XmlAttribute $p 'lockMode'
        WaitResource = Get-XmlAttribute $p 'waitresource'
        ClientApp    = Get-XmlAttribute $p 'clientapp'
        HostName     = Get-XmlAttribute $p 'hostname'
        IsVictim     = $false
        SqlText      = Get-ShortSqlText $sql
    }
    $obj.IsVictim = $victimIds -contains $obj.Id
    $processes += $obj
    $processById[$obj.Id] = $obj
}

if ($processes.Count -eq 0) {
    throw 'Deadlock XML contains no process nodes.'
}

$resources = @()
$edges = @()
$i = 0
foreach ($r in $deadlock.SelectNodes('./resource-list/*')) {
    $i++
    $rid = "R$i"
    $type = $r.LocalName
    $objectName = Get-XmlAttribute $r 'objectname'
    $indexName = Get-XmlAttribute $r 'indexname'
    $dbid = Get-XmlAttribute $r 'dbid'
    $labelParts = @($type)
    if ($objectName) { $labelParts += $objectName }
    if ($indexName) { $labelParts += "index: $indexName" }
    if ($dbid) { $labelParts += "dbid: $dbid" }

    $resources += [pscustomobject]@{ Id = $rid; Label = ($labelParts -join ' | ') }

    foreach ($owner in $r.SelectNodes('./owner-list/owner')) {
        $edges += [pscustomobject]@{
            From = Get-XmlAttribute $owner 'id'
            To   = $rid
            Kind = 'owns'
            Mode = Get-XmlAttribute $owner 'mode'
        }
    }
    foreach ($waiter in $r.SelectNodes('./waiter-list/waiter')) {
        $edges += [pscustomobject]@{
            From = $rid
            To   = Get-XmlAttribute $waiter 'id'
            Kind = 'waits'
            Mode = Get-XmlAttribute $waiter 'mode'
        }
    }
}

$width = 1400
$procW = 390
$procH = 190
$resW = 360
$resH = 88
$leftX = 35
$rightX = 975
$resX = 520
$gapY = 45

$pos = @{}
for ($n = 0; $n -lt $processes.Count; $n++) {
    $x = if (($n % 2) -eq 0) { $leftX } else { $rightX }
    $row = [math]::Floor($n / 2)
    $y = 55 + ($row * ($procH + $gapY))
    $pos[$processes[$n].Id] = @{ X = [double]$x; Y = [double]$y; W = [double]$procW; H = [double]$procH }
}
for ($n = 0; $n -lt $resources.Count; $n++) {
    $y = 75 + ($n * ($resH + 55))
    $pos[$resources[$n].Id] = @{ X = [double]$resX; Y = [double]$y; W = [double]$resW; H = [double]$resH }
}

$bottoms = @()
foreach ($k in $pos.Keys) { $bottoms += ($pos[$k].Y + $pos[$k].H) }
$height = [int](($bottoms | Measure-Object -Maximum).Maximum + 110)

$sb = [Text.StringBuilder]::new()
[void]$sb.AppendLine("<svg viewBox='0 0 $width $height' xmlns='http://www.w3.org/2000/svg'>")
[void]$sb.AppendLine("<defs><marker id='arrow' viewBox='0 0 10 10' refX='9' refY='5' markerWidth='7' markerHeight='7' orient='auto'><path d='M0,0 L10,5 L0,10 z' fill='context-stroke'/></marker></defs>")

foreach ($e in $edges) {
    if (-not $pos.ContainsKey($e.From) -or -not $pos.ContainsKey($e.To)) { continue }
    $a = $pos[$e.From]
    $b = $pos[$e.To]
    $x1 = $a.X + $a.W / 2
    $y1 = $a.Y + $a.H / 2
    $x2 = $b.X + $b.W / 2
    $y2 = $b.Y + $b.H / 2
    $stroke = if ($e.Kind -eq 'waits') { '#f59e0b' } else { '#38bdf8' }
    $dash = if ($e.Kind -eq 'waits') { " stroke-dasharray='8 5'" } else { '' }
    [void]$sb.AppendLine("<line x1='$x1' y1='$y1' x2='$x2' y2='$y2' stroke='$stroke' stroke-width='3'$dash marker-end='url(#arrow)'/>")
    $mx = [int](($x1 + $x2) / 2)
    $my = [int](($y1 + $y2) / 2) - 7
    $edgeLabel = ConvertTo-HtmlEncoded "$($e.Kind) $($e.Mode)"
    [void]$sb.AppendLine("<text x='$mx' y='$my' text-anchor='middle' class='edge-label'>$edgeLabel</text>")
}

foreach ($p in $processes) {
    $q = $pos[$p.Id]
    $fill = if ($p.IsVictim) { '#451a1a' } else { '#172554' }
    $stroke = if ($p.IsVictim) { '#fb7185' } else { '#60a5fa' }
    $title = if ($p.IsVictim) { "SPID $($p.Spid) - DEADLOCK VICTIM" } else { "SPID $($p.Spid)" }
    [void]$sb.AppendLine("<g><rect x='$($q.X)' y='$($q.Y)' width='$($q.W)' height='$($q.H)' rx='12' fill='$fill' stroke='$stroke' stroke-width='3'/>")
    [void]$sb.AppendLine("<text x='$($q.X+18)' y='$($q.Y+30)' class='title'>$(ConvertTo-HtmlEncoded $title)</text>")
    [void]$sb.AppendLine("<text x='$($q.X+18)' y='$($q.Y+58)' class='small'>$(ConvertTo-HtmlEncoded "Isolation: $($p.Isolation) | lockMode: $($p.LockMode)")</text>")
    [void]$sb.AppendLine("<text x='$($q.X+18)' y='$($q.Y+82)' class='small'>$(ConvertTo-HtmlEncoded "Wait: $($p.WaitResource)")</text>")
    [void]$sb.AppendLine("<text x='$($q.X+18)' y='$($q.Y+106)' class='small'>$(ConvertTo-HtmlEncoded "App: $($p.ClientApp)")</text>")
    [void]$sb.AppendLine("<foreignObject x='$($q.X+18)' y='$($q.Y+120)' width='$($q.W-36)' height='58'><div xmlns='http://www.w3.org/1999/xhtml' class='sql'>$(ConvertTo-HtmlEncoded $p.SqlText)</div></foreignObject></g>")
}

foreach ($r in $resources) {
    $q = $pos[$r.Id]
    [void]$sb.AppendLine("<g><rect x='$($q.X)' y='$($q.Y)' width='$($q.W)' height='$($q.H)' rx='12' fill='#052e2b' stroke='#2dd4bf' stroke-width='3'/>")
    [void]$sb.AppendLine("<foreignObject x='$($q.X+16)' y='$($q.Y+16)' width='$($q.W-32)' height='$($q.H-28)'><div xmlns='http://www.w3.org/1999/xhtml' class='resource'>$(ConvertTo-HtmlEncoded $r.Label)</div></foreignObject></g>")
}
[void]$sb.AppendLine('</svg>')

$victims = @()
foreach ($id in $victimIds) {
    if ($processById.ContainsKey($id)) { $victims += "SPID $($processById[$id].Spid)" } else { $victims += $id }
}
$victimText = if ($victims.Count) { $victims -join ', ' } else { 'not marked' }

$html = @"
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>SQL Server Deadlock Graph</title>
<style>
body{margin:0;background:#0f172a;color:#e2e8f0;font-family:Segoe UI,Arial,sans-serif}header{padding:24px 30px 10px}h1{margin:0 0 8px}.meta{color:#94a3b8}.wrap{padding:18px 24px 30px}.card{background:#111827;border:1px solid #334155;border-radius:14px;overflow:auto}.title{fill:#fff;font-size:16px;font-weight:700}.small{fill:#cbd5e1;font-size:12px}.edge-label{fill:#e2e8f0;font-size:12px;paint-order:stroke;stroke:#0f172a;stroke-width:4}.sql,.resource{color:#cbd5e1;font:12px Consolas,monospace;line-height:1.35;overflow:hidden}.legend{display:flex;gap:24px;padding:12px 0;color:#cbd5e1;font-size:13px}svg{min-width:1200px;width:100%;height:auto}
</style>
</head>
<body>
<header><h1>SQL Server Deadlock Graph</h1><div class="meta">Input: $(ConvertTo-HtmlEncoded ([IO.Path]::GetFileName($resolvedInput))) &nbsp; | &nbsp; Victim: $(ConvertTo-HtmlEncoded $victimText) &nbsp; | &nbsp; Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</div></header>
<div class="wrap"><div class="legend"><span>Blue = owns lock</span><span>Orange dashed = waits</span><span>Red process = victim</span></div><div class="card">$($sb.ToString())</div></div>
</body>
</html>
"@

$outDir = Split-Path -Parent $OutputPath
if ($outDir -and -not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null
}
[IO.File]::WriteAllText($OutputPath, $html, [Text.UTF8Encoding]::new($false))
Write-Host "Deadlock graph written to: $OutputPath"
