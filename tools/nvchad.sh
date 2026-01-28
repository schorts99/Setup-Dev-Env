setup_nvchad() {
  if [ -f "$HOME/.config/nvim/lua/chadrc.lua" ]; then
    echo "✅ NvChad is already installed"
    
    return 0
  fi

  echo "Starting NvChad installation..."

  if ! command -v tree-sitter >/dev/null 2>&1; then
    npm install -g tree-sitter-cli
  fi

  if ! command -v rg >/dev/null 2>&1; then
    brew install ripgrep
  fi

  if ! command -v gcc >/dev/null 2>&1; then
    sudo apt-get install gcc
  fi

  if ! command -v make >/dev/null 2>&1; then
    sudo apt-get install make
  fi

  git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

  echo "✅ NvChad installed"
}

