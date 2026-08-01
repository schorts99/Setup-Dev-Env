setup_php() {
	if mise where php &>/dev/null; then
		 echo -e "${GREEN}✅ PHP is already installed${NC}"

		 return 0
	fi

	echo -e "${YELLOW}📦 Starting PHP installation...${NC}"

	os="$(uname -s)"

	if [[ "$os" == "Linux" ]]; then
		local packages=(
			pkg-config
			libsqlite3-dev
			libonig-dev
			libicu-dev
			libzip-dev
			libcurl4-openssl-dev
			libpng-dev
			libjpeg-dev
			libwebp-dev
			libfreetype6-dev
			libssl-dev
			libxml2-dev
			libreadline-dev
			libsodium-dev
			zlib1g-dev
			build-essential
			autoconf
			bison
			re2c
			libgd-dev
			libpng-dev
			libjpeg-dev
			libwebp-dev
			libfreetype6-dev
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
	fi

	mise install php@latest
	mise use -g php@latest

	echo -e "${GREEN}✅ PHP installed successfully!${NC}"
}
