setup_http_client() {
  if command -v ijhttp >/dev/null 2>&1; then
    echo "✅ HTTP Client is already installed"
    
    return 0
  fi

  echo "Starting HTTP Client installation..."

  brew install ijhttp

  echo "✅ HTTP Client installed"
}
