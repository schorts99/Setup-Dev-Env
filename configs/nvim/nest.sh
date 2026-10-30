config_nest() {
	echo "Configuring NestJS"

	ensure_pnpm_globals "@nestjs/cli"

	nvim_write_conf nest <<"EOF"
if vim.lsp.config then
	vim.lsp.config("vtsls", {
		settings = {
			typescript = {
				preferences = {
					importModuleSpecifierPreference = "non-relative",
					includePackageJsonAutoImports = "on",
				},
			},
		},
	})
end
EOF

	nvim_import_conf nest

	echo "🎉 NestJS configured"
}
