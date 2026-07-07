config_git() {
	if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is not installed"
    
    return 1
  fi

	echo "Starting Git configuration..."

	git config --global core.editor "nvim -f"

	echo "✅ Git configured"
}

