# Weryfikuje integralnosc zainstalowanego tlumaczenia PL: Tangle Tower (Windows)
param(
    [string]$GamePath
)
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir "..\common\paths.ps1")

$RepoDir = Get-RepoDir -ScriptDir $ScriptDir
$Manifest = Join-Path $RepoDir "_Patches\translation_manifest.json"

if (-not (Test-Path $Manifest)) {
    Write-Host "Brak translation_manifest.json ($Manifest)."
    exit 1
}

$GamePath = Get-GamePathOrExit -ScriptDir $ScriptDir -Explicit $GamePath
Write-Host "Gra: $GamePath"
Write-Host ""

$manifestData = Get-Content $Manifest -Raw | ConvertFrom-Json
$allOk = $true

foreach ($prop in $manifestData.files.PSObject.Properties) {
    $rel = $prop.Name
    $expected = $prop.Value
    $target = Join-Path $GamePath $rel
    if (-not (Test-Path $target)) {
        Write-Host "  BRAK: $rel"
        $allOk = $false
        continue
    }
    $actual = (Get-FileHash -Path $target -Algorithm SHA256).Hash.ToLower()
    if ($actual -eq $expected) {
        Write-Host "  OK: $rel"
    } else {
        Write-Host "  ROZNI SIE: $rel (plik zmodyfikowany / inna wersja patcha)"
        $allOk = $false
    }
}

Write-Host ""
if ($allOk) {
    Write-Host "Wszystko zgodne - tlumaczenie Tangle Tower (PL) zainstalowane poprawnie."
} else {
    Write-Host "Znaleziono niezgodnosci - patrz szczegoly powyzej."
    exit 1
}
