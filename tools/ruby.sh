setup_ruby() {
	if command -v ruby >/dev/null 2>&1; then
		echo "✅ Ruby is already installed"

		return 0
	fi

	echo "Starting Ruby installation..."

	os="$(uname -s)"

	if [[ "$os" == "Linux" ]]; then
		sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev
		mise settings ruby.compile=false
	fi

	mise use --global ruby@latest

	if [[ "$SHELL" == *"zsh"* ]]; then
		eval "$(mise env -s zsh)"
	else
		eval "$(mise env -s bash)"
	fi

	gem update --system

	echo "✅ Ruby installed"
}
