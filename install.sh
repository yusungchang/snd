#!/bin/bash

# ==============================================================================
#  snd - Install Script
#  Downloads the latest release from GitHub and installs to ~/.local/bin
# ==============================================================================

set -euo pipefail

REPO="yusungchang/snd"
DEST="$HOME/.local/bin"
ZSHRC="$HOME/.zshrc"
BIN_NAME="snd"

RELEASE_URL="https://github.com/$REPO/releases/latest/download/$BIN_NAME"

echo "Installing $BIN_NAME..."

# Ensure destination exists
mkdir -p "$DEST"

# Download the latest release
if ! curl -fsSL "$RELEASE_URL" -o "$DEST/$BIN_NAME"; then
    echo "Error: Failed to download $BIN_NAME from $RELEASE_URL" >&2
    exit 1
fi

chmod +x "$DEST/$BIN_NAME"
echo "Installed $BIN_NAME to $DEST/$BIN_NAME"

# Ensure fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Warning: fzf is not installed. Please run: brew install fzf" >&2
fi

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
    echo "Run 'source ~/.zshrc' or open a new terminal to apply PATH changes."
else
    echo "$ZSHRC already contains ~/.local/bin in PATH"
fi

echo "Done. Run '$BIN_NAME -h' to get started."