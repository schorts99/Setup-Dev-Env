setup_python() {
	if mise where python &>/dev/null; then
    echo -e "${GREEN}✅ Python is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Python installation...${NC}"

	if ! command -v wish &> /dev/null; then
		echo -e "${BLUE}  ➡ Installing tcl-tk...${NC}"

		brew install tcl-tk

		echo -e "${GREEN}  ✔ tcl-tk installed${NC}"
	fi

	mise install python@latest
	mise use --global python@latest

  echo -e "${GREEN}✅ Python installed successfully!${NC}"
}
