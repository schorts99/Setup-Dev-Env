config_node() {
	echo "Configuring NodeJS"

	nvim_write_conf node <<"EOF"
-- .env, .env.local, production.env, ... (but not app.environment.ts)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", ".env.*", "*.env" },
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

local status, conform = pcall(require, "conform")

if status then
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  conform.formatters_by_ft.json = prettier
  conform.formatters_by_ft.jsonc = prettier
  conform.formatters_by_ft.yaml = prettier
end
EOF

	nvim_import_conf node

	echo "🎉 NodeJS configured"
}
