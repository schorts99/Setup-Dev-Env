setup_antigravity() {
  if command -v agy >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Antigravity is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Antigravity installation...${NC}"

  brew install antigravity-cli

  echo -e "${GREEN}✅ Antigravity installed successfully!${NC}"
}
