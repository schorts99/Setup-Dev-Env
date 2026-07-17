setup_codex() {
	if command -v codex >/dev/null 2>&1; then
    echo "✅ Codex is already installed"
    
    return 0
  fi

  echo "Starting Codex installation..."

	brew install --cask codex

  echo "✅ Codex installed"
}
