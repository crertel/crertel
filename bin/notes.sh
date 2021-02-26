#! /bin/bash
set -eou pipefail
NOTE_PATH="${1:-"$HOME/.notes"}"
echo "Writing notes to $NOTE_PATH"
mkdir -p "$(dirname "$NOTE_PATH")" && touch "$NOTE_PATH"
printf "\n---\n# $(date -u +"%Y-%m-%dT%H:%M:%SZ")\n\n" >>"$NOTE_PATH"
vim + "$NOTE_PATH"
