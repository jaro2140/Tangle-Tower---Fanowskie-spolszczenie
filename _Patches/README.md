# _Patches

Gotowa paczka patcha: **`Tangle-Tower-Patch-PL.zip`**.

Paczka jest **samowystarczalna** — zawiera payload (2 pliki gry), manifest
SHA-256 oraz skrypty instalacji/weryfikacji/odinstalowania dla
Linux+SteamOS oraz Windows:

```text
_Installers/common/paths.sh        _Installers/common/paths.ps1
_Installers/linux/install-pl.sh    _Installers/linux/restore-original.sh    _Installers/linux/verify-install.sh
_Installers/windows/install-pl.ps1 _Installers/windows/restore-original.ps1 _Installers/windows/verify-install.ps1
_Patches/payload/Tangle Tower_Data/resources.assets
_Patches/payload/Tangle Tower_Data/sharedassets0.assets
_Patches/translation_manifest.json
game-path.env.example
README.txt
```

Pobierz paczkę (z zakładki **Releases**, albo bezpośrednio z tego folderu,
jeśli jest tu obecna), rozpakuj ZIP w dowolnym folderze i uruchom
`_Installers/<Twój system>/install-pl.sh` (lub `.ps1`). Po instalacji
wybierz w grze **Opcje → Język tekstu → Polski**.

`_Patches/payload/` i `_Patches/translation_manifest.json` w tym repo są
celowo **gitignored** (duże pliki binarne - publikowane przez Releases, nie
przez historię git). Ten folder w checkoucie repo może więc wyglądać na
pusty poza tym README - to normalne.

## Sumy kontrolne aktualnego wydania (SHA-256)

| Plik | SHA-256 |
|---|---|
| `Tangle-Tower-Patch-PL.zip` | `6ac6bdece7b6b7cf4b843cfdb8327b60613f626854319b34739fe2a2548a3486` |
| `Tangle Tower_Data/resources.assets` | `114eaaef3926f319810067498662d6f9f74aaaa60ead178b939d566eb226a216` |
| `Tangle Tower_Data/sharedassets0.assets` | `aac69446701e1d418c2b3df71c54c70b7cc9978a25bbe3439b82a429cc79f380` |

Nie instaluj na wersji gry inne niż ta, dla której powyższe sumy zostały
wygenerowane - w razie aktualizacji gry (np. przez Steam) poczekaj na nowe
wydanie patcha.
