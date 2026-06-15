setup_pnpm() {
  if command -v pnpm >/dev/null 2>&1; then
    echo "✅ PNPM is already installed"
    
    return 0
  fi

  echo "Starting PNPM installation..."

  npm install -g pnpm@latest
	pnpm setup

  echo "✅ PNPM installed"
}

