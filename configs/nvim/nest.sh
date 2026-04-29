config_nest() {
	echo "Configuring NestJS"

	GLOBAL_PKGS=(
		"@nestjs/cli"
	)

	if pnpm list -g "${GLOBAL_PKGS[0]}" > /dev/null 2>&1; then
		echo "  ✅ Dependencies already installed"
	else
		pnpm add -g "${GLOBAL_PKGS[@]}"

		echo "  ➕ Dependencies installed"
	fi

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	NEST_CONF_FILE="$CONF_DIR/nest.lua"
	MAIN_INIT="$CONF_DIR/init.lua"

	cat << "EOF" > "$NEST_CONF_FILE"
if vim.lsp.config then
	vim.lsp.config("vtsls", {
		settings = {
			typescript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					includePackageJsonAutoImports = "always",
				},
				suggest = {
					-- Better suggestions for class members and decorators
					completeFunctionCalls = true,
				},
			},
		},
	})
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.controller.ts", "*.service.ts", "*.module.ts", "*.dto.ts" },
	callback = function()
		vim.opt_local.filetype = "typescript"
	end,
})

local status, conform = pcall(require, "conform")

if status then
	conform.formatters_by_ft.typescript = { "prettier" }
end
EOF

	echo "  ✅ Configuration file created"

	NEST_MODULE="configs.$USER.nest"
	NEST_IMPORT="require('$NEST_MODULE')"

	if grep -qF "$NEST_IMPORT" "$MAIN_INIT"; then
		echo "  ✅ init.lua already imports $NEST_MODULE"
	else
		echo -e "$NEST_IMPORT" >> "$MAIN_INIT"
		echo "  ➕ Added $NEST_IMPORT to $MAIN_INIT"
	fi

	echo "🎉 NestJS configured"
}
