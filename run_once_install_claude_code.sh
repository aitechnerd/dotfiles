#!/bin/bash
# Install Claude Code via native installer (auto-updates)

set -euo pipefail

if ! command -v claude &>/dev/null; then
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi
