config_svelte() {
  echo "Configuring Svelte"

  local NVIM_DIR="$HOME/.config/nvim"
  local CONF_DIR="$NVIM_DIR/lua/configs/$USER"
  local SVELTE_CONF_FILE="$CONF_DIR/svelte.lua"
  local MAIN_INIT="$CONF_DIR/init.lua"

  mkdir -p "$CONF_DIR"
  touch "$MAIN_INIT"

  cat > "$SVELTE_CONF_FILE" <<'EOF'
if vim.lsp.config then
  vim.lsp.config("svelte", {
    filetypes = { "svelte" },
  })
  vim.lsp.enable("svelte")
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft.svelte = { "prettier" }
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")
if status_tag then
  autotag.setup()
end
EOF

  echo "  ✅ Configuration file created"

  local SVELTE_MODULE="configs.$USER.svelte"
  local SVELTE_IMPORT="require('$SVELTE_MODULE')"

  if grep -qF "$SVELTE_IMPORT" "$MAIN_INIT"; then
    echo "  ✅ init.lua already imports $SVELTE_MODULE"
  else
    echo -e "$SVELTE_IMPORT" >> "$MAIN_INIT"
    echo "  ➕ Added $SVELTE_IMPORT to $MAIN_INIT"
  fi

  local DATA_DIR
  DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"

  local MASON_DIR="$DATA_DIR/mason/packages"

  if [ ! -d "$MASON_DIR/svelte-language-server" ]; then
    echo "  📦 Installing Svelte language server..."

    nvim --headless "+MasonInstall svelte-language-server" +qall >/dev/null 2>&1 || true

    echo "  ✅ Svelte language server installed"
  else
    echo "  ✅ Svelte language server already installed"
  fi

  echo "🎉 Svelte configured"
}
