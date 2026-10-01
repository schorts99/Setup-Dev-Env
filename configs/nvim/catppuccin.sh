config_catppuccin() {
  echo "Configuring Catppuccin"
  
	local NVIM_DIR="$HOME/.config/nvim"
  local CONF_DIR="$NVIM_DIR/lua/configs/$USER"
  local CAT_CONF_FILE="$CONF_DIR/catppuccin.lua"
  local MAIN_INIT="$CONF_DIR/init.lua"
  local LAZY_SPEC_DIR="$NVIM_DIR/lua/plugins"
  local LAZY_SPEC_FILE="$LAZY_SPEC_DIR/catppuccin.lua"
  
	mkdir -p "$CONF_DIR" "$LAZY_SPEC_DIR"
  touch "$MAIN_INIT"

  cat > "$CAT_CONF_FILE" <<'EOF'
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
    -- mason = true,
    -- telescope = true,
    -- which_key = true,
  },
})
-- Load the colorscheme (must be after setup)
vim.cmd.colorscheme "catppuccin"
EOF
  echo "  ✅ Configuration file created"

  local CAT_MODULE="configs.$USER.catppuccin"
  local CAT_IMPORT="require('$CAT_MODULE')"
  
	if grep -qF "$CAT_IMPORT" "$MAIN_INIT"; then
    echo "  ✅ init.lua already imports $CAT_MODULE"
  else
    if [ -s "$MAIN_INIT" ]; then
      sed -i "1i$CAT_IMPORT" "$MAIN_INIT"
    else
      echo -e "$CAT_IMPORT" >> "$MAIN_INIT"
    fi
    echo "  ➕ Added $CAT_IMPORT"
  fi

  cat > "$LAZY_SPEC_FILE" <<'EOF'
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- load before other plugins
  lazy = false,    -- make sure it loads on startup
  config = function()
    -- real setup lives in configs/$USER/catppuccin.lua
  end,
}
EOF
  echo "  ✅ Lazy plugin spec created"

  local LAZY_INIT="$NVIM_DIR/lua/config/lazy.lua"
  local LAZY_PLUGINS="$NVIM_DIR/lua/plugins/init.lua"
  local ROOT_INIT="$NVIM_DIR/init.lua"
  local PLUGINS_IMPORTED=false
  
	for f in "$LAZY_INIT" "$ROOT_INIT" "$NVIM_DIR/lua/lazy.lua"; do
    if [ -f "$f" ] && grep -qE 'plugins|import.*=.*"plugins"' "$f" 2>/dev/null; then
      PLUGINS_IMPORTED=true
      break
    fi
  done
  if [ "$PLUGINS_IMPORTED" = false ] && [ ! -f "$LAZY_PLUGINS" ]; then
    cat > "$LAZY_PLUGINS" <<'EOF'
-- Auto-collected plugin specs from lua/plugins/*.lua
return {
  { import = "plugins" },
}
EOF
    echo "  ➕ Created $LAZY_PLUGINS"
  fi

  local DATA_DIR
  DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"
  local CAT_DIR="$DATA_DIR/lazy/catppuccin"

  if [ -d "$CAT_DIR" ]; then
    echo "  ✅ Catppuccin already installed"
  else
    echo "  📦 Installing Catppuccin..."
    
		nvim --headless "+Lazy! sync" +qall >/dev/null 2>&1 || \
    nvim --headless "+Lazy install catppuccin" +qall >/dev/null 2>&1 || true

    if [ -d "$CAT_DIR" ]; then
      echo "  ✅ Catppuccin installed"
    else
      echo "  ⚠️  Lazy install may need a manual :Lazy sync"
      echo "     Plugin spec is ready at: $LAZY_SPEC_FILE"
    fi
  fi

  echo "🎉 Catppuccin configured"
  echo "   Flavour: frappe  (edit $CAT_CONF_FILE to change)"
  echo "   Available: latte | frappe | macchiato | mocha"
}
