setup_git() {
  if command -v git >/dev/null 2>&1; then
    echo "✅ Git is already installed"
    
    return 0
  fi

  echo "Starting Git installation..."

  sudo apt-get install git
  read -p "Enter your name: " USER_NAME
  read -p "Enter your email: " USER_EMAIL
  git config --global color.ui true
  git config --global user.name "$USER_NAME"
  git config --global user.email "$USER_EMAIL"

  echo "✅ Git installed"
}

