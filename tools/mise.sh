setup_mise() {
	if command -v mise >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Mise is already installed${NC}"
    
    return 0
  fi

	echo -e "${YELLOW}📦 Starting Mise installation...${NC}"

	curl https://mise.run | sh

	echo -e "${BLUE}  ➡ Configuring Mise...${NC}"

	if [[ "$SHELL" == *"zsh"* ]]; then
		echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.zshrc
	else
		echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.bashrc
	fi

	echo -e "${GREEN}  ✔ Mise configured${NC}"

	eval "$(~/.local/bin/mise activate)"

	echo "✅ Mise installed"
}
