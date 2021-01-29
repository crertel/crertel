#! /bin/bash
set -eou pipefail
NOTE_PATH="${1:-"$HOME/.notes"}"
mkdir -p "$(dirname "$NOTE_PATH")" && touch "$NOTE_PATH"
printf "\n---\n# $(date -u +"%Y-%m-%dT%H:%M:%SZ")\n\n" >>"$NOTE_PATH"
vim + "$NOTE_PATH"
