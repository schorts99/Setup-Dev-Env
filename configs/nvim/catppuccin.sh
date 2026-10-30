config_catppuccin() {
  echo "Configuring Catppuccin"

  # NvChad themes come from base46, which ships catppuccin; loading the
  # catppuccin plugin's colorscheme on top of it wipes base46 groups like IblChar
  local THEME="catppuccin"
  local CHADRC="$NVIM_DIR/lua/chadrc.lua"

  if [ ! -f "$CHADRC" ]; then
    echo "  ⚠️  $CHADRC not found, set M.base46.theme = \"$THEME\" manually"
  elif grep -qE "^[[:space:]]*theme[[:space:]]*=[[:space:]]*\"$THEME\"" "$CHADRC"; then
    echo "  ✅ base46 theme already set to $THEME"
  elif grep -qE '^[[:space:]]*theme[[:space:]]*=' "$CHADRC"; then
    perl -i.bak -pe "s|^(\s*theme\s*=\s*)\"[^\"]*\"|\1\"$THEME\"|" "$CHADRC"
    rm -f "$CHADRC.bak"
    echo "  ✅ base46 theme set to $THEME"
  else
    echo "  ⚠️  No theme entry in $CHADRC, set M.base46.theme = \"$THEME\" manually"
  fi

  # Remove the catppuccin plugin setup written by earlier versions of this script
  local CAT_IMPORT="require('configs.$USER.catppuccin')"
  local MAIN_INIT="$NVIM_CONF_DIR/init.lua"

  if [ -f "$MAIN_INIT" ] && grep -qF "$CAT_IMPORT" "$MAIN_INIT"; then
    grep -vF "$CAT_IMPORT" "$MAIN_INIT" > "$MAIN_INIT.tmp" && mv "$MAIN_INIT.tmp" "$MAIN_INIT"
    echo "  ➖ Removed $CAT_IMPORT"
  fi

  for old in "$NVIM_CONF_DIR/catppuccin.lua" "$NVIM_PLUGINS_DIR/catppuccin.lua"; do
    if [ -f "$old" ]; then
      rm -f "$old"
      echo "  ➖ Removed $old"
    fi
  done

  echo "🎉 Catppuccin configured"
  echo "   Theme: $THEME  (change M.base46.theme in $CHADRC or pick one with <leader>th)"
}
