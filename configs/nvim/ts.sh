config_ts() {
	echo "Configuring TypeScript"

	ensure_pnpm_globals \
		"@vtsls/language-server" \
		"typescript"

	nvim_write_conf ts <<"EOF"
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
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  conform.formatters_by_ft.typescript = prettier
  conform.formatters_by_ft.typescriptreact = prettier
end
EOF

	nvim_import_conf ts

	echo "🎉 TypeScript configured"
}
