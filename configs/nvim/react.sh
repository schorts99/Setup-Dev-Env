config_react() {
  echo "Configuring React"

  # vtsls (from config_js / config_ts) already covers .jsx/.tsx; eslint comes from vscode-langservers-extracted
  ensure_pnpm_globals "vscode-langservers-extracted"

  nvim_write_conf react <<'EOF'
if vim.lsp.config then
  vim.lsp.enable("eslint")
end

local status, conform = pcall(require, "conform")
if status then
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  conform.formatters_by_ft.javascriptreact = prettier
  conform.formatters_by_ft.typescriptreact = prettier
end
EOF

  nvim_import_conf react

  echo "🎉 React configured"
}
