setup_codex() {
	if command -v codex >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Codex is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Codex installation...${NC}"

	brew install --cask codex

  echo -e "${GREEN}✅ Codex installed successfully!${NC}"
}
