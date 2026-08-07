setup_grok() {
	if command -v grok >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Grok is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Grok installation...${NC}"

	curl -fsSL https://x.ai/cli/install.sh | bash

  echo -e "${GREEN}✅ Grok installed successfully!${NC}"
}
