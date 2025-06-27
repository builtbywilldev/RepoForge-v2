#!/bin/bash

BASE="$HOME/Desktop/dev__Starters/licenses"
HASH='{
  "creator": "BuiltByWill",
  "method": "CLI Spawn",
  "phase": "alpha-init",
  "hash": "bw-X991-77A3"
}'

for LICENSE_DIR in "$BASE"/*; do
  echo "$HASH" > "$LICENSE_DIR/.bw_hash"
  echo "✅ .bw_hash added to $(basename "$LICENSE_DIR")"
done
