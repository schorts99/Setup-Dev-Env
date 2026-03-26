setup_sdkman() {
  if command -v sdk >/dev/null 2>&1; then
    echo "✅ SDKMan is already installed"
    
    return 0
  fi

  echo "Starting SDKMan installation..."

  if ! command -v zip >/dev/null 2>&1; then
    sudo apt-get install zip -y
  fi

  curl -s "https://get.sdkman.io" | bash
  source "$HOME/.sdkman/bin/sdkman-init.sh"

  echo "✅ SDKMan installed"
}
