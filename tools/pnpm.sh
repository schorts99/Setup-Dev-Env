setup_pnpm() {
  if command -v pnpm >/dev/null 2>&1; then
    echo -e "${GREEN}✅ PNPM is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting PNPM installation...${NC}"

  npm install -g pnpm@latest
	pnpm setup

  echo -e "${GREEN}✅ PNPM installed successfully!${NC}"
}

