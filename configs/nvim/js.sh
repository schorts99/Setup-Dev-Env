config_js() {
	echo "Configuring JavaScript"

	ensure_pnpm_globals \
		"@vtsls/language-server" \
		"typescript" \
		"vscode-langservers-extracted" \
		"prettier" \
		"@fsouza/prettierd"

	nvim_write_conf js <<"EOF"
if vim.lsp.config then
  vim.lsp.config("vtsls", {
    settings = {
      javascript = {
        updateImportsOnFileMove = { enabled = "always" },
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
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  conform.formatters_by_ft.javascript = prettier
  conform.formatters_by_ft.javascriptreact = prettier
end
EOF

	nvim_import_conf js

	echo "🎉 JavaScript configured"
}
