NVIM_DIR="$HOME/.config/nvim"
NVIM_CONF_DIR="$NVIM_DIR/lua/configs/$USER"
NVIM_PLUGINS_DIR="$NVIM_DIR/lua/plugins"

# Writes stdin to lua/configs/$USER/<name>.lua
nvim_write_conf() {
  local name="$1"

  mkdir -p "$NVIM_CONF_DIR"
  cat > "$NVIM_CONF_DIR/$name.lua"

  echo "  ✅ Configuration file created"
}

# Writes stdin to lua/plugins/<name>.lua (picked up by `{ import = "plugins" }`)
nvim_write_plugin_spec() {
  local name="$1"

  mkdir -p "$NVIM_PLUGINS_DIR"
  cat > "$NVIM_PLUGINS_DIR/$name.lua"

  echo "  ✅ Plugin spec created"
}

# Appends require('configs.$USER.<name>') to lua/configs/$USER/init.lua
nvim_import_conf() {
  local module="configs.$USER.$1"
  local import="require('$module')"
  local main_init="$NVIM_CONF_DIR/init.lua"

  mkdir -p "$NVIM_CONF_DIR"
  touch "$main_init"

  if grep -qF "$import" "$main_init"; then
    echo "  ✅ init.lua already imports $module"
  else
    echo "$import" >> "$main_init"
    echo "  ➕ Added $import to $main_init"
  fi
}

ensure_pnpm_globals() {
  local installed missing=()

  # `pnpm list -g <pkg>` exits 0 even when the package is missing, so match paths instead
  installed="$(pnpm list -g --depth=0 --parseable 2>/dev/null)"$'\n'

  for pkg in "$@"; do
    [[ "$installed" == *"/node_modules/$pkg"$'\n'* ]] || missing+=("$pkg")
  done

  if [ ${#missing[@]} -eq 0 ]; then
    echo "  ✅ pnpm dependencies already installed"
  else
    pnpm add -g "${missing[@]}"
    echo "  ➕ Installed ${missing[*]}"
  fi
}

ensure_brew_pkgs() {
  local missing=()

  for pkg in "$@"; do
    brew list "$pkg" > /dev/null 2>&1 || missing+=("$pkg")
  done

  if [ ${#missing[@]} -eq 0 ]; then
    echo "  ✅ brew dependencies already installed"
  else
    brew install "${missing[@]}"
    echo "  ➕ Installed ${missing[*]}"
  fi
}

# MasonInstall blocks until done when nvim runs headless
ensure_mason_pkgs() {
  local data_dir missing=()

  data_dir="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"

  for pkg in "$@"; do
    [ -d "$data_dir/mason/packages/$pkg" ] || missing+=("$pkg")
  done

  if [ ${#missing[@]} -eq 0 ]; then
    echo "  ✅ Mason packages already installed"
  else
    echo "  📦 Installing Mason packages: ${missing[*]}"

    if nvim --headless "+MasonInstall ${missing[*]}" +qall > /dev/null 2>&1; then
      echo "  ✅ Mason packages installed"
    else
      echo "  ⚠️  Mason install failed, run :MasonInstall ${missing[*]} manually"
    fi
  fi
}
