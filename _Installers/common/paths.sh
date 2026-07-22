#!/usr/bin/env bash
# Wspolne funkcje wykrywania sciezki gry i payloadu patcha (Linux/SteamOS).
set -euo pipefail

_PATHS_SH_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$_PATHS_SH_DIR/../.." && pwd)"
PATCH_DIR="$REPO_DIR/_Patches/payload"
MANIFEST="$REPO_DIR/_Patches/translation_manifest.json"
GAME_NAME="Tangle Tower"
DATA_DIR_NAME="Tangle Tower_Data"

CANDIDATES=(
  "$HOME/.steam/steam/steamapps/common/$GAME_NAME"
  "$HOME/.local/share/Steam/steamapps/common/$GAME_NAME"
  "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/$GAME_NAME"
  "/home/deck/.local/share/Steam/steamapps/common/$GAME_NAME"
  "/run/media/mmcblk0p1/steamapps/common/$GAME_NAME"
  "/run/media/deck/mmcblk0p1/steamapps/common/$GAME_NAME"
  "$HOME/GOG Games/$GAME_NAME"
)

resolve_game_path() {
  if [[ -n "${GAME_PATH:-}" ]]; then
    echo "$GAME_PATH"
    return 0
  fi
  local env_file="$REPO_DIR/game-path.env"
  if [[ -f "$env_file" ]]; then
    # shellcheck disable=SC1090
    source "$env_file"
    if [[ -n "${GAME_PATH:-}" ]]; then
      echo "$GAME_PATH"
      return 0
    fi
  fi
  if [[ $# -ge 1 && -n "${1:-}" ]]; then
    echo "$1"
    return 0
  fi
  local path
  for path in "${CANDIDATES[@]}"; do
    if [[ -d "$path/$DATA_DIR_NAME" ]]; then
      echo "$path"
      return 0
    fi
  done
  # Steam Deck / dowolny zamontowany dysk zewnetrzny
  for path in /run/media/"${USER:-deck}"/*/steamapps/common/"$GAME_NAME" /run/media/*/*/steamapps/common/"$GAME_NAME"; do
    if [[ -d "$path/$DATA_DIR_NAME" ]]; then
      echo "$path"
      return 0
    fi
  done
  return 1
}

load_game_path() {
  local explicit="${1:-}"
  if ! GAME_PATH="$(resolve_game_path "$explicit")"; then
    echo "Nie znaleziono folderu gry '$GAME_NAME'." >&2
    echo "Podaj sciezke jako argument, np.:" >&2
    echo "    $0 \"/sciezka/do/$GAME_NAME\"" >&2
    echo "albo skopiuj game-path.env.example do game-path.env i ustaw GAME_PATH." >&2
    exit 1
  fi
  if [[ ! -d "$GAME_PATH/$DATA_DIR_NAME" ]]; then
    echo "Blad: '$GAME_PATH' nie wyglada na folder gry '$GAME_NAME' (brak $DATA_DIR_NAME)." >&2
    exit 1
  fi
  export GAME_PATH
}

require_patch_payload() {
  if [[ ! -d "$PATCH_DIR" ]]; then
    echo "Brak payloadu patcha: $PATCH_DIR" >&2
    echo "Pobierz i rozpakuj najnowsza paczke z zakladki Releases." >&2
    exit 1
  fi
}

sha256_of() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 "$1" | awk '{print $1}'
  else
    sha256sum "$1" | awk '{print $1}'
  fi
}
