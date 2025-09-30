<#
.SYNOPSIS
  Generates WebP (or optionally AVIF) variants of images under static/img, only keeping them when smaller.
.DESCRIPTION
  For each source PNG/JPG/JPEG (optionally GIF) the script:
   1. Optionally resizes to a max bounding box (default 1600x1600) maintaining aspect ratio.
   2. Writes a temporary WebP at given quality (default 82) and compares size.
   3. Keeps the WebP if it saves at least MinimumSavingsPercent OR MinimumSavingsKB.
   4. Can run in -DryRun mode to just report potential savings.
  Skips if a WebP already exists unless -Force is specified.
.PARAMETER Root
  Root directory containing static/img (default: ./static/img relative to script)
.PARAMETER MaxSize
  Geometry passed to ImageMagick (e.g. 1600x1600>) to constrain large originals.
.PARAMETER Quality
  WebP quality setting (lossy). 75-85 is a good balance; default 82.
.PARAMETER IncludeGif
  Include GIF sources (first frame only) for conversion.
.PARAMETER MinimumSavingsPercent
  Percentage reduction (integer) required to keep new file (default 15).
.PARAMETER MinimumSavingsKB
  Absolute KB reduction required (default 20). Either threshold qualifies.
.PARAMETER Force
  Re-generate even if a WebP already exists.
.PARAMETER DryRun
  Do not write any files; only show what would happen.
.PARAMETER Limit
  Only process the first N candidates (after filtering) for quicker trials.
.PARAMETER DeleteOriginalOnSuccess
  If set, delete original source file when WebP created (NOT recommended until reviewed).
.EXAMPLE
  pwsh ./image-optimize-webp.ps1 -DryRun
.EXAMPLE
  pwsh ./image-optimize-webp.ps1 -Quality 80 -MinimumSavingsPercent 10 -Limit 100
#>
[CmdletBinding()] param(
  [string]$Root,
  [string]$MaxSize = '1600x1600>',
  [int]$Quality = 82,
  [switch]$IncludeGif,
  [int]$MinimumSavingsPercent = 15,
  [int]$MinimumSavingsKB = 20,
  [switch]$Force,
  [switch]$DryRun,
  [int]$Limit = 0,
  [switch]$DeleteOriginalOnSuccess
)

$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $Root) { $Root = Join-Path $here 'static/img' }
if (-not (Test-Path $Root)) { Write-Error "Root path not found: $Root" }

$magick = (Get-Command magick -ErrorAction SilentlyContinue | Select-Object -First 1).Source
if (-not $magick) { throw 'ImageMagick (magick) is required.' }

$extFilter = @('.png','.jpg','.jpeg')
if ($IncludeGif) { $extFilter += '.gif' }

$all = Get-ChildItem -Path $Root -Recurse -File | Where-Object { $extFilter -contains $_.Extension.ToLower() }
if (-not $all) { Write-Host 'No candidate images found.' -ForegroundColor Yellow; return }

# Exclude already small files (< 35KB) as likely low ROI
$candidates = $all | Where-Object { $_.Length -gt 35KB }

if ($Limit -gt 0) { $candidates = $candidates | Select-Object -First $Limit }

Write-Host ("Candidates: {0} (from {1} total)" -f $candidates.Count, $all.Count) -ForegroundColor Cyan

$results = @()
foreach ($f in $candidates) {
  $webpPath = [IO.Path]::ChangeExtension($f.FullName, '.webp')
  if ((Test-Path $webpPath) -and -not $Force) {
    $results += [pscustomobject]@{ Source=$f.FullName; Action='SkipExists'; OrigKB=[math]::Round($f.Length/1KB,1); NewKB=$null; SavedKB=0; Percent=0 } ; continue
  }
  $tmp = [IO.Path]::GetTempFileName() | ForEach-Object { $_ -replace '\\.tmp$','.webp' }
  try {
  $convertArgs = @($f.FullName,'-strip','-resize',$MaxSize,'-quality',$Quality,$tmp)
    if ($DryRun) {
      # Still need size estimate – generate then delete
  & $magick @convertArgs 2>$null
    } else {
  & $magick @convertArgs 2>$null
    }
    if (-not (Test-Path $tmp)) { Write-Warning "Failed to create temp WebP for $($f.Name)"; continue }
    $origBytes = $f.Length
    $newBytes  = (Get-Item $tmp).Length
    $saved = $origBytes - $newBytes
    $percent = if ($origBytes -gt 0) { [math]::Round(($saved / $origBytes) * 100,1) } else { 0 }
    $keep = ($saved/1KB -ge $MinimumSavingsKB) -or ($percent -ge $MinimumSavingsPercent)
    if ($keep -and -not $DryRun) {
      Move-Item -Force $tmp $webpPath
      if ($DeleteOriginalOnSuccess) { Remove-Item $f.FullName -Force }
      $results += [pscustomobject]@{ Source=$f.FullName; Action='Created'; OrigKB=[math]::Round($origBytes/1KB,1); NewKB=[math]::Round($newBytes/1KB,1); SavedKB=[math]::Round($saved/1KB,1); Percent=$percent }
    } else {
      if ($keep -and $DryRun) {
        $results += [pscustomobject]@{ Source=$f.FullName; Action='WouldCreate'; OrigKB=[math]::Round($origBytes/1KB,1); NewKB=[math]::Round($newBytes/1KB,1); SavedKB=[math]::Round($saved/1KB,1); Percent=$percent }
      } else {
        $results += [pscustomobject]@{ Source=$f.FullName; Action='NoBenefit'; OrigKB=[math]::Round($origBytes/1KB,1); NewKB=[math]::Round($newBytes/1KB,1); SavedKB=[math]::Round($saved/1KB,1); Percent=$percent }
      }
      Remove-Item $tmp -ErrorAction SilentlyContinue
    }
  } catch {
    Write-Warning "Error optimizing $($f.Name): $($_.Exception.Message)"
    Remove-Item $tmp -ErrorAction SilentlyContinue
  }
}

# Summary
$created = $results | Where-Object Action -eq 'Created'
$would   = $results | Where-Object Action -eq 'WouldCreate'
$keptSavingsKB = ($created | Measure-Object -Property SavedKB -Sum).Sum
$potentialKB   = ($would   | Measure-Object -Property SavedKB -Sum).Sum

Write-Host "\nOptimization Summary:" -ForegroundColor Green
Write-Host (" Created: {0} | Potential (DryRun): {1}" -f $created.Count, $would.Count)
Write-Host (" Saved (KB): {0} | Potential (KB): {1}" -f $keptSavingsKB, $potentialKB)

$results | Sort-Object Percent -Descending | Select-Object Action, Percent, SavedKB, OrigKB, NewKB, Source | Format-Table -AutoSize

if ($DryRun) { Write-Host "\nRun without -DryRun to apply." -ForegroundColor Yellow }
