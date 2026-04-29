config_vue() {
	echo "Configuring Vue.js"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	VUE_CONF_FILE="$CONF_DIR/vue.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$VUE_CONF_FILE"
if vim.lsp.config then
	vim.lsp.config("vue_ls", {
		filetypes = { 'vue', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
		init_options = {
			vue = {
				hybridMode = true,
			},
			typescript = {
				tsdk = "node_modules/typescript/lib",
			},
		},
	})

	vim.lsp.enable("vue_ls")
end

local status, conform = pcall(require, "conform")

if status then
	conform.formatters_by_ft.vue = { "prettier" }
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")

if status_tag then
	autotag.setup()
end
EOF

	echo "  ✅ Configuration file created"

	VUE_MODULE="configs.$USER.vue"
	VUE_IMPORT="require('$VUE_MODULE')"

	if grep -qF "$VUE_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $VUE_MODULE"
	else
		echo -e "$VUE_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $VUE_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 Vue.js configured"
}
