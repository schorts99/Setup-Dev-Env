DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/nvim/indentation.sh"
source "$DIR/nvim/js.sh"
source "$DIR/nvim/ts.sh"

config_nvim() {
  if ! command -v nvim >/dev/null 2>&1; then
    echo "❌ NeoVim is not installed"
    
    return 1
  fi

  echo "Starting NeoVim configuration..."
  config_indentation

	NVIM_DIR="$HOME/.config/nvim"
	CONF_DIR="$NVIM_DIR/lua/configs/$USER"
	ROOT_INIT="$NVIM_DIR/init.lua"

	mkdir -p "$CONF_DIR"
	touch "$CONF_DIR/init.lua"

	config_js
	config_ts

	LUA_MODULE="configs.$USER"
	IMPORT_CMD="require('$LUA_MODULE')"

	echo "🔗 Linking config to root init.lua"

	if grep -qF "$IMPORT_CMD" "$ROOT_INIT"; then
    echo "  ✅ Root init.lua already imports $LUA_MODULE"
	else
			echo -e "\n$IMPORT_CMD" >> "$ROOT_INIT"
			echo "  ➕ Added $IMPORT_CMD to $ROOT_INIT"
	fi

  echo "✅ NeoVim configured"
}
