# Instalator polskiego tlumaczenia: Tangle Tower (Windows)
param(
    [string]$GamePath
)
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir "..\common\paths.ps1")

$GamePath = Get-GamePathOrExit -ScriptDir $ScriptDir -Explicit $GamePath
$RepoDir = Get-RepoDir -ScriptDir $ScriptDir
$Payload = Join-Path $RepoDir "_Patches\payload"
$Backup = Join-Path $ScriptDir "backup_pl"

if (-not (Test-Path $Payload)) {
    Write-Host "Brak payloadu patcha: $Payload"
    Write-Host "Pobierz i rozpakuj najnowsza paczke z zakladki Releases."
    exit 1
}

Write-Host "Gra:     $GamePath"
Write-Host "Payload: $Payload"
New-Item -ItemType Directory -Force -Path $Backup | Out-Null

Get-ChildItem -Path $Payload -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($Payload.Length + 1)
    $target = Join-Path $GamePath $rel
    $bak = Join-Path $Backup $rel

    if (-not (Test-Path $target)) {
        Write-Host "  BLAD: brak oryginalnego pliku $target"
        exit 1
    }
    New-Item -ItemType Directory -Force -Path (Split-Path $bak) | Out-Null
    if (-not (Test-Path $bak)) {
        Copy-Item $target $bak
        Write-Host "  kopia zapasowa: $rel"
    }
    New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
    Copy-Item $_.FullName $target -Force
    Write-Host "  zainstalowano:  $rel"
}

Write-Host ""
Write-Host "Gotowe! Polskie tlumaczenie Tangle Tower zostalo zainstalowane."
Write-Host "W grze: Opcje -> Jezyk tekstu -> Polski."
Write-Host ""
Write-Host "Weryfikacja: .\verify-install.ps1"
Write-Host "Przywrocenie oryginalu: .\restore-original.ps1"
Write-Host ""
& (Join-Path $ScriptDir "verify-install.ps1") -GamePath $GamePath
