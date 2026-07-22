# Wspolne funkcje wykrywania sciezki gry i payloadu patcha (Windows).
$ErrorActionPreference = "Stop"

$Script:GameName = "Tangle Tower"
$Script:DataDirName = "Tangle Tower_Data"

function Get-RepoDir {
    param([string]$ScriptDir)
    return (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
}

function Resolve-GamePath {
    param([string]$ScriptDir, [string]$Explicit)

    if ($Explicit) { return $Explicit }

    $repoDir = Get-RepoDir -ScriptDir $ScriptDir
    $envFile = Join-Path $repoDir "game-path.env"
    if (Test-Path $envFile) {
        $line = Get-Content $envFile | Where-Object { $_ -match '^GAME_PATH=' } | Select-Object -First 1
        if ($line) {
            $value = ($line -replace '^GAME_PATH=', '').Trim().Trim('"')
            if ($value) { return $value }
        }
    }

    $candidates = @(
        "C:\Program Files (x86)\Steam\steamapps\common\$($Script:GameName)"
        "C:\Program Files\Steam\steamapps\common\$($Script:GameName)"
        "C:\GOG Games\$($Script:GameName)"
    )
    foreach ($c in $candidates) {
        if (Test-Path (Join-Path $c $Script:DataDirName)) { return $c }
    }
    foreach ($drive in Get-PSDrive -PSProvider FileSystem) {
        $root = $drive.Root
        $libraryCandidates = @(
            (Join-Path $root "SteamLibrary\steamapps\common\$($Script:GameName)")
            (Join-Path $root "Steam\steamapps\common\$($Script:GameName)")
            (Join-Path $root "GOG Games\$($Script:GameName)")
        )
        foreach ($path in $libraryCandidates) {
            if (Test-Path (Join-Path $path $Script:DataDirName)) { return $path }
        }
    }
    return $null
}

function Get-GamePathOrExit {
    param([string]$ScriptDir, [string]$Explicit)

    $gamePath = Resolve-GamePath -ScriptDir $ScriptDir -Explicit $Explicit
    if (-not $gamePath) {
        Write-Host "Nie znaleziono folderu gry '$($Script:GameName)'."
        Write-Host "Uruchom z parametrem:  .\install-pl.ps1 -GamePath 'C:\sciezka\do\gry'"
        Write-Host "albo skopiuj game-path.env.example do game-path.env i ustaw GAME_PATH."
        exit 1
    }
    if (-not (Test-Path (Join-Path $gamePath $Script:DataDirName))) {
        Write-Host "Blad: '$gamePath' nie wyglada na folder gry '$($Script:GameName)' (brak $($Script:DataDirName))."
        exit 1
    }
    return $gamePath
}
