#!/bin/bash

# ================================
# RepoForge Interactive Spawner
# ================================

# Load author from vault
AUTHOR=$(cat ~/.repoforge/.author 2>/dev/null)
YEAR=$(date +%Y)

if [[ -z "$AUTHOR" ]]; then
  echo "❌ Author not set. Please run ./install.sh first."
  exit 1
fi

echo -e "\n🔧 Welcome to RepoForge"
echo "🚀 Let's forge your next repo from the command line..."

# Prompt for repo name
read -p "📝 What is your repo name? " REPO_NAME
REPO_PATH=~/Desktop/$REPO_NAME

# Prompt for license type
read -p "🔐 Choose a license (mit, gpl, apache, unlicense, proprietary): " LICENSE_TYPE
LICENSE_DIR="$HOME/.repoforge/licenses/$LICENSE_TYPE"

if [ ! -d "$LICENSE_DIR" ]; then
  echo "❌ License type '$LICENSE_TYPE' not found in vault."
  exit 1
fi

# Prompt for .gitignore
read -p "📄 Include .gitignore? (y/n): " ADD_GITIGNORE

# Prompt for README
read -p "📘 Include README.md? (y/n): " ADD_README

# Create repo folder
mkdir -p "$REPO_PATH"
cp "$LICENSE_DIR/LICENSE" "$REPO_PATH/"
sed -i "s/{{YEAR}}/$YEAR/g; s/{{NAME}}/$AUTHOR/g" "$REPO_PATH/LICENSE"

# Add .gitignore
if [[ "$ADD_GITIGNORE" == "y" ]]; then
  cp "$LICENSE_DIR/.gitignore" "$REPO_PATH/"
fi

# Add README
if [[ "$ADD_README" == "y" ]]; then
  cp "$LICENSE_DIR/README.md" "$REPO_PATH/"
  sed -i "s/{{PROJECT_NAME}}/$REPO_NAME/g" "$REPO_PATH/README.md"
fi

# Stamp with bw_hash
cp "$LICENSE_DIR/.bw_hash" "$REPO_PATH/.bw_hash"

# Initialize git and commit
cd "$REPO_PATH"
git init
git add .
git commit -m "📦 Repo initialized via RepoForge | License: $LICENSE_TYPE"

# Launch in VS Code
code .

echo -e "\n✅ Repo '$REPO_NAME' created and launched with license '$LICENSE_TYPE'."
