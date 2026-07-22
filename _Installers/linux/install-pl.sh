#!/usr/bin/env bash
# Instalator polskiego tlumaczenia: Tangle Tower (Linux / SteamOS / Steam Deck)
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common/paths.sh
source "$SCRIPT_DIR/../common/paths.sh"

load_game_path "${1:-}"
require_patch_payload

BACKUP_DIR="$SCRIPT_DIR/backup_pl"
mkdir -p "$BACKUP_DIR"

echo "Gra:     $GAME_PATH"
echo "Payload: $PATCH_DIR"

while IFS= read -r src; do
  rel="${src#"$PATCH_DIR"/}"
  target="$GAME_PATH/$rel"
  bak="$BACKUP_DIR/$rel"

  if [[ ! -f "$target" ]]; then
    echo "  BLAD: brak oryginalnego pliku $target" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$bak")"
  if [[ ! -f "$bak" ]]; then
    cp "$target" "$bak"
    echo "  kopia zapasowa: $rel"
  fi
  mkdir -p "$(dirname "$target")"
  cp "$src" "$target"
  echo "  zainstalowano:  $rel"
done < <(find "$PATCH_DIR" -type f)

echo ""
echo "Gotowe! Polskie tlumaczenie Tangle Tower zostalo zainstalowane."
echo "W grze: Opcje -> Jezyk tekstu -> Polski."
echo ""
echo "Weryfikacja: ./verify-install.sh"
echo "Przywrocenie oryginalu: ./restore-original.sh"
echo ""
bash "$SCRIPT_DIR/verify-install.sh" "$GAME_PATH"
