setup_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Homebrew is already installed${NC}"
    
    return 0
  fi

	echo -e "${YELLOW}📦 Starting Homebrew installation...${NC}"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [[ "$SHELL" == *"zsh"* ]]; then
    echo >> "/Users/$USER/.zprofile"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> "/Users/$USER/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  else
    echo >> "/home/$USER/.bashrc"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> "/home/$USER/.bashrc"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

    if ! dpkg -l | grep -q build-essential; then
			echo -e "${BLUE}  ➡ Installing build-essential...${NC}"
	
      sudo apt-get install -y build-essential

			echo -e "${GREEN}  ✔ build-essential installed${NC}"
    fi

    if ! command -v gcc >/dev/null 2>&1; then
			echo -e "${BLUE}  ➡ Installing gcc...${NC}"

      brew install --quiet gcc

			echo -e "${GREEN}  ✔ gcc installed${NC}"
    fi
  fi

	echo -e "${GREEN}✅ Homebrew installed successfully!${NC}"
}
