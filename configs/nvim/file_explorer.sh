config_file_explorer() {
	echo "Configuring File Explorer"

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	FILE_EXPLORER_CONF_FILE="$CONF_DIR/file_explorer.lua" 
	MAIN_INIT="$NVIM_DIR/lua/plugins/init.lua"

	cat << "EOF" > "$FILE_EXPLORER_CONF_FILE"
local M = {}

M.nvimtree = {
  filters = {
    dotfiles = false,
    custom = { "^.git$", "node_modules", "dist", ".next", ".nuxt", "build", ".DS_Store", "coverage" },
    exclude = { ".env", ".env.local" },
  },
}

M.telescope = {
  defaults = {
    file_ignore_patterns = { "node_modules", "%.git/", "dist/", "%.next/", "%.nuxt/" },
  }
}

return M
EOF

	echo "  ✅ Configuration file created"

	local entry_check="configs.$USER.file_explorer"

	if grep -qF "$entry_check" "$MAIN_INIT"; then
			echo "  ✅ init.lua already contains overrides"
	else
		local snippet="  {
\"nvim-tree/nvim-tree.lua\",
opts = require(\"configs.$USER.file_explorer\").nvimtree,
},
{
\"nvim-telescope/telescope.nvim\",
opts = require(\"configs.$USER.file_explorer\").telescope,
},"
		head -n -1 "$MAIN_INIT" > "${MAIN_INIT}.tmp"
		echo "$snippet" >> "${MAIN_INIT}.tmp"
		echo "}" >> "${MAIN_INIT}.tmp"
		mv "${MAIN_INIT}.tmp" "$MAIN_INIT"

		echo "  ➕ Injected overrides into $MAIN_INIT"
	fi

	echo "🎉 File Explorer configured"
}
