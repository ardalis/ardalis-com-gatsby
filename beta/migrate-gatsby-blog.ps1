<#!
.SYNOPSIS
  Migrates Gatsby markdown blog posts into the Hugo site.
.DESCRIPTION
  Reads source markdown files under ../src/pages/blog, converts / normalizes front matter,
  copies (or rewrites) to ./content/blog preserving slugs (filenames) to avoid URL breakage.
  Skips files already present at destination (by slug). Supports limiting batch size for incremental migration.
.PARAMETER Limit
  Maximum number of posts to migrate this run (after filtering out already-migrated). 0 or omitted = no limit.
.PARAMETER DryRun
  If specified, no files are written; a report is shown instead.
.PARAMETER Overwrite
  If specified, existing destination files will be re-generated (otherwise they are skipped).
.PARAMETER Verbose
  Adds extra logging (or use -Verbose common parameter).
.NOTES
  Place this script in /beta and run from the /beta directory: `pwsh ./migrate-gatsby-blog.ps1 -Limit 25`
#>
[CmdletBinding()]
param(
    [int]$Limit = 0,
    [switch]$DryRun,
    [switch]$Overwrite,
    [switch]$RegenerateFeaturedImages,
    [string]$FeaturedImageLogoPath,
    [ValidateRange(0,100)][int]$FeaturedImageDarkenPercent = 75
)

# --- Configuration ---
$Script:SourceDir = Join-Path -Path (Resolve-Path ..) -ChildPath 'src/pages/blog'
$Script:DestDir   = Join-Path -Path (Get-Location) -ChildPath 'content/blog'
$Script:StaticImgDir = Join-Path -Path (Get-Location) -ChildPath 'static/img'
$Script:LogoSvgPath  = if ($FeaturedImageLogoPath) { (Resolve-Path $FeaturedImageLogoPath).Path } else { Join-Path -Path (Get-Location) -ChildPath 'ardalis-circle.svg' }
$Script:ImageStats = [ordered]@{ Generated=0; SkippedExisting=0; SkippedMissingLogo=0 }

# Resolve magick path once (fail fast if missing)
$Script:MagickExe = (Get-Command magick -ErrorAction SilentlyContinue | Select-Object -First 1).Source
if (-not $Script:MagickExe) {
    Write-Error 'Required executable "magick" not found on PATH. Install ImageMagick and ensure magick.exe is available.'
    exit 1
}
Write-Verbose "[Prereq] Using ImageMagick: $Script:MagickExe"

if (-not (Test-Path $StaticImgDir)) { New-Item -ItemType Directory -Path $StaticImgDir | Out-Null }
if (-not (Test-Path $LogoSvgPath)) { Write-Warning "Logo SVG not found at $LogoSvgPath; featured image generation will be skipped." }

function Test-FeaturedImagePrereqs {
    Write-Verbose '[Prereq] Checking featured image prerequisites'
    if (Test-Path $Script:LogoSvgPath) { Write-Verbose "[Prereq] Logo SVG: $($Script:LogoSvgPath) (ok)" } else { Write-Warning "Logo SVG missing: $($Script:LogoSvgPath) (featured images will be skipped)." }
}

if (-not (Test-Path $SourceDir)) { throw "Source directory not found: $SourceDir" }
if (-not (Test-Path $DestDir))   { throw "Destination directory not found: $DestDir" }

# Utility: Simple YAML front matter parser (key: value only; arrays/complex retained as raw if encountered)
function Get-FrontMatterParsed {
    param([string[]]$Lines)
    $data = @{}
    foreach ($ln in $Lines) {
        if ($ln -match '^[ \t]*#') { continue }
        if ($ln -match '^[ \t]*$') { continue }
        if ($ln -match '^(?<k>[A-Za-z0-9_-]+):\s*(?<v>.*)$') {
            $k = $Matches.k.Trim()
            $v = $Matches.v.Trim()
            # Strip surrounding quotes
            if ($v -match '^".*"$' -or $v -match "^'.*'$") { $v = $v.Substring(1, $v.Length-2) }
            $data[$k] = $v
        } else {
            # Non-simple line; append to a special raw block (could extend later)
            $data['__raw'] = ($data['__raw'] + "`n" + $ln).Trim()
        }
    }
    return $data
}

function Convert-ToRfc3339Date {
    param([string]$Value)
    if (-not $Value) { return $null }
    try {
        $dt = Get-Date $Value -ErrorAction Stop
        return $dt.ToString('o')  # ISO 8601 / RFC3339
    } catch { return $null }
}

function New-HugoFrontMatterObject {
    param($Parsed, [string]$Slug)
    $out = [ordered]@{}
    if ($Parsed.title) { $out.title = $Parsed.title }
    else { $out.title = $Slug }

    $dateCandidate = $Parsed.date, $Parsed.publishDate, $Parsed.published_at | Where-Object { $_ } | Select-Object -First 1
        $normDate = Convert-ToRfc3339Date $dateCandidate
    if ($normDate) { $out.date = $normDate }

    $updatedCandidate = $Parsed.updated, $Parsed.lastModified, $Parsed.modified | Where-Object { $_ } | Select-Object -First 1
        $normLast = Convert-ToRfc3339Date $updatedCandidate
    if ($normLast -and $normLast -ne $normDate) { $out.lastmod = $normLast }

    if ($Parsed.tags) {
        # naive split by comma if present
        if ($Parsed.tags -match ',') { $out.tags = ($Parsed.tags -split ',').Trim() } else { $out.tags = @($Parsed.tags) }
    }
    if ($Parsed.categories) {
        if ($Parsed.categories -match ',') { $out.categories = ($Parsed.categories -split ',').Trim() } else { $out.categories = @($Parsed.categories) }
    }

    if ($Parsed.description) { $out.description = $Parsed.description }
    if ($Parsed.slug) { $out.slug = $Parsed.slug }

    # Draft logic: published:false OR draft:true
    if (($Parsed.published -and $Parsed.published -eq 'false') -or ($Parsed.draft -and $Parsed.draft -eq 'true')) {
        $out.draft = $true
    }

    # Preserve existing featuredimage ONLY if non-empty and not forcing regeneration
    if ($Parsed.featuredimage -and $Parsed.featuredimage.Trim()) {
        $out.featuredImage = $Parsed.featuredimage
    }

    return $out
}

function Convert-ToYamlText {
    param($Hash)
    $sb = New-Object System.Text.StringBuilder
    foreach ($k in $Hash.Keys) {
        $v = $Hash[$k]
        if ($v -is [System.Collections.IEnumerable] -and -not ($v -is [string])) {
            # sequence
            [void]$sb.AppendLine("${k}:")
            foreach ($item in $v) {
                [void]$sb.AppendLine("  - " + ($item -replace '"','\"'))
            }
        } elseif ($v -is [boolean]) {
            [void]$sb.AppendLine("${k}: " + ($v.ToString().ToLower()))
        } else {
            # Wrap if contains colon or leading/trailing spaces
            if ($v -match ':' -or $v -match '^[ \t]|[ \t]$') { $v = '"' + ($v -replace '"','\"') + '"' }
            [void]$sb.AppendLine("${k}: $v")
        }
    }
    return $sb.ToString().TrimEnd()
}

function Get-SlugFromFileName {
    param([string]$Path)
    return [IO.Path]::GetFileNameWithoutExtension($Path).ToLower()
}

# Remove common encoding artifacts (mis-decoded UTF-8 producing 'Â' before NBSP, lone NBSP, lone 'Â').
# Replaces them with a normal space and collapses runs of multiple spaces.
function Remove-EncodingArtifacts {
    param([string]$Text)
    if ($null -eq $Text -or $Text.Length -eq 0) { return $Text }
    $nbsp = [char]0x00A0      # NO-BREAK SPACE
    $bad  = [char]0x00C2      # 'Â' (often left from incorrect decoding of multi-byte sequences)
    # Replace specific bad sequences then individual leftovers.
    $Text = $Text -replace ([string]$bad + [string]$nbsp), ' '
    $Text = $Text -replace [string]$bad, ' '
    $Text = $Text -replace [string]$nbsp, ' '
    # Collapse multiple spaces created by substitutions
    $Text = $Text -replace ' {2,}', ' '
    return $Text
}

# (Removed legacy auto-install logic; rely solely on magick on PATH.)

# Generate a simple featured image from the SVG logo with a dark overlay background.
# Parameters:
#  -Slug <string> used for output filename: slug-featured.png
# Returns relative path (img/filename.png) if created or existing, otherwise $null.
function New-FeaturedImageIfMissing {
    param(
        [string]$Slug,
        [switch]$Force
    )
    Write-Verbose "[FeaturedImage] Entry Slug=$Slug Force=$Force"
    if (-not (Test-Path $LogoSvgPath)) { $Script:ImageStats.SkippedMissingLogo++ ; Write-Verbose '[FeaturedImage] Logo SVG missing; skipping.'; return $null }
    $outFileName = "$Slug-featured.png"
    $outFullPath = Join-Path $StaticImgDir $outFileName
    if ((Test-Path $outFullPath) -and -not $Force) { $Script:ImageStats.SkippedExisting++; Write-Verbose '[FeaturedImage] Existing image present; skipping generation.'; return "img/$outFileName" }

    # ImageMagick command: convert logo -> 1200x630 (social aspect), darken background
    # Approach: create a gradient dark background, composite centered SVG (scaled) with some transparency.
    $magickExe = $Script:MagickExe
    Write-Verbose "[FeaturedImage] Using ImageMagick executable: $magickExe"

    $tmpPng = Join-Path $env:TEMP ("$Slug-logo-temp.png")
    try {
        # Render SVG to a large PNG first (transparent) then composite onto background.
        # Using magick syntax; if only 'convert' exists it should still work for basic operations.
        $cmd1Args = @(
            $LogoSvgPath,
            '-resize','800x800',
            '-background','none',
            '-gravity','center',
            '-extent','800x800',
            $tmpPng
        )
    if (-not $DryRun) { Write-Verbose '[FeaturedImage] Rendering SVG -> PNG'; & $magickExe @cmd1Args 2>&1 | ForEach-Object { Write-Verbose "[magick] $_" } } else { Write-Verbose "[DryRun] Would run: $magickExe $($cmd1Args -join ' ')" }

    $bgSpec = 'gradient:#111111-#222222'
    Write-Verbose "[FeaturedImage] Applying darkening colorize at $FeaturedImageDarkenPercent%"

        $composeArgs = @(
            '-size','1200x630', $bgSpec,
            '-blur','0x8',
            '(',$tmpPng,'-resize','800x800','-gravity','center','-extent','800x800',')',
            '-gravity','center',
            '-compose','over','-composite',
            '-fill','black','-colorize',"$FeaturedImageDarkenPercent%",
            '-colorspace','sRGB',
            '-quality','90',
            $outFullPath
        )
    if (-not $DryRun) { Write-Verbose '[FeaturedImage] Compositing final image'; & $magickExe @composeArgs 2>&1 | ForEach-Object { Write-Verbose "[magick] $_" } } else { Write-Verbose "[DryRun] Would run: $magickExe $($composeArgs -join ' ')" }
    }
    catch {
    Write-Verbose "[FeaturedImage] Generation failed for $Slug : $($_.Exception.Message)"
        return $null
    }
    finally {
        if (Test-Path $tmpPng) { Remove-Item $tmpPng -ErrorAction SilentlyContinue }
    }

    if (Test-Path $outFullPath) { Write-Verbose "[FeaturedImage] Generated: $outFullPath"; $Script:ImageStats.Generated++; return "img/$outFileName" } else { Write-Verbose '[FeaturedImage] Output file missing after generation.'; return $null }
}

Test-FeaturedImagePrereqs

$allSource = Get-ChildItem -Path $SourceDir -Filter *.md -File | Sort-Object Name
if (-not $allSource) { Write-Warning "No markdown files found in $SourceDir"; return }

# Identify already migrated
$existing = Get-ChildItem -Path $DestDir -Filter *.md -File | ForEach-Object { $_.BaseName.ToLower() }

$toProcess = @()
foreach ($f in $allSource) {
    $slug = Get-SlugFromFileName $f.FullName
    $destPath = Join-Path $DestDir ($slug + '.md')
    $already = $existing -contains $slug
    if ($already -and -not $Overwrite) { continue }
    $toProcess += [PSCustomObject]@{ Source=$f.FullName; Slug=$slug; Dest=$destPath; Overwrite=$already }
}

if ($Limit -gt 0) { $toProcess = $toProcess | Select-Object -First $Limit }

if (-not $toProcess) { Write-Host 'Nothing to migrate (all posts already present or Limit resulted in zero).' -ForegroundColor Yellow; return }

$summary = @()

foreach ($item in $toProcess) {
    $raw = Get-Content -Path $item.Source -Raw
    $lines = $raw -split "`n"
    if ($lines[0].Trim() -ne '---') { Write-Warning "Skipping (no front matter): $($item.Source)"; continue }
    $idx = 1
    $fmLines = @()
    while ($idx -lt $lines.Length -and $lines[$idx].Trim() -ne '---') { $fmLines += $lines[$idx]; $idx++ }
    if ($idx -ge $lines.Length) { Write-Warning "Unterminated front matter in $($item.Source)"; continue }
    $body = ($lines[($idx+1)..($lines.Length-1)]) -join "`n"

    # --- Encoding artifact cleanup (common from legacy exports) ---
    $fmLines = $fmLines | ForEach-Object { Remove-EncodingArtifacts $_ }
    $body = Remove-EncodingArtifacts $body

    $parsed = Get-FrontMatterParsed -Lines $fmLines
    $front = New-HugoFrontMatterObject -Parsed $parsed -Slug $item.Slug

    # If no featuredImage (or regeneration requested) attempt generation.
    Write-Verbose "[Loop] Slug=$($item.Slug) ExistingFrontFeaturedImage=$($front.featuredImage) Regen=$RegenerateFeaturedImages"
    if ($RegenerateFeaturedImages -or -not $front.featuredImage) {
        Write-Verbose '[Loop] Triggering featured image generation call.'
        $relativeImage = New-FeaturedImageIfMissing -Slug $item.Slug -Force:($Overwrite)
        if ($relativeImage) { $front.featuredImage = $relativeImage; Write-Verbose "[Loop] Assigned featuredImage=$relativeImage" } else { Write-Verbose '[Loop] No image generated.' }
    } else { Write-Verbose '[Loop] Skipping generation (featuredImage already set and regeneration not requested).' }

    # Simple body cleanups - ensure unix newlines, trim trailing spaces
    $body = ($body -replace "\r","")
    $body = ($body -split "`n" | ForEach-Object { $_.TrimEnd() }) -join "`n"

    # Collapse any multiple spaces left by artifact removal
    $body = ($body -replace ' {2,}',' ')

    $yaml = Convert-ToYamlText -Hash $front
    $output = "---`n$yaml`n---`n`n$body`n"

    if (-not $DryRun) {
        Set-Content -Path $item.Dest -Value $output -Encoding UTF8
    }

    $summary += [PSCustomObject]@{
        Slug = $item.Slug
        Action = if ($item.Overwrite) { if ($Overwrite) { 'Overwritten' } else { 'Skipped' } } else { if ($DryRun) { 'WouldCreate' } else { 'Created' } }
        Source = $item.Source
        Dest = $item.Dest
    }
}

# Report
Write-Host "Migration Summary:" -ForegroundColor Cyan
$summary | Format-Table -AutoSize

$createdCount     = (@($summary | Where-Object { $_.Action -eq 'Created' })).Count
$overwrittenCount = (@($summary | Where-Object { $_.Action -eq 'Overwritten' })).Count
$skippedCount     = (@($summary | Where-Object { $_.Action -eq 'Skipped' })).Count
$wouldCount       = (@($summary | Where-Object { $_.Action -eq 'WouldCreate' })).Count

Write-Host "Totals => Created: $createdCount Overwritten: $overwrittenCount Skipped: $skippedCount Pending(DryRun): $wouldCount" -ForegroundColor Green

# Image generation summary (always show for clarity)
Write-Host ('Featured Images => Generated: {0} Existing: {1} MissingLogo: {2}' -f `
    $Script:ImageStats.Generated, $Script:ImageStats.SkippedExisting, $Script:ImageStats.SkippedMissingLogo) -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "Dry run complete. Re-run without -DryRun to apply." -ForegroundColor Yellow
}
