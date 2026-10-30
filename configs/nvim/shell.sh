config_shell() {
	echo "Configuring Shell"

	ensure_pnpm_globals "bash-language-server"
	ensure_brew_pkgs "shfmt" "shellcheck"

	nvim_write_conf shell <<"EOF"
if vim.lsp.config then
  vim.lsp.config("bashls", {
    filetypes = { "sh", "bash", "zsh" },
  })

  vim.lsp.enable("bashls")
end

local status, conform = pcall(require, "conform")

if status then
  conform.formatters_by_ft.sh = { "shfmt" }
  conform.formatters_by_ft.bash = { "shfmt" }
  conform.formatters_by_ft.zsh = { "shfmt" }
end
EOF

	nvim_import_conf shell

	echo "🎉 Shell configured"
}
