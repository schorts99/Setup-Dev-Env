setup_neovim() {
  if command -v nvim >/dev/null 2>&1; then
    echo -e "${GREEN}✅ NeoVim is already installed${NC}"
    
    return 0
  fi

  echo "${YELLOW}📦 Starting NeoVim installation...${NC}"

	if ! command -v unzip >/dev/null 2>&1; then
		echo -e "${BLUE}  ➡ Installing unzip...${NC}"
		
		brew install unzip

		echo -e "${GREEN}  ✔ unzip installed${NC}"
	fi

  brew install neovim
  
  echo -e "${GREEN}✅ NeoVim installed successfully!${NC}"
}

