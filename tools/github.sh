setup_github() {
  if command -v gh >/dev/null 2>&1; then
    echo "✅ GitHub is already installed"
    
    return 0
  fi


  echo "Starting GitHub installation..."

  brew install gh
  gh auth login

  echo "✅ GitHub installed"
}

