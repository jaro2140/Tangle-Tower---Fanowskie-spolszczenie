# _Installers

Publiczne skrypty instalacji patcha, gotowe do uruchomienia (nie tylko
szkielet) - przetestowane end-to-end (install → verify → restore →
verify) na Linuksie.

Układ:

- `common/paths.sh` / `common/paths.ps1` - wspólne funkcje: auto-wykrywanie
  ścieżki gry (Steam/GOG na Linuksie, SteamOS/Steam Deck, Windows), odczyt
  `game-path.env`, lokalizacja payloadu i manifestu.
- `linux/` - `install-pl.sh`, `restore-original.sh`, `verify-install.sh`
  (działa też na SteamOS/Steam Deck - te same skrypty, dodatkowe ścieżki
  kandydackie dla Decka już wbudowane).
- `windows/` - `install-pl.ps1`, `restore-original.ps1`, `verify-install.ps1`.

Każdy instalator:

- wykrywa lub przyjmuje ścieżkę do gry (argument / `game-path.env` /
  znane ścieżki Steam-GOG / skan zamontowanych dysków),
- sprawdza, czy folder wygląda jak `Tangle Tower` (obecność
  `Tangle Tower_Data`),
- robi kopię zapasową oryginalnych plików przed podmianą (`backup_pl/`
  obok skryptów),
- kopiuje pliki patcha z `_Patches/payload/`,
- automatycznie uruchamia weryfikację SHA-256 po instalacji,
- umożliwia osobne uruchomienie weryfikacji i pełne przywrócenie oryginału.

Payload i manifest SHA-256 (`_Patches/payload/`,
`_Patches/translation_manifest.json`) nie są śledzone w git (patrz
`.gitignore`) - pobierz je z paczki w zakładce **Releases** (albo z
`_Patches/Tangle-Tower-Patch-PL.zip`, jeśli jest w repo).
