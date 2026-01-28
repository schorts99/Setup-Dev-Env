setup_copilot() {
  if command -v copilot >/dev/null 2>&1; then
    echo "✅ Copilot is already installed"
    
    return 0
  fi

  echo "Starting Copilot installation..."

  brew install copilot-cli

  echo "✅ Copilot installed"
}

