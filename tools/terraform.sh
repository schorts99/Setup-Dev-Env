setup_terraform() {
	if command -v terraform >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Terraform is already installed${NC}"
    
    return 0
  fi

	echo -e "${YELLOW}📦 Starting Terraform installation...${NC}"

	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform

	echo -e "${GREEN}✅ Terraform installed successfully!${NC}"
}
