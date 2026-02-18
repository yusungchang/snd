#!/bin/bash

# Install script for snd - stamps version from Git and copies to ~/.local/bin

git fetch --tags  # Ensure tags are up to date
VERSION=$(git describe --tags --always 2>/dev/null || echo "dev")
cp snd ~/.local/bin/snd
sed -i.bak "s/@@VERSION@@/$VERSION/" ~/.local/bin/snd
echo "Installed snd $VERSION to ~/.local/bin/snd"