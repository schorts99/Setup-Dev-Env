setup_nodejs() {
  if command -v node >/dev/null 2>&1; then
    echo "✅ Node.js is already installed"
    
    return 0
  fi

	echo "Starting Node.js installation..."

  LATEST_NODE_VERSION=$(fnm list-remote | tail -1)
  
	fnm install $LATEST_NODE_VERSION

  if [[ "$SHELL" == *"zsh"* ]]; then
    echo >> /Users/$USER/.zshrc
    echo 'eval "$(fnm env --use-on-cd --shell zsh)"' >> /Users/$USER/.zshrc
    eval "$(fnm env --use-on-cd --shell zsh)"
  else
    echo >> /home/$USER/.bashrc
    echo 'eval "$(fnm env --use-on-cd --shell bash)"' >> /home/$USER/.bashrc
    eval "$(fnm env --use-on-cd --shell bash)"
  fi

  fnm use "$LATEST_NODE_VERSION" >/dev/null

  echo "✅ Node.js installed"
}
