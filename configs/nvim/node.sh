config_node() {
	echo "Configuring NodeJS"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	NODE_CONF_FILE="$CONF_DIR/node.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$NODE_CONF_FILE"
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.env*",
  command = "set filetype=sh",
})

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.json = { "prettier" }
  conform.formatters_by_ft.yaml = { "prettier" }
end
EOF

	echo "  ✅ Configuration file created"

	NODE_MODULE="configs.$USER.node"
	NODE_IMPORT="require('$NODE_MODULE')"

	if grep -qF "$NODE_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $NODE_MODULE"
	else
		echo -e "$NODE_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $NODE_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 NodeJS configured"
}
