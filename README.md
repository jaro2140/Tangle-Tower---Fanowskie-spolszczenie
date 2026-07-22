# 🇵🇱 Tangle Tower - Fanowskie spolszczenie

Nieoficjalne polskie tłumaczenie gry **Tangle Tower** (SFB Games).
Potrzebujesz **legalnie posiadanej kopii** gry (Steam/GOG).

Projekt wymaga legalnie posiadanej kopii gry. Repozytorium publiczne zawiera tylko
pliki potrzebne graczom i testerom: instalatory, gotowe patche oraz źródła
tłumaczenia (do porównania en/pl). Nie zawiera oryginalnych plików gry ani
prywatnych narzędzi deweloperskich.

## ☕ Podoba Ci się to co robie?
Postaw mi kawe ☕! - https://buymeacoffee.com/jaro2140

---

## Po co to jest?

Tangle Tower to detektywistyczna gra przygodowa (Unity), oficjalnie dostępna
w 18 językach - bez polskiego. Ten projekt to:
- **Fanowski patch językowy** — polskie dialogi, opisy przedmiotów, zagadki i teksty interfejsu
- **Dedykowany przycisk "Polski"** w menu wyboru języka
- **Instalator** — Linux / SteamOS (Steam Deck) / Windows, z weryfikacją i pełnym odinstalowaniem

## 📊 Status

**Tłumaczenie tekstu ukończone w 99,9%** (6696 z 6703 terminów I2Loc). Pozostałe
7 to celowo pominięte, czysto techniczne identyfikatory bez znaczenia dla
gracza (nazwy assetów fontów, ciąg cyfr).

Polskie znaki diakrytyczne (`ĄąĆćĘęŁłŃńÓóŚśŹźŻż`) zostały dopisane do obu
fontów SDF używanych w grze (Candela Bold, Old Newspaper Types).

## ⏳ Postęp

| Etap | Status |
|------|--------|
| Główny wątek fabularny | ✅ 100% |
| Wszystkie 8 siatek podejrzanych (Felix, Fifi, Fitz, Flora, Hawkshaw, Penny, Poppy, Pointer) | ✅ 100% |
| Opisy przedmiotów i pomieszczeń (Examine) | ✅ 100% |
| Zagadki dedukcyjne (Puzzles) | ✅ 100% |
| Tropy/dowody (Clues) | ✅ 100% |
| Bonusowa galeria sztuki (Making Of) | ✅ 100% |
| Menu i UI | ✅ 100% |
| Czcionki PL | ✅ naprawione |
| Osobny przycisk "Polski" w menu | ✅ działa |

## ⚙️ Jak to działa

Gra przechowuje wszystkie teksty w systemie I2 Localization z 18 slotami
językowymi. Ekran wyboru języka jest ręcznie wpięty w edytorze Unity (każdy
język ma własny, umieszczony w scenie przycisk) - dodanie zupełnie nowego,
19. przycisku wymagałoby budowania nowego obiektu binarnie w plikach `.assets`.

Zamiast tego patch przejmuje ukryty slot **`DevTest`** (używany wewnętrznie
przez deweloperów, niewidoczny dla graczy) - ma już w pełni działający,
wpięty w scenę przycisk, tylko wyłączony (`m_IsActive: False`). Patch:
odblokowuje ten przycisk, przemianowuje go i powiązane dane na "Polski" (w
trzech niezależnych miejscach danych gry), wstawia polskie tłumaczenie do
tego slotu, i dopisuje polskie znaki do atlasów fontów SDF.

**Żaden istniejący język nie jest nadpisywany ani tracony.**

## 🛠️ Instalacja

Aktualna paczka (zakładka **Releases**):

```text
Tangle-Tower-Patch-PL.zip
```

1. Pobierz paczkę i rozpakuj ją w dowolnym folderze.
2. Uruchom instalator dla swojego systemu:
   - **Linux / SteamOS (Steam Deck):**
     ```bash
     cd _Installers/linux
     chmod +x install-pl.sh restore-original.sh verify-install.sh ../common/paths.sh
     ./install-pl.sh [opcjonalna ścieżka do gry]
     ```
   - **Windows:**
     ```powershell
     cd _Installers\windows
     powershell -ExecutionPolicy Bypass -File install-pl.ps1 [-GamePath "ścieżka"]
     ```
3. Jeśli automatyczne wykrycie gry (Steam/GOG) nie zadziała, podaj ścieżkę
   jako argument, albo skopiuj `game-path.env.example` do `game-path.env`
   (obok skryptów) i ustaw `GAME_PATH=/ścieżka/do/Tangle Tower`.
4. Uruchom grę, wejdź w **Opcje → Język tekstu → Polski**.
5. Weryfikacja instalacji: `verify-install.sh` / `verify-install.ps1`.
6. Przywrócenie oryginału: `restore-original.sh` / `restore-original.ps1`.

Instalator zawsze robi kopię zapasową oryginalnych plików przed podmianą
(folder `backup_pl/` obok skryptów instalatora), więc odinstalowanie
przywraca dokładnie to, co było przed patchem.

Kopie skryptów instalatora (do wglądu, bez konieczności pobierania paczki)
są w folderze `_Installers/` tego repo.

### Sumy kontrolne aktualnego wydania (SHA-256)

| Plik | SHA-256 |
|---|---|
| `Tangle-Tower-Patch-PL.zip` | `6ac6bdece7b6b7cf4b843cfdb8327b60613f626854319b34739fe2a2548a3486` |
| `Tangle Tower_Data/resources.assets` | `114eaaef3926f319810067498662d6f9f74aaaa60ead178b939d566eb226a216` |
| `Tangle Tower_Data/sharedassets0.assets` | `aac69446701e1d418c2b3df71c54c70b7cc9978a25bbe3439b82a429cc79f380` |

## 📚 Tłumaczenie do porównania (en/pl)

Folder `_Translation/` zawiera pliki CSV (kolumny `term,en,pl`) z całym
tłumaczeniem, podzielone tematycznie (dialogi i podejrzani, opisy przedmiotów,
zagadki, tropy, galeria sztuki, UI...) - do szybkiego porównania angielskiego
oryginału z polskim tłumaczeniem, bez potrzeby uruchamiania gry.

## 🪲 Zgłaszanie błędów

Zauważysz angielski tekst, źle wyświetlony znak, literówkę albo błąd w
zagadce? Zgłoś issue z dokładną treścią kwestii (albo zrzutem ekranu) i
miejscem w grze, w którym występuje.

## ❌ Disclaimer

Fanowski projekt **niezwiązany z SFB Games**.
Tangle Tower jest znakiem towarowym jego właścicieli.
Gra musi być legalnie zakupiona. Patch nie zawiera oryginalnych plików gry.
