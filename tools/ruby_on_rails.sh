setup_ruby_on_rails() {
	if command -v rails >/dev/null 2>&1; then
		echo -e "${GREEN}✅ Ruby On Rails is already installed${NC}"

		return 0
	fi

	echo -e "${GREEN}📦 Starting Ruby On Rails installation...${NC}"

	gem install rails

	echo -e "${GREEN}✅ Ruby On Rails installed successfully!${NC}"
}
