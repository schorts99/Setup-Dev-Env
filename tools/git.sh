setup_git() {
  if command -v git >/dev/null 2>&1; then
    echo "✅ Git is already installed"
    
    return 0
  fi

  echo "Starting Git installation..."

  sudo apt-get install git
  git config --global color.ui true

  echo "✅ Git installed"
}

