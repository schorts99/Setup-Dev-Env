setup_git() {
  if command -v git >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Git is already installed${NC}"
    
    return 0
  fi

  echo -e "${YELLOW}📦 Starting Git installation...${NC}"

  sudo apt-get install -y git

	echo -e "${BLUE}  ➡ Configuring git...${NC}"

  read -p "  Enter your name: " USER_NAME
  read -p "  Enter your email: " USER_EMAIL

  git config --global color.ui true
  git config --global user.name "$USER_NAME"
  git config --global user.email "$USER_EMAIL"

	echo -e "${GREEN}  ✔ Git configured${NC}"

  echo -e "${GREEN}✅ Git installed successfully!${NC}"
}

