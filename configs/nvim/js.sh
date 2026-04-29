config_js() {
	echo "Configuring JS"

	pnpm add -g typescript typescript-language-server vscode-langservers-extracted prettier

	echo "  ✅ Dependencies installed"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	JS_CONF_FILE="$CONF_DIR/js.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$JS_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("vtsls", {
    settings = {
      typescript = {
        inlayHints = {
          parameterNames = { enabled = "all" },
          variableTypes = { enabled = true },
        },
      },
    },
  })
    
  vim.lsp.enable("vtsls")
else
  local status, lspconfig = pcall(require, "lspconfig")

  if status then
    lspconfig.vtsls.setup({})
  end
end

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.javascript = { "prettier" }
  conform.formatters_by_ft.typescript = { "prettier" }
end
EOF
	
	echo "  ✅ Configuration file created"

	JS_MODULE="configs.$USER.js"
	JS_IMPORT="require('$JS_MODULE')"

	if grep -qF "$JS_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $JS_MODULE"
	else
		echo -e "$JS_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $JS_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 JS configured"
}
