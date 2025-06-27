#!/bin/bash

LICENSE_TYPE=$1
REPO_NAME=$2
TARGET_DIR=~/Desktop/$REPO_NAME
SOURCE_DIR=~/Desktop/dev__Starters/licenses/$LICENSE_TYPE

AUTHOR="William Brown"
YEAR=$(date +%Y)

if [ -z "$LICENSE_TYPE" ] || [ -z "$REPO_NAME" ]; then
  echo "❌ Usage: spawn <license> <repo-name>"
  exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ License type '$LICENSE_TYPE' does not exist."
  exit 1
fi

# Create new project
cp -r "$SOURCE_DIR" "$TARGET_DIR"

# Replace placeholders
sed -i "s/{{PROJECT_NAME}}/$REPO_NAME/g" "$TARGET_DIR/README.md"
sed -i "s/{{YEAR}}/$YEAR/g" "$TARGET_DIR/LICENSE"
sed -i "s/{{AUTHOR}}/$AUTHOR/g" "$TARGET_DIR/LICENSE"

# Init Git
cd "$TARGET_DIR"
git init
git add .
git commit -m "📦 Repo initialized via CLI Spawn | BuiltByWill.dev"

# Launch VS Code
code .

echo "✅ $REPO_NAME created with $LICENSE_TYPE license and spawned into VS Code."
