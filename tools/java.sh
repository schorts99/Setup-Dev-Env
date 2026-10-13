setup_java() {
  if mise where java >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Java is already installed${NC}"

    return 0
  fi

  echo -e "${YELLOW}📦 Starting Java installation...${NC}"

	mise install java@latest
	mise use --global java@latest

  echo -e "${GREEN}✅ Java installed successfully!${NC}"
}
