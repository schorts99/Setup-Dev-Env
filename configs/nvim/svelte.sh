config_svelte() {
	echo "Configuring Svelte"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	SVELTE_CONF_FILE="$CONF_DIR/svelte.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$SVELTE_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("svelte", {
    filetypes = { "svelte" },
  })
  vim.lsp.enable("svelte")

end

local status, conform = pcall(require, "conform")
if status then
	conform.formatters_by_ft.svelte = { "prettier" }
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")
if status_tag then
	autotag.setup()
end
EOF

	echo "  ✅ Configuration file created"

	SVELTE_MODULE="configs.$USER.svelte"
	SVELTE_IMPORT="require('$SVELTE_MODULE')"

	if grep -qF "$SVELTE_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $SVELTE_MODULE"
	else
		echo -e "$SVELTE_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $SVELTE_IMPORT to $MAIN_INIT"
	fi

	nvim --headless "+MasonInstall svelte-language-server" +qall

	echo "🎉 Svelte configured"
}
