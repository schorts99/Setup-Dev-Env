setup_herdr() {
	if command -v herdr >/dev/null 2>&1; then
		 echo -e "${GREEN}✅ Herdr is already installed${NC}"
    
    return 0
	fi

	echo -e "${YELLOW}📦 Starting Herdr installation...${NC}"

	curl -fsSL https://herdr.dev/install.sh | sh

	echo -e "${GREEN}✅ Herdr installed successfully!${NC}"
}
