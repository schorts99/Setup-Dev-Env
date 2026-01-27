setup_nodejs() {
  if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js is already installed"
    
    return 0
  fi

  echo "Starting Node.js installation..."

  LATEST_NODE_VERSION=$(fnm list-remote | tail -1)
  fnm install $LATEST_NODE_VERSION

  echo "✅ Node.js installed"
}

