# Przywraca oryginalne (angielskie) pliki gry: Tangle Tower (Windows)
param(
    [string]$GamePath
)
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir "..\common\paths.ps1")

$Backup = Join-Path $ScriptDir "backup_pl"
if (-not (Test-Path $Backup)) {
    Write-Host "Brak kopii zapasowej ($Backup) - nic do przywrocenia."
    exit 0
}

$GamePath = Get-GamePathOrExit -ScriptDir $ScriptDir -Explicit $GamePath
Write-Host "Gra: $GamePath"

Get-ChildItem -Path $Backup -Recurse -File | ForEach-Object {
    $rel = $_.FullName.Substring($Backup.Length + 1)
    $target = Join-Path $GamePath $rel
    New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
    Copy-Item $_.FullName $target -Force
    Write-Host "  przywrocono: $rel"
}

Write-Host ""
Write-Host "Gotowe - przywrocono oryginalne (angielskie) pliki Tangle Tower."
