setup_python() {
  if command -v python >/dev/null 2>&1 || command -v python3 >/dev/null 2>&1; then
    echo "✅ Python is already installed"
    
    return 0
  fi

  echo "Starting Python installation..."

  brew install tcl-tk
  pyenv install 3
  pyenv global 3
  eval "$(pyenv init -)"

  echo "✅ Python installed"
}
