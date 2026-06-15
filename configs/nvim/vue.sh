config_vue() {
	echo "Configuring Vue.js"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	VUE_CONF_FILE="$CONF_DIR/vue.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

  cat << "EOF" > "$VUE_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("vue_ls", {
    filetypes = { "vue" },
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  })
  vim.lsp.enable("vue_ls")

  vim.lsp.config("ts_ls", {
    filetypes = { "javascript", "typescript", "vue" },
    init_options = {
      plugins = {
        {
          name = "@vue/language-server",
          location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
          languages = { "vue" },
        },
      },
    },
  })
  vim.lsp.enable("ts_ls")

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

	nvim --headless "+MasonInstall vue-language-server typescript-language-server" +qall

	echo "🎉 Vue.js configured"
}
