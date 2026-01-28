setup_claude_code() {
  if command -v claude >/dev/null 2>&1; then
    echo "✅ Claude Code is already installed"
    
    return 0
  fi

  echo "Starting Claude Code installation..."

  curl -fsSL https://claude.ai/install.sh | bash

  echo "✅ Claude Code installed"
}

