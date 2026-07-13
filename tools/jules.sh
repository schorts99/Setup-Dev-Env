setup_jules() {
	if command -v jules >/dev/null 2>&1; then
		echo "✅ Jules is already installed"
    
    return 0
	fi

	echo "Starting Jules installation..."

	npm install -g @google/jules

	echo "✅ Jules installed"
}
