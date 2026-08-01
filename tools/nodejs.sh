setup_nodejs() {
  if command -v node >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Node.js is already installed${NC}"
    
    return 0
  fi

	echo -e "${YELLOW}📦 Starting Node.js installation...${NC}"

	mise install node@latest
	mise use --global node@latest

  echo -e "${GREEN}✅ Node.js installed successfully!${NC}"
}
