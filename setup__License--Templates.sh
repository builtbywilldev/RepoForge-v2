#!/bin/bash

BASE="$HOME/Desktop/dev__Starters/licenses"
AUTHOR="William Brown"
YEAR=$(date +%Y)

LICENSES=("mit" "gpl" "apache" "unlicense" "proprietary")

for LICENSE in "${LICENSES[@]}"; do
  DIR="$BASE/$LICENSE"
  mkdir -p "$DIR"

  # .gitignore FIRST
  printf "node_modules/\ndist/\n.env\n.DS_Store\n" > "$DIR/.gitignore"

  # LICENSE
  printf "%s License\n\nCopyright (c) %s %s\n\nPermission is hereby granted...\n[Insert full license text here]\n" \
    "$LICENSE" "$YEAR" "$AUTHOR" > "$DIR/LICENSE"

  # README
  printf "# {{PROJECT_NAME}}\n\n> This repo was generated using a custom CLI tooling system by [builtbywill.dev](https://builtbywill.dev)\n\n---\nPowered by [BuiltByWill.dev](https://builtbywill.dev)\nPhase–Coded | Method–Signed | Terminal–Forged\n" \
    > "$DIR/README.md"

  # .bw_hash
  echo '{
  "creator": "BuiltByWill",
  "method": "CLI Spawn",
  "phase": "alpha-init",
  "hash": "bw-X991-77A3"
}' > "$DIR/.bw_hash"

  echo "✅ $LICENSE starter created and stamped at $DIR"
done

echo -e "\n📦 All starter licenses stamped with BuiltByWill identity."
echo -e "🧠 Every repo spawned from these carries the mark.\n"
