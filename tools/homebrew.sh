setup_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    echo "✅ Homebrew is already installed"
    
    # return 0
  fi

  echo "Starting Homebrew installation..."

  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> /home/$USER/.bashrc
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> /home/$USER/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
  sudo apt-get install build-essential
  brew install gcc

  echo "✅ Homebrew installed"
}

