# _Translation

Publiczne źródła tłumaczenia - komplet 6703 terminów I2Loc z gry, po angielsku
i po polsku obok siebie, do szybkiego porównania bez uruchamiania gry.

Format każdego pliku CSV: kolumny `term,en,pl`.
- `term` - identyfikator terminu w danych gry (I2 Localization), np.
  `Conversation/FelixYourself/Section ds1`.
- `en` - oryginalny angielski tekst (`English (United Kingdom)`).
- `pl` - polskie tłumaczenie. Puste pole oznacza brak tłumaczenia w tym
  miejscu - dla garstki czysto technicznych identyfikatorów (patrz
  `misc_pozostale.csv`) i kilku pustych z natury terminów w źródle gry
  (puste gałęzie dialogowe) to zamierzone; jeśli trafisz na puste pole przy
  niepustym `en` gdzie indziej, zgłoś to jako błąd.

## Pliki

| Plik | Zawartość |
|---|---|
| `conversation_dialogi_podejrzani.csv` | Główny wątek fabularny + dialogi wszystkich 8 podejrzanych |
| `examine_opisy_przedmiotow.csv` | Opisy przedmiotów i pomieszczeń ("obejrzyj") |
| `puzzles_zagadki.csv` | Zagadki dedukcyjne (Compare/TestMindGame) |
| `clues_tropy.csv` | Katalog fizycznych tropów/dowodów |
| `souls_podsumowania_postaci.csv` | Podsumowania podejrzeń, drzewo genealogiczne, nazwy postaci |
| `makingof_galeria_sztuki.csv` | Bonusowa galeria sztuki (komentarze twórców) |
| `hints_podpowiedzi.csv` | Podpowiedzi w grze |
| `views_nazwy_lokacji.csv` | Nazwy lokacji |
| `ui_*.csv` | Menu główne, opcje, sterowanie, zapisy, demo, rozdziały, checklista, relacje rodzinne, harmonograf |
| `misc_pozostale.csv` | Drobne pozostałe terminy + celowo pominięte identyfikatory techniczne |

## Zasady

- Nie zmieniamy identyfikatorów w kolumnie `term` - to klucze z danych gry.
- Zachowujemy znaczniki tekstu gry (`[h]...[/h]`, `[i]...[/i]`, `[c]...[/c]`,
  `[b]...[/b]`, `[m]...[/m]`, `[ch]...[/ch]`) i liczbę znaków nowej linii
  (`\n`) identycznie jak w oryginale - są używane przez silnik gry
  (podświetlenia, markery muzyczne, checklisty) i muszą się zgadzać.
- Imiona własne (Felix, Fifi, Sally, Grimoire, Tangle Tower, itd.) zostają
  bez zmian ("no-touch zone") dla spójności z resztą tłumaczenia.
