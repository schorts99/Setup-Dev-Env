setup_nvchad() {
  if [ -f "$HOME/.config/nvim/lua/nvchad/init.lua" ]; then
    echo "✅ NvChad is already installed"
    
    return 0
  fi

  echo "Starting NvChad installation..."

  if ! command -v tree-sitter >/dev/null 2>&1; then
    echo "tree-sitter-cli"
    npm install -g tree-sitter-cli
  fi

  echo "✅ NvChad installed"
}

