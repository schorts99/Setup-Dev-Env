config_svelte() {
  echo "Configuring Svelte"

  nvim_write_conf svelte <<'EOF'
if vim.lsp.config then
  vim.lsp.enable("svelte")
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft.svelte = { "prettierd", "prettier", stop_after_first = true }
end
EOF

  nvim_import_conf svelte
  ensure_mason_pkgs svelte-language-server

  echo "🎉 Svelte configured"
}
