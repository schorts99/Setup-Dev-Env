setup_ollama() {
  if command -v ollama >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Ollama is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Ollama installation...${NC}"

	curl -fsSL https://ollama.com/install.sh | sh

  echo -e "${GREEN}✅ Ollama installed successfully!${NC}"
}
