setup_java() {
  if command -v java >/dev/null 2>&1; then
    echo "✅ Java is already installed"
    
    return 0
  fi

  echo "Starting Java installation..."

  source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk install java

  echo "✅ Java installed"
}
