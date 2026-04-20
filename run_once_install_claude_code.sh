#!/bin/bash
# Install Claude Code via native installer (auto-updates)

set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if ! command -v claude &>/dev/null; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi
