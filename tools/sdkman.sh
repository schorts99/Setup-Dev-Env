setup_sdkman() {
  if [ -d "$HOME/.sdkman" ]; then
    echo "✅ SDKMan is already installed"
    
    return 0
  fi

  echo "Starting SDKMan installation..."

  if ! command -v zip >/dev/null 2>&1; then
    sudo apt-get install zip -y
  fi

  curl -s "https://get.sdkman.io" | bash

  echo "✅ SDKMan installed"
}
