#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Add Ruby gem bindir to PATH for theme-check
export PATH="/opt/rbenv/versions/3.3.6/bin:$PATH"
echo 'export PATH="/opt/rbenv/versions/3.3.6/bin:$PATH"' >> "$CLAUDE_ENV_FILE"

# Install Shopify theme-check linter (idempotent - skips if already installed)
if ! gem list theme-check --installed --version '>= 1.15.0' > /dev/null 2>&1; then
  gem install theme-check --no-document
fi
