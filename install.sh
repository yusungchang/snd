#!/bin/bash

# Install script for snd - stamps version from Git and copies to ~/.local/bin

set -euo pipefail

DEST="$HOME/.local/bin"
ZSHRC="$HOME/.zshrc"

# Ensure destination exists
mkdir -p "$DEST"

# Ensure tags are up to date
git fetch --tags 2>/dev/null || true

VERSION=$(git describe --tags --always 2>/dev/null || echo "dev")

# Copy and stamp the script
cp snd "$DEST/snd"
sed -i.bak "s/@@VERSION@@/$VERSION/" "$DEST/snd" || true
chmod +x "$DEST/snd"

echo "Installed snd $VERSION to $DEST/snd"

# Ensure ~/.local/bin is on PATH in .zshrc
if [ ! -f "$ZSHRC" ]; then
	touch "$ZSHRC"
fi

if ! grep -q '\$HOME/\.local/bin' "$ZSHRC" && ! grep -q '~/\.local/bin' "$ZSHRC"; then
	cat >> "$ZSHRC" <<'EOF'
# Added by snd installer: ensure local bin is on PATH
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi
EOF
	echo "Appended PATH export to $ZSHRC"
else
	echo "$ZSHRC already contains ~/.local/bin in PATH"
fi