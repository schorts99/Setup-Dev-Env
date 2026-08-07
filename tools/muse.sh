setup_muse() {
	if command -v muse >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Muse is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Muse installation...${NC}"

	curl -fsSL https://dev.meta.ai/install.sh | bash

  echo -e "${GREEN}✅ Muse installed successfully!${NC}"
}
