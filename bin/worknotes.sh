#! /bin/bash

set -eou pipefail

WORK_NOTE_PATH="$HOME/.work_notes"

touch "$WORK_NOTE_PATH"

echo "

---
# $(date -u +"%Y-%m-%dT%H:%M:%SZ")

" >>"$WORK_NOTE_PATH"
vim + "$WORK_NOTE_PATH"
