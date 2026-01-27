setup_neovim() {
  if command -v nvim >/dev/null 2>&1; then
    echo "✅ NeoVim is already installed"
    
    return 0
  fi

  echo "Starting NeoVim installation..."

  wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
  tar xzvf nvim-linux-x86_64.tar.gz
  rm nvim-linux-x86_64.tar.gz
  mv nvim-linux-x86_64 ~/.nvim
  ln -sf ~/.nvim/bin/nvim ~/.local/bin/nvim
  
  echo "✅ NeoVim installed"
}

