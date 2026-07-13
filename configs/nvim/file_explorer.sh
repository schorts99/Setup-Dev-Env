config_file_explorer() {
  echo "Configuring File Explorer"

  local NVIM_DIR="$HOME/.config/nvim"
  local CONF_DIR="$NVIM_DIR/lua/configs/$USER"
  local FILE_EXPLORER_CONF_FILE="$CONF_DIR/file_explorer.lua"
  local MAIN_INIT="$NVIM_DIR/lua/plugins/init.lua"

  mkdir -p "$CONF_DIR"
  touch "$MAIN_INIT"

  cat > "$FILE_EXPLORER_CONF_FILE" <<'EOF'
local M = {}

M.nvimtree = {
  filters = {
    dotfiles = false,
    custom = {
      "^.git$",
      "node_modules",
      "dist",
      ".next",
      ".nuxt",
      "build",
      ".DS_Store",
      "coverage",
    },
    exclude = { ".env", ".env.local" },
  },
}

M.telescope = {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%.git/",
      "dist/",
      "%.next/",
      "%.nuxt/",
    },
  },
}

return M
EOF

  echo "  ✅ Configuration file created"

  local entry_check="configs.$USER.file_explorer"

  if grep -qF "$entry_check" "$MAIN_INIT"; then
    echo "  ✅ init.lua already contains overrides"
  else
    sed '$d' "$MAIN_INIT" > "${MAIN_INIT}.tmp"
    cat >> "${MAIN_INIT}.tmp" <<EOF
  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.$USER.file_explorer").nvimtree,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = require("configs.$USER.file_explorer").telescope,
  },
}
EOF

    mv "${MAIN_INIT}.tmp" "$MAIN_INIT"

    echo "  ➕ Injected overrides into $MAIN_INIT"
  fi

  echo "🎉 File Explorer configured"
}
