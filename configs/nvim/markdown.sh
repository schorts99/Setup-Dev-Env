config_markdown() {
  echo "Configuring Markdown"

	if ! brew list marksman > /dev/null 2>&1; then
		brew install marksman
	fi

	GLOBAL_PKGS=(
		"prettier"
		"@fsouza/prettierd"
	)

	if pnpm list -g "${GLOBAL_PKGS[0]}" > /dev/null 2>&1; then
		echo " ✅ Dependencies already installed"
	else
		pnpm add -g "${GLOBAL_PKGS[@]}"

		echo " ➕ Dependencies installed"
	fi

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	MD_CONF_FILE="$CONF_DIR/markdown.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$MD_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "markdown.mdx" },
    root_markers = { ".marksman.toml", ".git" },
    single_file_support = true,
  })
  vim.lsp.enable("marksman")
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft.markdown = { "prettier" }
  conform.formatters_by_ft["markdown.mdx"] = { "prettier" }
end

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_browser = ""

vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown: Toggle Preview" })
vim.keymap.set("n", "<leader>ms", "<cmd>MarkdownPreview<CR>",       { desc = "Markdown: Start Preview" })
vim.keymap.set("n", "<leader>mq", "<cmd>MarkdownPreviewStop<CR>",   { desc = "Markdown: Stop Preview" })
EOF

	echo " ✅ Configuration file created"

	MD_MODULE="configs.$USER.markdown"
	MD_IMPORT="require('$MD_MODULE')"

	if grep -qF "$MD_IMPORT" "$MAIN_INIT"; then
		echo " ✅ init.lua already imports $MD_MODULE"
	else
		echo -e "$MD_IMPORT" >> "$MAIN_INIT"
		echo " ➕ Added $MD_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 Markdown configured"
}
