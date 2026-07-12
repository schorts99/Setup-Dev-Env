setup_terraform() {
	if command -v terraform >/dev/null 2>&1; then
    echo "✅ Terraform is already installed"
    
    return 0
  fi

	echo "Starting Terraform installation..."

	brew tap hashicorp/tap
	brew install hashicorp/tap/terraform

	echo "✅ Terraform installed"
}
