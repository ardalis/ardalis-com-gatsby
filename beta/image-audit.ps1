<#
.SYNOPSIS
  Audits images under static/img for size, dimensions, and potential optimization targets.
.DESCRIPTION
  Scans common raster formats (png,jpg,jpeg,gif,webp,avif) and reports:
   - Top N largest files (default 30)
   - Bucket distribution by size ranges
   - Aggregate totals (count, total MB, average KB)
   - Optional CSV export of the full manifest
  Requires ImageMagick 'magick' on PATH for dimension detection (skips dimension if unavailable).
.PARAMETER Top
  Number of largest images to display (default 30)
.PARAMETER ExportCsv
  Path to write a CSV manifest (optional)
.PARAMETER Root
  Root directory to scan (defaults to static/img relative to script)
.EXAMPLE
  pwsh ./image-audit.ps1
.EXAMPLE
  pwsh ./image-audit.ps1 -Top 50 -ExportCsv image-inventory.csv
#>
[CmdletBinding()] param(
  [int]$Top = 30,
  [string]$ExportCsv,
  [string]$Root
)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $Root) { $Root = Join-Path $here 'static/img' }
if (-not (Test-Path $Root)) { Write-Error "Root path not found: $Root" }

$extensions = '.png','.jpg','.jpeg','.gif','.webp','.avif'
$files = Get-ChildItem -Path $Root -Recurse -File | Where-Object { $extensions -contains $_.Extension.ToLower() }
if (-not $files) { Write-Host 'No matching image files found.' -ForegroundColor Yellow; return }

$magick = (Get-Command magick -ErrorAction SilentlyContinue | Select-Object -First 1).Source
if (-not $magick) { Write-Warning 'ImageMagick (magick) not found; dimension info will be blank.' }

Write-Host ("Scanning {0} images..." -f $files.Count) -ForegroundColor Cyan

function Get-DimensionsOrEmpty {
  param([string]$Path)
  if (-not $magick) { return '' }
  try { & $magick identify -format '%wx%h' -- $Path 2>$null } catch { '' }
}

$manifest = foreach ($f in $files) {
  $dim = Get-DimensionsOrEmpty -Path $f.FullName
  [pscustomobject]@{
    Name       = $f.Name
  # Compute path relative to root using substring; then trim any leading separators robustly
  Relative   = ($f.FullName.Substring($Root.Length) -replace '^[\\/]+','')
    Path       = $f.FullName
    Extension  = $f.Extension.ToLower()
    KB         = [math]::Round($f.Length / 1KB, 1)
    Bytes      = $f.Length
    Dimensions = $dim
    Modified   = $f.LastWriteTime
  }
}

$largest = $manifest | Sort-Object KB -Descending | Select-Object -First $Top

Write-Host "\nTop $Top Images (by KB):" -ForegroundColor Green
$largest | Select-Object KB, Dimensions, Extension, Relative | Format-Table -AutoSize

$bucketed = $manifest | Group-Object { 
  switch ($_.KB) {
    { $_ -lt 50 }  { '<50KB'; break }
    { $_ -lt 100 } { '50-100KB'; break }
    { $_ -lt 250 } { '100-250KB'; break }
    { $_ -lt 500 } { '250-500KB'; break }
    { $_ -lt 1000 }{ '500KB-1MB'; break }
    default        { '>1MB' }
  }
} | Sort-Object Name

Write-Host "\nSize Distribution:" -ForegroundColor Green
$bucketed | Select-Object Name, Count | Format-Table -AutoSize

$totalBytes = ($manifest | Measure-Object -Property Bytes -Sum).Sum
$avgKB = [math]::Round(($manifest | Measure-Object -Property KB -Average).Average,1)
Write-Host ("\nTotals: Count={0} Total={1:N2} MB Avg={2} KB" -f $manifest.Count, ($totalBytes/1MB), $avgKB) -ForegroundColor Cyan

if ($ExportCsv) {
  $manifest | Export-Csv -NoTypeInformation -Path $ExportCsv -Encoding UTF8
  Write-Host "\nCSV written: $ExportCsv" -ForegroundColor Cyan
}

# Recommend potential optimizations
Write-Host "\nRecommendations:" -ForegroundColor Green
$over150 = $manifest | Where-Object { $_.KB -gt 150 -and $_.Extension -notin '.webp','.avif' } | Select-Object -First 8
if ($over150) {
  Write-Host " - Convert large PNG/JPG to WebP (examples):" -ForegroundColor Yellow
  $over150 | ForEach-Object { Write-Host ("   {0} ({1} KB) -> consider: magick '{2}' -strip -resize '1600x1600>' -quality 82 '{3}.webp'" -f $_.Relative,$_.KB,$_.Path,($_.Path -replace '\\.[^.]+$','')) }
} else {
  Write-Host ' - No PNG/JPG files above 150KB found.' -ForegroundColor Yellow
}

$noDim = $manifest | Where-Object { -not $_.Dimensions } | Select-Object -First 5
if ($noDim) { Write-Host " - Some items lacked dimension info (possibly SVG or unreadable):"; $noDim | ForEach-Object { Write-Host ("   {0}" -f $_.Relative) } }

Write-Host "\nDone." -ForegroundColor Green
