config_js() {
	echo "Configuring JavaScript"

	GLOBAL_PKGS=(
		"@vtsls/language-server"
		"typescript"
		"typescript-language-server"
		"vscode-langservers-extracted"
		"prettier"
	)

	if pnpm list -g "${GLOBAL_PKGS[0]}" > /dev/null 2>&1; then
		echo "  ✅ Dependencies already installed"
	else
		pnpm add -g "${GLOBAL_PKGS[@]}"

		echo "  ➕ Dependencies installed"
	fi

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	JS_CONF_FILE="$CONF_DIR/js.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$JS_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("vtsls", {
    settings = {
      javascript = {
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          parameterNames = { enabled = "all" },
          variableTypes = { enabled = true },
        },
      },
    },
  })

  vim.lsp.enable("vtsls")
end

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.javascript = { "prettier" }
  conform.formatters_by_ft.javascriptreact = { "prettier" }
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

	echo "🎉 JavaScript configured"
}
