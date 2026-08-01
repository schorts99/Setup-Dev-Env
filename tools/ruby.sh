setup_ruby() {
	if command -v ruby >/dev/null 2>&1; then
		echo -e "${GREEN}✅ Ruby is already installed${NC}"

		return 0
	fi

	echo "${GREEN}📦 Starting Ruby installation...${NC}"

	os="$(uname -s)"

	if [[ "$os" == "Linux" ]]; then
		local packages=(
			build-essential
			rustc
			libssl-dev
			libyaml-dev
			zlib1g-dev
			libgmp-dev
		)
		local missing=()

		for pkg in "${packages[@]}"; do
			if ! dpkg -s "$pkg" &>/dev/null; then
				missing+=("$pkg")
			fi
		done

		if (( ${#missing[@]} > 0 )); then
			echo -e "${BLUE}  ➡ Installing ${missing[*]}...${NC}"
	
			sudo apt install -y "${missing[@]}"

			echo -e "${GREEN}  ✔ ${missing[*]} installed${NC}"
		fi

		mise settings ruby.compile=false
	fi

	mise install ruby@latest
	mise use -g ruby@latest

	if [[ "$SHELL" == *"zsh"* ]]; then
		eval "$(mise env -s zsh)"
	else
		eval "$(mise env -s bash)"
	fi

	gem update --system

	echo "✅ Ruby installed"
}
