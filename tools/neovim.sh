setup_neovim() {
  if command -v nvim >/dev/null 2>&1; then
    echo "✅ NeoVim is already installed"
    
    return 0
  fi

  echo "Starting NeoVim installation..."

	if ! command -v unzip >/dev/null 2>&1; then
		brew install unzip
	fi

  brew install neovim
  
  echo "✅ NeoVim installed"
}

