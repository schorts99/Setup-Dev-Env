config_catppuccin() {
  echo "Configuring Catppuccin"

  nvim_write_conf catppuccin <<'EOF'
local status, catppuccin = pcall(require, "catppuccin")
if not status then
  vim.notify("catppuccin not found – install the plugin first (lazy)", vim.log.levels.WARN)
  return
end
catppuccin.setup({
  flavour = "frappe", -- latte | frappe | macchiato | mocha
  background = {
    light = "latte",
    dark = "frappe",
  },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  no_underline = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    mason = true,
    telescope = { enabled = true },
    which_key = true,
  },
})
-- Load the colorscheme (must be after setup)
vim.cmd.colorscheme "catppuccin"
EOF

  # Prepended so the colorscheme is applied before the other user modules load
  local CAT_MODULE="configs.$USER.catppuccin"
  local CAT_IMPORT="require('$CAT_MODULE')"
  local MAIN_INIT="$NVIM_CONF_DIR/init.lua"

  touch "$MAIN_INIT"

  if ! grep -qF "$CAT_IMPORT" "$MAIN_INIT"; then
    {
      echo "$CAT_IMPORT"
      cat "$MAIN_INIT"
    } > "$MAIN_INIT.tmp" && mv "$MAIN_INIT.tmp" "$MAIN_INIT"
    echo "  ➕ Added $CAT_IMPORT"
  else
    echo "  ✅ init.lua already imports $CAT_MODULE"
  fi

  nvim_write_plugin_spec catppuccin <<EOF
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before other plugins
  lazy = false,    -- make sure it loads on startup
  config = function()
    -- real setup lives in lua/configs/$USER/catppuccin.lua
  end,
}
EOF

  local DATA_DIR
  DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"
  local CAT_DIR="$DATA_DIR/lazy/catppuccin"

  if [ -d "$CAT_DIR" ]; then
    echo "  ✅ Catppuccin already installed"
  else
    echo "  📦 Installing Catppuccin..."

    nvim --headless "+Lazy! install catppuccin" +qall >/dev/null 2>&1 || true

    if [ -d "$CAT_DIR" ]; then
      echo "  ✅ Catppuccin installed"
    else
      echo "  ⚠️  Lazy install may need a manual :Lazy sync"
    fi
  fi

  echo "🎉 Catppuccin configured"
  echo "   Flavour: frappe  (edit $NVIM_CONF_DIR/catppuccin.lua to change)"
  echo "   Available: latte | frappe | macchiato | mocha"
}
