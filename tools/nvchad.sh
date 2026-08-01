setup_nvchad() {
  if [ -f "$HOME/.config/nvim/lua/chadrc.lua" ]; then
    echo -e "${GREEN}✅ NvChad is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting NvChad installation...${NC}"

  if ! command -v tree-sitter >/dev/null 2>&1; then
		echo -e "${BLUE}  ➡ Installing tree-sitter...${NC}"

    npm install -g tree-sitter-cli

		echo -e "${GREEN}  ✔ tree-sitter installed${NC}"
  fi

  if ! command -v rg >/dev/null 2>&1; then
		echo -e "${BLUE}  ➡ Installing rg...${NC}"

    brew install ripgrep

		echo -e "${GREEN}  ✔ rg installed${NC}"
  fi

  if ! command -v gcc >/dev/null 2>&1; then
		echo -e "${BLUE}  ➡ Installing gcc...${NC}"

    brew install gcc

		echo -e "${GREEN}  ✔ gcc installed${NC}"
  fi

  if ! command -v make >/dev/null 2>&1; then
		echo -e "${BLUE}  ➡ Installing make...${NC}"

    brew install make

		echo -e "${GREEN}  ✔ make installed${NC}"
  fi

  git clone https://github.com/NvChad/starter ~/.config/nvim && nvim

  echo -e "${GREEN}✅ NvChad installed successfully!${NC}"
}
