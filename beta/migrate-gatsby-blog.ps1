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
    [string[]]$IncludeSlugs,
    [switch]$DryRun,
    [switch]$Overwrite,
    [switch]$RegenerateFeaturedImages,
    [string]$FeaturedImageLogoPath,
    [ValidateRange(0,100)][int]$FeaturedImageDarkenPercent = 75,
    [int]$FeaturedImagePointSize = 90,
    [string]$FeaturedImageFontPath,
    [switch]$FeaturedImageSkipTitle,
    [bool]$FeaturedImageAutoScale,
    [int]$FeaturedImageMinPointSize = 60,
    [double]$FeaturedImageShortSplitBoost = 1.15,
    # Removed outline/halo features; keeping no additional styling params
    [switch]$FeaturedImageForceSingleLine,
    [ValidateSet('utf8','utf8bom')][string]$OutputEncoding = 'utf8'
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

# Default for autoscale if unspecified
if ($PSBoundParameters.ContainsKey('FeaturedImageAutoScale') -eq $false) { $FeaturedImageAutoScale = $true }

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
    $i = 0
    while ($i -lt $Lines.Length) {
        $ln = $Lines[$i]
        if ($ln -match '^[ \t]*#') { $i++; continue }
        if ($ln -match '^[ \t]*$') { $i++; continue }
        if ($ln -match '^(?<k>[A-Za-z0-9_-]+):\s*(?<v>.*)$') {
            $k = $Matches.k.Trim()
            $v = $Matches.v
            $vTrim = $v.Trim()
            # Edge case: explicit empty string "" or a stray opening quote treated as empty
            if ($vTrim -eq '""' -or $vTrim -eq '"') {
                $data[$k] = ''
                $i++; continue
            }
            if ($vTrim.StartsWith('"') -and -not $vTrim.EndsWith('"')) {
                # Begin multi-line quoted scalar – accumulate until closing quote
                $acc = @($vTrim.Substring(1))
                $i++
                while ($i -lt $Lines.Length) {
                    $next = $Lines[$i]
                    if ($next.TrimEnd().EndsWith('"')) {
                        $acc += $next.TrimEnd().Substring(0, $next.TrimEnd().Length-1)
                        break
                    } else {
                        $acc += $next
                    }
                    $i++
                }
                if ($i -ge $Lines.Length -and -not ($Lines[$i-1].TrimEnd().EndsWith('"'))) {
                    Write-Verbose "[FrontMatter] Unterminated quoted value for '$k' auto-closed." -Verbose
                }
                # Collapse internal runs of space produced by line wrapping; treat embedded line breaks as spaces
                $joined = ($acc -join ' ')
                $joined = $joined -replace '\s{2,}',' '
                $data[$k] = $joined.Trim()
            } else {
                # Single-line value
                $val = $vTrim
                if ($val -match '^".*"$' -or $val -match "^'.*'$") { $val = $val.Substring(1, $val.Length-2) }
                $data[$k] = $val
            }
        } else {
            $data['__raw'] = ($data['__raw'] + "`n" + $ln).Trim()
        }
        $i++
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

# Normalize title text by removing mojibake euro+quote artifacts, ensuring balanced quotes,
# and stripping stray unmatched leading/trailing quotes. Falls back to removing all double
# quotes if an odd count remains after cleanup (prevents YAML parse ambiguity in plain scalars).
function Normalize-Title {
    param([string]$Text)
    if (-not $Text) { return $Text }
    $original = $Text
    # Reuse encoding cleanup for consistency (safe idempotent)
    $Text = Remove-EncodingArtifacts $Text
    $euro = [char]0x20AC
    # Remove raw euro signs and common euro+quote combinations
    $Text = $Text -replace ([string]$euro + '"'), '"'
    $Text = $Text -replace ([string]$euro + "'"), "'"
    $Text = $Text -replace ([string]$euro), ''
    # Normalize curly quotes (defensive – Remove-EncodingArtifacts already handles many)
    $Text = $Text -replace '[\u201C\u201D]', '"'
    $Text = $Text -replace '[\u2018\u2019]', "'"
    # Collapse repeated quotes
    $Text = $Text -replace '"{2,}', '"'
    $Text = $Text -replace "'{2,}", "'"
    # If we still have an odd number of double quotes, strip them all (better no quotes than broken YAML)
    $dqCount = ([regex]::Matches($Text,'"')).Count
    if ($dqCount % 2 -eq 1) { $Text = $Text -replace '"','' }
    # Remove isolated leading/trailing quotes/apostrophes and any embedded newlines (should be single line)
    $Text = $Text -replace "[\r\n]+"," "
    $Text = $Text.Trim()
    $Text = $Text.Trim('"')
    $Text = $Text.Trim("'")
    # Remove any residual double spaces created
    $Text = $Text -replace '\s{2,}',' '
    $Text = $Text.Trim()
    if ($Text -ne $original -and $VerbosePreference -ne 'SilentlyContinue') {
        Write-Verbose "[TitleCleanup] BEFORE='$original' AFTER='$Text'"
    }
    return $Text
}

function New-HugoFrontMatterObject {
    param($Parsed, [string]$Slug)
    $out = [ordered]@{}
    if ($Parsed.title) { $out.title = Normalize-Title $Parsed.title }
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

    if (-not (Get-Command Sanitize-Description -ErrorAction SilentlyContinue)) {
        function Sanitize-Description {
            param([string]$Text)
            if (-not $Text) { return $Text }
            $orig = $Text
            # Remove all asterisks which can be interpreted by YAML as alias markers when at start (e.g. *Lazy becomes error)
            $Text = $Text -replace '\*',''
            # If description begins with a single quote and has no closing single quote, strip it
            if ($Text -match "^'[^']*$") { $Text = $Text.Substring(1) }
            # If description begins with a double quote and has no closing double quote, strip it
            if ($Text -match '^"[^"]*$') { $Text = $Text.Substring(1) }
            # Collapse whitespace created by removals
            $Text = $Text -replace '\s{2,}',' ' -replace '^[ \t]+|[ \t]+$',''
            if ($orig -ne $Text -and $VerbosePreference -ne 'SilentlyContinue') { Write-Verbose "[DescAsterisk] Cleaned asterisks from description" }
            return $Text
        }
    }
    if ($Parsed.description) { $out.description = Sanitize-Description (Normalize-DescriptionBrackets $Parsed.description) }
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

# Remove square brackets around standalone word/phrase tokens in description
function Normalize-DescriptionBrackets {
    param([string]$Text)
    if (-not $Text) { return $Text }
    $original = $Text
    # Pattern: [Some Words] (no nested brackets inside). Avoid touching markdown links like [text](url) by only replacing when followed by space, punctuation or end.
    # We'll iteratively replace to handle multiple occurrences.
        # First ensure a space exists before a bracketed token when it is jammed against a word: e.g. 'has[source' -> 'has [source'
        $Text = [regex]::Replace($Text, '(?<=[A-Za-z])\[(?=[A-Za-z])', ' [')
        # Pattern: [Some Words] (no nested brackets). Avoid markdown links: require that immediately after closing ] we are NOT followed by '('.
        $pattern = '\[(?<w>[^\[\]\n]+?)\](?!\()'
        $Text = [regex]::Replace($Text, $pattern, { param($m) $m.Groups['w'].Value })
        # Collapse any runs of multiple spaces created by removals
        $Text = $Text -replace ' {2,}', ' '
        # Fix specific 'has source' adjacency if still joined (defensive)
        $Text = $Text -replace 'hassource','has source'
        # Trim overall
        $Text = $Text.Trim()
    if ($Text -ne $original -and $VerbosePreference -ne 'SilentlyContinue') {
        Write-Verbose "[DescCleanup] Bracket simplification: BEFORE='$original' AFTER='$Text'"
    }
    return $Text
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
    # Additional mis-encoded apostrophe/quote artifacts observed in migrated content:
    #   The sequence '€™' (Euro sign + right single quotation mark) appears where an apostrophe should be.
    #   Occasionally just '€™' (right single quotation mark with leading stray character removed earlier) may remain.
    # We'll normalize these to a plain ASCII apostrophe to avoid rendering issues in Hugo themes and search.
    $rsquo = [char]0x2019     # RIGHT SINGLE QUOTATION MARK (’)
    $euro  = [char]0x20AC     # EURO SIGN (€) (part of the bad sequence)
    $tm    = [char]0x2122     # TRADE MARK SIGN (™) sometimes paired as €™ for apostrophe
    $ldquo = [char]0x201C     # LEFT DOUBLE QUOTATION MARK (“)
    $rdquo = [char]0x201D     # RIGHT DOUBLE QUOTATION MARK (”)
    $lsquo = [char]0x2018     # LEFT SINGLE QUOTATION MARK (‘)
    $ctrlOpen  = [char]0x009C # Control char sometimes standing in for opening curly quote when prefixed by €
    $ctrlClose = [char]0x009D # Control char sometimes standing in for closing curly quote when prefixed by €
    $oeChar    = [char]0x0153 # œ character appearing in mojibake for opening quote (as in €œkeyword)
    # Replace specific bad sequences then individual leftovers.
    $Text = $Text -replace ([string]$bad + [string]$nbsp), ' '
    $Text = $Text -replace [string]$bad, ' '
    $Text = $Text -replace [string]$nbsp, ' '
    # Normalize euro+rsquo and plain rsquo to straight apostrophe
    $before = $Text
    $Text = $Text -replace ([string]$euro + [string]$rsquo), "'" # €’
    $Text = $Text -replace ([string]$euro + [string]$tm), "'"     # €™
    $Text = $Text -replace [string]$rsquo, "'"
    # Normalize curly single quotes (left) too
    $Text = $Text -replace [string]$lsquo, "'"
    # Replace euro+control/oe sequences that represent curly double quotes with straight quotes
    $Text = $Text -replace ([string]$euro + [string]$ctrlOpen), '"'
    $Text = $Text -replace ([string]$euro + [string]$ctrlClose), '"'
    $Text = $Text -replace ([string]$euro + [string]$oeChar), '"'
    # Standalone œ preceding letters (opening quote) -> replace and remove leading space if any
    $Text = $Text -replace ([string]$oeChar + '([A-Za-z])'), '"$1'
    # Remove stray euro before letters now that intended quote forms handled
    $Text = $Text -replace ("$euro([A-Za-z])"), '$1'
    # Normalize remaining curly double quotes to straight quotes
    $Text = $Text -replace [string]$ldquo, '"'
    $Text = $Text -replace [string]$rdquo, '"'
    if ($VerbosePreference -ne 'SilentlyContinue') {
        $diffCount = (
            [regex]::Matches($before, [regex]::Escape([string]$euro + [string]$rsquo)).Count +
            [regex]::Matches($before, [regex]::Escape([string]$euro + [string]$tm)).Count +
            [regex]::Matches($before, [regex]::Escape([string]$rsquo)).Count
        )
        if ($diffCount -gt 0) { Write-Verbose "[Cleanup] Replaced $diffCount curly/euro apostrophes" }
    }
    # Collapse multiple spaces created by substitutions
    $Text = $Text -replace ' {2,}', ' '
    # General rule: word + space + ' + common contraction ending => collapse space.
    $Text = $Text -replace "\b([A-Za-z]+) +'(m|re|s|ve|ll|d|t)\b", '$1''$2'
    # Now repair specific irregular negatives where previous rule produced e.g. ca't instead of can't.
    $Text = $Text -replace "\b[Cc]a't\b", "can't"
    $Text = $Text -replace "\b[Ww]o't\b", "won't"
    $Text = $Text -replace "\b[Dd]o't\b", "don't"
    $Text = $Text -replace "\b[Ss]ha't\b", "shan't"
    # Remove spaces before basic sentence-ending punctuation but PRESERVE before opening quotes
    $Text = $Text -replace ' +([,!?.;:])', '$1'
    # Ensure a space before a quote starting a word if missing (e.g. this"keyword" -> this "keyword")
    $Text = $Text -replace '(\w)"(\w)', '$1 "$2'
    # Remove accidental space before closing quote ("keyword " -> "keyword")
    $Text = $Text -replace '"([^"]+?)\s+"', '"$1"'
    # Normalize duplicated quotes
    $Text = $Text -replace '"{2,}', '"'
    return $Text
}

# Attempt to restore mojibake'd UTF-8 emoji sequences that were decoded as Windows-1252 then
# carried through content (e.g. 'ðŸ˜' for '😁', 'œï¸' fragment of '✍️').
# Strategy:
#  1. Heuristic pre-fix: insert missing leading 'â' for certain E2 byte triplets that were partially stripped.
#  2. If patterns indicative of mojibake appear ("ðŸ" or variation selector trail 'ï¸'), re-encode text as Windows-1252 bytes
#     and decode as UTF-8 to reconstruct original emoji (round-trip reversal of the mojibake path).
#  3. Return original text if no triggers found or conversion yields obviously worse result.
function Restore-EmojiMojibake {
    param([string]$Text)
    if ([string]::IsNullOrEmpty($Text)) { return $Text }
    if ($Text -notmatch 'ðŸ' -and $Text -notmatch 'ï¸' -and $Text -notmatch 'œï¸' -and $Text -notmatch 'œˆï¸') { return $Text }

    $original = $Text
    # Reconstruct missing leading 'â' before common multi-byte emoji sequences that lost first byte (E2) but retained tail
    $Text = $Text -replace '(?<!â)œï¸','âœï¸'   # ✍️ (writing hand)
    $Text = $Text -replace '(?<!â)œˆï¸','âœˆï¸'   # ✈️ (airplane)

    try {
        $win1252 = [System.Text.Encoding]::GetEncoding(1252)
        $utf8    = [System.Text.Encoding]::UTF8
        $bytes   = $win1252.GetBytes($Text)
        $roundTrip = $utf8.GetString($bytes)
        # If roundTrip now contains actual emoji while original had mojibake sequences, accept it.
        $hadMojibake = ($original -match 'ðŸ') -or ($original -match 'œï¸') -or ($original -match 'œˆï¸')
        $hasEmojiNow = $roundTrip -match '[\x{2600}-\x{27BF}\x{1F300}-\x{1FAFF}]'
        if ($hadMojibake -and $hasEmojiNow) {
            if ($VerbosePreference -ne 'SilentlyContinue') { Write-Verbose "[EmojiRestore] Restored emoji in text segment" }
            return $roundTrip
        }
    } catch {
        # Silently ignore and fall back
    }
    return $original
}

# (Removed legacy auto-install logic; rely solely on magick on PATH.)

# Generate a simple featured image from the SVG logo with a dark overlay background.
# Parameters:
#  -Slug <string> used for output filename: slug-featured.png
# Returns relative path (img/filename.png) if created or existing, otherwise $null.
function New-FeaturedImageIfMissing {
    param(
        [string]$Slug,
        [string]$Title,
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

    # Start from a white canvas but apply a uniform darkening (colorize) so the result is a mid/dark neutral background
    $bgSpec = 'canvas:white'
    Write-Verbose "[FeaturedImage] White base background; will apply ${FeaturedImageDarkenPercent}% dark overlay"

        $captionPng = $null
        # Build in stages so we can darken AFTER the logo composite (ensuring logo area is also darkened)
        $composeArgs = @(
            '-size','1200x630', $bgSpec,
            '(',$tmpPng,'-resize','800x800','-gravity','center','-extent','800x800',')',
            '-gravity','center','-compose','over','-composite'
        )
        # Apply dark overlay now (uniform) so logo + background both darken. Using colorize with the configured percent.
        $composeArgs += @('-fill','black','-colorize',"$FeaturedImageDarkenPercent%")
        # Optional: add a subtle additional semi-transparent black rectangle to improve text legibility on very light logos.
        $composeArgs += @('(', '-size','1200x630','canvas:none','-fill','black','-alpha','set','-channel','A','-evaluate','set','30%','+channel',')','-gravity','center','-compose','over','-composite')

        if (-not $FeaturedImageSkipTitle -and $Title) {
            $captionFile = Join-Path $env:TEMP ("$Slug-caption.txt")
            # Auto split logic: prefer 2 lines if long single line and not forced single line.
            $workTitle = $Title
            $effectivePointSize = $FeaturedImagePointSize
            $plain = $Title.Trim()
            $wordCount = ($plain -split ' ').Count
            if (-not $FeaturedImageForceSingleLine) {
                $needsSplit = $false
                if ($plain.Length -gt 38 -or $wordCount -gt 7) { $needsSplit = $true }
                if ($needsSplit) {
                    $words = $plain -split ' '
                    $total = $words.Count
                    $bestIdx = 0; $bestScore = 9999
                    for ($i=1; $i -lt $total; $i++) {
                        $leftLen = ($words[0..($i-1)] -join ' ').Length
                        $rightLen = ($words[$i..($total-1)] -join ' ').Length
                        $diff = [math]::Abs($leftLen - $rightLen)
                        if ($diff -lt $bestScore) { $bestScore = $diff; $bestIdx = $i }
                    }
                    if ($bestIdx -gt 0 -and $bestIdx -lt $total) {
                        $line1 = ($words[0..($bestIdx-1)] -join ' ')
                        $line2 = ($words[$bestIdx..($total-1)] -join ' ')
                        $workTitle = "$line1`n$line2"
                        Write-Verbose "[FeaturedImage] Split title: '$line1' | '$line2' (diff=$bestScore)"
                    }
                } elseif ($wordCount -ge 3) {
                    # Short title split rule: split after first two words to allow larger font
                    $words = $plain -split ' '
                    if ($words.Count -ge 3) {
                        $line1 = ($words[0..1] -join ' ')
                        $line2 = ($words[2..($words.Count-1)] -join ' ')
                        $workTitle = "$line1`n$line2"
                        Write-Verbose "[FeaturedImage] Short-title forced split: '$line1' | '$line2'"
                        $effectivePointSize = [int]([math]::Min([math]::Floor($FeaturedImagePointSize * $FeaturedImageShortSplitBoost), $FeaturedImagePointSize * 1.3))
                    }
                }
            }
            if ($FeaturedImageAutoScale) {
                # Reduce font size for longer titles (approx heuristic)
                $len = $plain.Length
                if ($len -gt 55) { $effectivePointSize = [math]::Max($FeaturedImageMinPointSize, [int]($FeaturedImagePointSize * 0.70)) }
                elseif ($len -gt 48) { $effectivePointSize = [math]::Max($FeaturedImageMinPointSize, [int]($FeaturedImagePointSize * 0.78)) }
                elseif ($len -gt 40) { $effectivePointSize = [math]::Max($FeaturedImageMinPointSize, [int]($FeaturedImagePointSize * 0.85)) }
                Write-Verbose "[FeaturedImage] Auto-scale length=$len wordCount=$wordCount pointSize=$effectivePointSize"
            }
            $escaped = $workTitle -replace '"','\\"'
            Set-Content -Path $captionFile -Value $escaped -Encoding UTF8
            $captionPng = Join-Path $env:TEMP ("$Slug-caption.png")
            $fontArgs = @()
            $resolvedFont = $null
            if ($FeaturedImageFontPath) {
                $resolvedFont = $FeaturedImageFontPath
            } else {
                    # Normalize euro+oeLike and euro+ctrl9D to straight double quotes
                    $Text = $Text -replace ([string]$euro + 'œ'), '"'          # €œ
                    $Text = $Text -replace ([string]$euro + [char]0x009D), '"'  # €<0x9D>
                # Attempt Roboto Bold first (preferred)
                $fontDir = Join-Path $env:WINDIR 'Fonts'
                $robotoFound = $null
                try {
                    $allRoboto = Get-ChildItem -Path $fontDir -Filter 'Roboto*Bold*.ttf' -ErrorAction SilentlyContinue
                    if (-not $allRoboto) { $allRoboto = Get-ChildItem -Path $fontDir -Filter 'Roboto*Bold*.otf' -ErrorAction SilentlyContinue }
                    if (-not $allRoboto) {
                        $userFontDir = Join-Path $env:LOCALAPPDATA 'Microsoft/Windows/Fonts'
                        if (Test-Path $userFontDir) {
                            $allRoboto = Get-ChildItem -Path $userFontDir -Filter 'Roboto*Bold*.ttf' -ErrorAction SilentlyContinue
                            if (-not $allRoboto) { $allRoboto = Get-ChildItem -Path $userFontDir -Filter 'Roboto*Bold*.otf' -ErrorAction SilentlyContinue }
                            if ($allRoboto) { Write-Verbose "[FeaturedImage] Found Roboto Bold variants in user fonts directory." }
                        }
                    }
                    if ($allRoboto) {
                        # Prefer pure Bold before condensed/extra/semi variants
                        $exact = $allRoboto | Where-Object { $_.Name -match '^Roboto-Bold\.ttf$' } | Select-Object -First 1
                        if (-not $exact) { $exact = $allRoboto | Where-Object { $_.Name -match '^Roboto-Bold\.' } | Select-Object -First 1 }
                        if ($exact) { $robotoFound = $exact.FullName } else { $robotoFound = ($allRoboto | Select-Object -First 1).FullName }
                        Write-Verbose "[FeaturedImage] Roboto candidates: $($allRoboto.Name -join ', ') Selected: $(Split-Path $robotoFound -Leaf)"
                    }
                } catch { Write-Verbose '[FeaturedImage] Exception while searching for Roboto fonts.' }
                if ($robotoFound) {
                    $resolvedFont = $robotoFound
                } else {
                    if (-not $Script:RobotoPrompted) {
                        Write-Warning 'Roboto Bold font not resolved by file path. Will attempt family name fallback ("Roboto-Bold"). If rendering still uses a different font, ensure Roboto is properly installed for all users.'
                        $Script:RobotoPrompted = $true
                    }
                    # Try using family name directly (ImageMagick will look up via font configuration)
                    $resolvedFont = 'Roboto-Bold'
                    # If that still fails, fallback to Segoe UI path later when verifying existence
                    if ($resolvedFont -ne 'Roboto-Bold' -and -not (Test-Path $resolvedFont)) {
                        $resolvedFont = $null
                    }
                    if ($resolvedFont -eq 'Roboto-Bold') {
                        # We keep it; if ImageMagick cannot resolve, it will warn but proceed.
                    }
                    if (-not $robotoFound) {
                        $segoeCandidate = Join-Path $fontDir 'segoeui.ttf'
                        if ((-not $robotoFound) -and (Test-Path $segoeCandidate)) { $fallbackSeg = $segoeCandidate }
                        if ($fallbackSeg -and $resolvedFont -ne 'Roboto-Bold') { $resolvedFont = $fallbackSeg }
                    }
                }
            }
            if ($resolvedFont) {
                Write-Verbose "[FeaturedImage] Using font: $resolvedFont"
                # Ensure path uses backslashes and is quoted if it has spaces
                # Use forward slashes (ImageMagick accepts them on Windows) and avoid quoting here; PowerShell passes as a single arg.
                $safeFontPath = $resolvedFont -replace '\\','/'
                $fontArgs += @('-font', $safeFontPath)
            } else {
                Write-Verbose '[FeaturedImage] No custom font specified/found; using ImageMagick default.'
            }
            $captionArgs = @(
                '-background','none',
                '-fill','white',
                '-gravity','center',
                '-size','1100x550',
                '-pointsize', $effectivePointSize,
                @($fontArgs),
                "caption:@$captionFile",
                $captionPng
            )
            Write-Verbose '[FeaturedImage] Rendering caption text'
            if (-not $DryRun) { & $magickExe @captionArgs 2>&1 | ForEach-Object { Write-Verbose "[magick] $_" } } else { Write-Verbose "[DryRun] Would run: $magickExe $($captionArgs -join ' ')" }
            if (Test-Path $captionPng) {
                # Normalize caption canvas to ensure vertical centering regardless of line count
                $centeredPng = Join-Path $env:TEMP ("$Slug-caption-centered.png")
                $normalizeArgs = @(
                    $captionPng,
                    '-trim','+repage',
                    '-gravity','center',
                    '-background','none',
                    '-extent','1100x550',
                    $centeredPng
                )
                if (-not $DryRun) { Write-Verbose '[FeaturedImage] Centering caption block'; & $magickExe @normalizeArgs 2>&1 | ForEach-Object { Write-Verbose "[magick] $_" } } else { Write-Verbose "[DryRun] Would run: $magickExe $($normalizeArgs -join ' ')" }
                if (Test-Path $centeredPng) { Remove-Item $captionPng -ErrorAction SilentlyContinue; $captionPng = $centeredPng }
                # Simple direct composite of white caption (previous style)
                $composeArgs += @('(',$captionPng,')','-gravity','center','-compose','over','-composite')
            }
        }

        # finalize arguments
        $composeArgs += @(
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
        if (Test-Path $captionPng) { Remove-Item $captionPng -ErrorAction SilentlyContinue }
        if (Test-Path $captionFile) { Remove-Item $captionFile -ErrorAction SilentlyContinue }
    }

    if (Test-Path $outFullPath) { Write-Verbose "[FeaturedImage] Generated: $outFullPath"; $Script:ImageStats.Generated++; return "img/$outFileName" } else { Write-Verbose '[FeaturedImage] Output file missing after generation.'; return $null }
}

# Ensure final file has no trailing blank lines (only one terminating newline)
function Normalize-FinalFileNewline {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return }
    try {
        $content = Get-Content -Path $Path -Raw -ErrorAction Stop
        # Normalize CRLF -> LF for processing
        $content = $content -replace '\r',''

        # If file was accidentally written with literal "\n" sequences instead of real newlines
        # (detected by presence of "\\n" AND very few actual LF characters) repair it.
        $actualLfCount = ([regex]::Matches($content, "\n")).Count
        $literalSeqCount = ([regex]::Matches($content, "\\n")).Count
        if ($literalSeqCount -gt 0 -and $actualLfCount -le 1) {
            $content = $content -replace '\\n', "`n"
        }

        # Split and trim trailing blank/whitespace-only lines using real newline
        $lines = $content -split "`n"
        while ($lines.Length -gt 0 -and ($lines[-1] -match '^[ \t]*$')) { $lines = $lines[0..($lines.Length-2)] }
        $normalized = ($lines -join "`n") + "`n"
        # Only rewrite if changed
        if ($normalized -ne $content) {
            Set-Content -Path $Path -Value $normalized -Encoding UTF8
            Write-Verbose "[Normalize] Adjusted trailing newlines for $Path"
        }
    } catch {
        Write-Verbose "[Normalize] Skipped (error reading $Path): $($_.Exception.Message)"
    }
}

# Safely remove leading and trailing blank/whitespace-only lines from an array of lines.
function Remove-LeadingTrailingBlankLines {
    param([string[]]$Lines)
    if (-not $Lines -or $Lines.Count -eq 0) { return @() }
    $start = 0
    $end = $Lines.Count - 1
    while ($start -le $end -and [string]::IsNullOrWhiteSpace($Lines[$start])) { $start++ }
    while ($end -ge $start -and [string]::IsNullOrWhiteSpace($Lines[$end])) { $end-- }
    if ($end -lt $start) { return @() }
    return $Lines[$start..$end]
}

                        if ($resolvedFont -eq 'Roboto-Bold') {
                            # Create temporary type.xml mapping if not already recognized to help ImageMagick
                            $fontDir = Join-Path $env:WINDIR 'Fonts'
                            $boldFile = Get-ChildItem -Path $fontDir -Filter 'Roboto-Bold.ttf' -ErrorAction SilentlyContinue | Select-Object -First 1
                            if ($boldFile) {
                                $typeXml = Join-Path $env:TEMP 'roboto-type.xml'
                                if (-not (Test-Path $typeXml)) {
                                    "<?xml version='1.0' encoding='UTF-8'?>`n<!DOCTYPE typemap SYSTEM 'urn:magick:typemap'>`n<typemap>`n  <type name='Roboto' fullname='Roboto Bold' family='Roboto' style='Normal' weight='700' stretch='Normal' format='ttf' glyphs='$($boldFile.FullName -replace '\\','/')' />`n</typemap>" | Set-Content -Path $typeXml -Encoding UTF8
                                    Write-Verbose "[FeaturedImage] Generated temporary font mapping: $typeXml"
                                }
                                $env:MAGICK_FONT_PATH = "$($boldFile.DirectoryName);$env:MAGICK_FONT_PATH"
                                Write-Verbose "[FeaturedImage] Updated MAGICK_FONT_PATH to include: $($boldFile.DirectoryName)"
                            }
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
    if ($IncludeSlugs -and ($IncludeSlugs -notcontains $slug)) { continue }
    if ($already -and -not $Overwrite) { continue }
    $toProcess += [PSCustomObject]@{ Source=$f.FullName; Slug=$slug; Dest=$destPath; Overwrite=$already }
}

if ($Limit -gt 0) { $toProcess = $toProcess | Select-Object -First $Limit }

if (-not $toProcess) { Write-Host 'Nothing to migrate (all posts already present or Limit resulted in zero).' -ForegroundColor Yellow; return }

$summary = @()

foreach ($item in $toProcess) {
    # Read source with explicit UTF-8 to preserve emoji (avoid locale-dependent default encoding)
    try {
        $raw = Get-Content -Path $item.Source -Raw -Encoding UTF8
    } catch {
        Write-Verbose "[Read] UTF8 explicit read failed for $($item.Source); falling back to default encoding." ; $raw = Get-Content -Path $item.Source -Raw
    }
    $lines = $raw -split "`n"
    if ($lines[0].Trim() -ne '---') { Write-Warning "Skipping (no front matter): $($item.Source)"; continue }
    $idx = 1
    $fmLines = @()
    while ($idx -lt $lines.Length -and $lines[$idx].Trim() -ne '---') { $fmLines += $lines[$idx]; $idx++ }
    if ($idx -ge $lines.Length) { Write-Warning "Unterminated front matter in $($item.Source)"; continue }
    $body = ($lines[($idx+1)..($lines.Length-1)]) -join "`n"

    # --- Encoding artifact cleanup (common from legacy exports) ---
    $fmLines = $fmLines | ForEach-Object { Restore-EmojiMojibake (Remove-EncodingArtifacts $_) }
    $body = Restore-EmojiMojibake (Remove-EncodingArtifacts $body)

    $parsed = Get-FrontMatterParsed -Lines $fmLines
    $front = New-HugoFrontMatterObject -Parsed $parsed -Slug $item.Slug

    # Additional description spacing fix: ensure space before an opening quote if jammed against word (e.g., that"Longhorn")
    if ($front.description) {
        $beforeDesc = $front.description
        $front.description = $front.description -replace '(?<=\w)"(?=\w)', ' "'
        # Ensure space after closing quote if followed immediately by a word ("Longhorn"Beta -> "Longhorn" Beta)
        $front.description = $front.description -replace '"(?=\w)', '" '
        # Remove spaces just inside quotes: " Longhorn " -> "Longhorn"
        $front.description = $front.description -replace '" +([^"].*?[^" ]) +"', '"$1"'
        $front.description = $front.description -replace ' {2,}', ' ' -replace '\s+$',''
        if ($beforeDesc -ne $front.description -and $VerbosePreference -ne 'SilentlyContinue') { Write-Verbose "[DescSpacing] BEFORE='$beforeDesc' AFTER='$($front.description)'" }
    }

    # Treat placeholder/default image as absent so we generate a proper title image
    $isPlaceholderImage = $false
    if ($front.featuredImage -and ($front.featuredImage -match 'default-post-image\.jpg$')) {
        Write-Verbose '[Loop] Detected placeholder featured image (default-post-image.jpg); will regenerate.'
        $front.featuredImage = $null
        $isPlaceholderImage = $true
    }

    # If no featuredImage, placeholder, or regeneration requested attempt generation.
    Write-Verbose "[Loop] Slug=$($item.Slug) ExistingFrontFeaturedImage=$($front.featuredImage) Regen=$RegenerateFeaturedImages Placeholder=$isPlaceholderImage"
    if ($RegenerateFeaturedImages -or -not $front.featuredImage) {
        Write-Verbose '[Loop] Triggering featured image generation call.'
    $relativeImage = New-FeaturedImageIfMissing -Slug $item.Slug -Title $front.title -Force:($Overwrite)
        if ($relativeImage) { $front.featuredImage = $relativeImage; Write-Verbose "[Loop] Assigned featuredImage=$relativeImage" } else { Write-Verbose '[Loop] No image generated.' }
    } else { Write-Verbose '[Loop] Skipping generation (featuredImage already set and regeneration not requested).' }

    # Simple body cleanups - ensure unix newlines, trim trailing spaces
    $body = ($body -replace "\r","")
    $body = ($body -split "`n" | ForEach-Object { $_.TrimEnd() }) -join "`n"

    # Remove fragment marker lines
    $body = ($body -split "`n" | Where-Object { $_ -notmatch '^[ \t]*<!--(StartFragment|EndFragment)-->[ \t]*$' }) -join "`n"

    # Collapse any multiple spaces left by artifact removal
    $body = ($body -replace ' {2,}',' ')

    # Fix missing space before 'on[Word' patterns (')on[WindowsAdvice' -> ') on [WindowsAdvice')
    $beforeBody = $body
    $body = $body -replace '\)(on)\[', ') $1 ['
    # Ensure space before a link if preceding char is a letter (word)[Link]
    $body = $body -replace '(?<=\w)\[', ' ['
    # Ensure space after closing bracket of markdown link if immediately followed by a word char
    $body = $body -replace '\](?=\w)', '] '
    if ($beforeBody -ne $body -and $VerbosePreference -ne 'SilentlyContinue') { Write-Verbose "[BodySpacing] Adjusted spacing around links for slug $($item.Slug)" }

    # Normalize trailing blank lines to a single newline at EOF
    $body = $body.TrimEnd()

    # Remove leading and trailing blank lines from body section itself (robust against single-line bodies)
        $bodyLines = $body -split "`n"
        $bodyLines = Remove-LeadingTrailingBlankLines -Lines $bodyLines
        $body = $bodyLines -join "`n"

    # After join, ensure we do not leave a trailing blank line inside body (which would appear before EOF once final newline added)
    while ($body -match "`n$" -and $body.EndsWith("`n")) { $body = $body.TrimEnd() }

    # Remove orphan trailing code fence (``` ) if present without preceding opening fence content (artifact from legacy export)
    $bodyLines = $body -split "`n"
    if ($bodyLines.Length -gt 0 -and $bodyLines[-1].Trim() -eq '```') {
        $fenceCount = ($bodyLines | Where-Object { $_.Trim() -eq '```' }).Count
        if ($fenceCount -eq 1 -or ($fenceCount % 2 -eq 1)) {
            $bodyLines = $bodyLines[0..($bodyLines.Length-2)]
            # Trim any new trailing blank lines after removal
            while ($bodyLines.Length -gt 0 -and $bodyLines[-1].Trim() -eq '') { $bodyLines = $bodyLines[0..($bodyLines.Length-2)] }
            $body = ($bodyLines -join "`n").TrimEnd()
        }
    }

    # Final trim: ensure no trailing blank lines remain
    $bodyLines = $body -split "`n"
    $bodyLines = Remove-LeadingTrailingBlankLines -Lines $bodyLines
    $body = $bodyLines -join "`n"

    $yaml = Convert-ToYamlText -Hash $front
    # Assemble final markdown ensuring:
    #  - Front matter delimited by ---
    #  - Single blank line separating front matter from body (only if body exists)
    #  - Exactly one terminating newline at EOF (no extra blank line after content)
    $yamlBlock = "---`n$yaml`n---"
    if (-not [string]::IsNullOrWhiteSpace($body)) {
        # Remove any trailing newline characters from body so we control exactly one at EOF
        $body = $body -replace "[\r\n]+$",""
    }
    if ([string]::IsNullOrWhiteSpace($body)) {
        $output = "$yamlBlock`n"  # front matter only, ensure trailing newline
    } else {
        $output = "$yamlBlock`n`n$body`n"  # exactly one blank after front matter; body then single EOF newline
    }
    # Normalize to LF then to desired final form (keep LF internally, write via Set-Content which will use CRLF on Windows if needed)
    $output = $output -replace "\r\n?", "`n"

    if (-not $DryRun) {
        if ($OutputEncoding -eq 'utf8') {
            # PowerShell 7+ supports -Encoding utf8 (without BOM). On Windows PowerShell this maps to BOM UTF8.
            Set-Content -Path $item.Dest -Value $output -Encoding utf8
        } else {
            Set-Content -Path $item.Dest -Value $output -Encoding utf8BOM
        }
        # Final pass normalization
        Normalize-FinalFileNewline -Path $item.Dest
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
