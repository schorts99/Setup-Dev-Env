setup_github() {
  if command -v gh >/dev/null 2>&1; then
    echo -e "${GREEN}✅ GitHub is already installed${NC}"
    
    return 0
  fi


  echo -e "${YELLOW}📦 Starting GitHub installation...${NC}"

  brew install gh
	
	echo -e "${BLUE}  ➡ Configuring GitHub...${NC}"

  gh auth login

	echo -e "${GREEN}  ✔ GitHub configured${NC}"
  echo -e "${GREEN}✅ GitHub installed successfully!${NC}"
}

