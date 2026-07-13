config_vue() {
  echo "Configuring Vue.js"

  local NVIM_DIR="$HOME/.config/nvim"
  local CONF_DIR="$NVIM_DIR/lua/configs/$USER"
  local VUE_CONF_FILE="$CONF_DIR/vue.lua"
  local MAIN_INIT="$CONF_DIR/init.lua"

  mkdir -p "$CONF_DIR"
  touch "$MAIN_INIT"

  cat > "$VUE_CONF_FILE" <<'EOF'
if vim.lsp.config then
  vim.lsp.config("vue_ls", {
    filetypes = { "vue" },
    init_options = {
      vue = {
        hybridMode = true,
      },
    },
  })
  vim.lsp.enable("vue_ls")

  vim.lsp.config("ts_ls", {
    filetypes = { "javascript", "typescript", "vue" },
    init_options = {
      plugins = {
        {
          name = "@vue/language-server",
          location = vim.fn.stdpath("data")
            .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
          languages = { "vue" },
        },
      },
    },
  })
  vim.lsp.enable("ts_ls")
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft.vue = { "prettier" }
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")
if status_tag then
  autotag.setup()
end
EOF

  echo "  ✅ Configuration file created"

  local VUE_MODULE="configs.$USER.vue"
  local VUE_IMPORT="require('$VUE_MODULE')"

  if grep -qF "$VUE_IMPORT" "$MAIN_INIT"; then
    echo "  ✅ init.lua already imports $VUE_MODULE"
  else
    echo -e "$VUE_IMPORT" >> "$MAIN_INIT"
    echo "  ➕ Added $VUE_IMPORT to $MAIN_INIT"
  fi

  local DATA_DIR
  DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"

  local MASON_DIR="$DATA_DIR/mason/packages"
  local packages=""

  [ ! -d "$MASON_DIR/vue-language-server" ] && \
    packages="$packages vue-language-server"

  [ ! -d "$MASON_DIR/typescript-language-server" ] && \
    packages="$packages typescript-language-server"

  [ ! -d "$MASON_DIR/css-lsp" ] && \
    packages="$packages css-lsp"

  if [ -n "$packages" ]; then
    echo "  📦 Installing missing Mason packages..."

    nvim --headless "+MasonInstall$packages" +qall >/dev/null 2>&1 || true

    echo "  ✅ Mason packages installed"
  else
    echo "  ✅ Mason packages already installed"
  fi

  echo "🎉 Vue.js configured"
}
