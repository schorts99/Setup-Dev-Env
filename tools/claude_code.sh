setup_claude_code() {
  if command -v claude >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Claude Code is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Claude Code installation...${NC}"

  curl -fsSL https://claude.ai/install.sh | bash

  echo -e "${GREEN}✅ Claude Code installed successfully!${NC}"
}
