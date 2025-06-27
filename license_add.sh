#!/bin/bash

# === CONFIG ===
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/licenses"

YEAR=$(date +"%Y")
NAME="William Brown (@builtbywill)"

# === INPUTS ===
LICENSE_TYPE="$1"
TARGET_DIR="$2"

# === VALIDATION ===
if [[ -z "$LICENSE_TYPE" || -z "$TARGET_DIR" ]]; then
  echo "Usage: ./license_add.sh [mit|gpl|apache|unlicense|proprietary] /path/to/repo"
  exit 1
fi

LICENSE_TEMPLATE="$TEMPLATE_DIR/$LICENSE_TYPE/LICENSE"
DEST="$TARGET_DIR/LICENSE"

if [ ! -f "$LICENSE_TEMPLATE" ]; then
  echo "❌ License type '$LICENSE_TYPE' not found in $TEMPLATE_DIR"
  exit 1
fi

# === PROCESS TEMPLATE ===
sed "s/{{YEAR}}/$YEAR/g; s/{{NAME}}/$NAME/g" "$LICENSE_TEMPLATE" > "$DEST"

echo "✅ Injected $LICENSE_TYPE license into $TARGET_DIR with year $YEAR and name $NAME"
