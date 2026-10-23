<#
.SYNOPSIS
Reports .gitattributes patterns that send a text serialized Unity asset through Git LFS.

.DESCRIPTION
An asset in LFS is a pointer file to Git: no diff, no three way merge, no UnityYAMLMerge.
Under Asset Serialization "Force Text" the Unity asset types listed below are YAML text and
must stay out of LFS. Run this in your project root after copying or editing .gitattributes.

Exit codes: 0 clean, 1 findings, 2 file not found.

.EXAMPLE
pwsh -File check-gitattributes.ps1
pwsh -File check-gitattributes.ps1 -Path ProjectTemplateFiles/.gitattributes.template
#>
param([string]$Path = '.gitattributes')

# Unity writes these as YAML text when Asset Serialization is Force Text.
$textAssets = @(
    'unity', 'prefab', 'meta', 'asset', 'mat', 'anim', 'controller', 'overrideController',
    'physicMaterial', 'physicsMaterial2D', 'mask', 'playable', 'mixer', 'preset',
    'renderTexture', 'spriteatlas', 'terrainlayer', 'shadervariants', 'fontsettings', 'lighting'
)

# Binary by design even under Force Text, so LFS is correct for these (Unity issue 1211605).
$binaryExceptions = @('LightingData.asset', 'NavMesh.asset')

if (-not (Test-Path -LiteralPath $Path)) {
    Write-Host "check-gitattributes: no such file: $Path"
    exit 2
}

$findings = @()
$lineNumber = 0

foreach ($line in Get-Content -LiteralPath $Path) {
    $lineNumber++
    $trimmed = $line.Trim()
    if ($trimmed -eq '' -or $trimmed.StartsWith('#') -or $trimmed.StartsWith('[')) { continue }

    $fields = $trimmed -split '\s+'
    if ($fields.Count -lt 2) { continue }

    $pattern = $fields[0]
    $attributes = $fields[1..($fields.Count - 1)]

    $routedToLfs = @($attributes | Where-Object { $_ -in @('filter=lfs', 'diff=lfs', 'merge=lfs', '-text', 'binary') }).Count -gt 0
    if (-not $routedToLfs) { continue }

    $leaf = ($pattern -split '[/\\]')[-1]
    if ($binaryExceptions -contains $leaf) { continue }
    if ($leaf -notlike '*.*') { continue }

    $extension = $leaf.Substring($leaf.LastIndexOf('.') + 1)
    if ($textAssets -contains $extension) {
        $findings += "  line ${lineNumber}: $trimmed"
    }
}

if ($findings.Count -gt 0) {
    Write-Host "check-gitattributes: FAIL, text serialized Unity assets routed to LFS in $Path"
    $findings | ForEach-Object { Write-Host $_ }
    Write-Host 'Fix: replace the LFS attributes with "text eol=lf merge=unityyamlmerge".'
    exit 1
}

Write-Host "check-gitattributes: OK, no text serialized Unity asset is routed to LFS in $Path"
exit 0
