config_file_explorer() {
  echo "Configuring File Explorer"

  nvim_write_conf file_explorer <<'EOF'
local M = {}

-- nvim-tree filters are vim regexes matched against the file name
M.nvimtree = {
  filters = {
    dotfiles = false,
    custom = {
      "^\\.git$",
      "^node_modules$",
      "^dist$",
      "^\\.next$",
      "^\\.nuxt$",
      "^\\.svelte-kit$",
      "^build$",
      "^coverage$",
      "^\\.DS_Store$",
    },
    exclude = { ".env", ".env.local" },
  },
}

-- telescope patterns are lua patterns matched against the path
M.telescope = {
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      "%.git/",
      "dist/",
      "build/",
      "coverage/",
      "%.next/",
      "%.nuxt/",
      "%.svelte%-kit/",
    },
  },
}

return M
EOF

  nvim_write_plugin_spec file_explorer <<EOF
return {
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

  # Older versions of this script injected the same specs into plugins/init.lua
  local plugins_init="$NVIM_PLUGINS_DIR/init.lua"

  if [ -f "$plugins_init" ] && grep -qF "configs.$USER.file_explorer" "$plugins_init"; then
    MODULE="configs.$USER.file_explorer" perl -0pi -e '
      my $m = quotemeta $ENV{MODULE};
      s/[ \t]*\{\s*"nvim-tree\/nvim-tree\.lua",\s*opts = require\("$m"\)\.nvimtree,\s*\},\n//;
      s/[ \t]*\{\s*"nvim-telescope\/telescope\.nvim",\s*opts = require\("$m"\)\.telescope,\s*\},\n//;
    ' "$plugins_init"
    echo "  ➖ Removed legacy overrides from $plugins_init"
  fi

  echo "🎉 File Explorer configured"
}
