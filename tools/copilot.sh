setup_copilot() {
  if command -v copilot >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Copilot is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Copilot installation...${NC}"

  brew install copilot-cli

  echo -e "${GREEN}✅ Copilot installed successfully!${NC}"
}
