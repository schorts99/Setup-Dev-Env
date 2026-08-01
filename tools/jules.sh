setup_jules() {
	if command -v jules >/dev/null 2>&1; then
		echo -e "${GREEN}✅ Jules is already installed${NC}"
    
    return 0
	fi

	echo -e "${YELLOW}📦 Starting Jules installation...${NC}"

	npm install -g @google/jules

	echo -e "${GREEN}✅ Jules installed successfully!${NC}"
}
