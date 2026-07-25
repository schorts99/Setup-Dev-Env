setup_mise() {
	if command -v mise >/dev/null 2>&1; then
    echo "✅ Mise is already installed"
    
    return 0
  fi

	echo "Starting Mise installation..."

	curl https://mise.run | sh

	if [[ "$SHELL" == *"zsh"* ]]; then
		echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.zshrc
	else
		echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.bashrc
	fi

	eval "$(~/.local/bin/mise activate)"

	echo "✅ Mise installed"
}
