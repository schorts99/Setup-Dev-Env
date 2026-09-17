setup_ruby_on_rails() {
	if command -v rails >/dev/null 2>&1; then
	  if rails --version 2>/dev/null | grep -qE 'Rails [0-9]'; then
      echo -e "${GREEN}✅ Ruby On Rails is already installed${NC}"

      return 0
    fi
	fi

	echo -e "${GREEN}📦 Starting Ruby On Rails installation...${NC}"

	gem install rails

	echo -e "${GREEN}✅ Ruby On Rails installed successfully!${NC}"
}
