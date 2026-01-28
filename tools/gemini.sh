setup_gemini() {
  if command -v gemini >/dev/null 2>&1; then
    echo "✅ Gemini is already installed"
    
    return 0
  fi

  echo "Starting Gemini installation..."

  brew install gemini-cli

  echo "✅ Gemini installed"
}

