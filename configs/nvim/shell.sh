config_shell() {
	echo "Configuring Shell"

	pnpm add -g bash-language-server
	brew install shfmt shellcheck

	echo "  ✅ Dependencies installed"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	SHELL_CONF_FILE="$CONF_DIR/shell.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$SHELL_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("bashls", {
    filetypes = { "sh", "bash", "zsh" },
  })

  vim.lsp.enable("bashls")
end

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.sh = { "shfmt" }
  conform.formatters_by_ft.bash = { "shfmt" }
  conform.formatters_by_ft.zsh = { "shfmt" }
end
EOF

	echo "  ✅ Configuration file created"

	SHELL_MODULE="configs.$USER.shell"
	SHELL_IMPORT="require('$SHELL_MODULE')"

	if grep -qF "$SHELL_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $SHELL_MODULE"
	else
		echo -e "$SHELL_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $SHELL_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 Shell configured"
}
