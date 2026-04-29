config_ts() {
	echo "Configuring TypeScript"

	pnpm add -g @types/node @types/react @types/react-dom

	echo "  ✅ Dependencies installed"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	TS_CONF_FILE="$CONF_DIR/ts.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$TS_CONF_FILE"
if vim.lsp.config then
  vim.lsp.config("vtsls", {
    settings = {
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = { completeFunctionCalls = true },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = true },
        },
      },
    },
  })

  vim.lsp.enable("vtsls")
end

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.typescript = { "prettier" }
  conform.formatters_by_ft.typescriptreact = { "prettier" }
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")

if status_tag then
  autotag.setup()
end
EOF

	echo "  ✅ Configuration file created"

	TS_MODULE="configs.$USER.ts"
	TS_IMPORT="require('$TS_MODULE')"

	if grep -qF "$TS_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $TS_MODULE"
	else
		echo -e "$TS_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $TS_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 TypeScript configured"
}
