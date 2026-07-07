setup_antigravity() {
  if command -v agy >/dev/null 2>&1; then
    echo "✅ Antigravity is already installed"
    
    return 0
  fi

  echo "Starting Antigravity installation..."

  brew install antigravity-cli

  echo "✅ Antigravity installed"
}

