DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/nvim/helpers.sh"
source "$DIR/nvim/indentation.sh"
source "$DIR/nvim/file_explorer.sh"
source "$DIR/nvim/treesitter.sh"
source "$DIR/nvim/js.sh"
source "$DIR/nvim/ts.sh"
source "$DIR/nvim/shell.sh"
source "$DIR/nvim/node.sh"
source "$DIR/nvim/nest.sh"
source "$DIR/nvim/vue.sh"
source "$DIR/nvim/svelte.sh"
source "$DIR/nvim/markdown.sh"
source "$DIR/nvim/react.sh"
source "$DIR/nvim/catppuccin.sh"

config_nvim() {
  if ! command -v nvim >/dev/null 2>&1; then
    echo "❌ NeoVim is not installed"

    return 1
  fi

  echo "Starting NeoVim configuration..."
  config_indentation

  local ROOT_INIT="$NVIM_DIR/init.lua"

  mkdir -p "$NVIM_CONF_DIR"
  touch "$NVIM_CONF_DIR/init.lua"

  config_file_explorer
  config_js
  config_ts
  config_shell
  config_node
  config_nest
  config_vue
  config_svelte
  config_markdown
  config_react
  config_catppuccin

  # Installs new plugin specs (autotag, markdown-preview, ...) before treesitter needs them
  echo "📦 Syncing plugins"
  nvim --headless "+Lazy! install" +qall > /dev/null 2>&1 || true

  config_treesitter

  local LUA_MODULE="configs.$USER"
  local IMPORT_CMD="require('$LUA_MODULE')"

  echo "🔗 Linking config to root init.lua"

  if grep -qF "$IMPORT_CMD" "$ROOT_INIT"; then
    echo " ✅ Root init.lua already imports $LUA_MODULE"
  else
    echo -e "\n$IMPORT_CMD" >> "$ROOT_INIT"
    echo " ➕ Added $IMPORT_CMD to $ROOT_INIT"
  fi

  echo "✅ NeoVim configured"
}
