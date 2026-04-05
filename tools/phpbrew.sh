setup_phpbrew() {
  if command -v phpbrew >/dev/null 2>&1; then
    echo "✅ PHPbrew is already installed"
    
    return 0
  fi

  echo "Starting PHPbrew installation..."
  
  brew install phpbrew

  echo "✅ PHPbrew installed"
}
