config_react() {
  echo "Configuring React"

  local NVIM_DIR="$HOME/.config/nvim"
  local CONF_DIR="$NVIM_DIR/lua/configs/$USER"
  local REACT_CONF_FILE="$CONF_DIR/react.lua"
  local MAIN_INIT="$CONF_DIR/init.lua"

  cat > "$REACT_CONF_FILE" <<'EOF'
if vim.lsp.config then
  vim.lsp.config("ts_ls", {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "jsx" },
  })
  vim.lsp.enable("ts_ls")

  vim.lsp.config("eslint", {
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "jsx" },
  })
  vim.lsp.enable("eslint")
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    jsx = { "prettier" },
    tsx = { "prettier" },
  })
end

local status_tag, autotag = pcall(require, "nvim-ts-autotag")
if status_tag then
  autotag.setup()
end
EOF

  echo "  ✅ Configuration file created"

  local REACT_MODULE="configs.$USER.react"
  local REACT_IMPORT="require('$REACT_MODULE')"

  if grep -qF "$REACT_IMPORT" "$MAIN_INIT"; then
    echo "  ✅ init.lua already imports $REACT_MODULE"
  else
    echo -e "$REACT_IMPORT" >> "$MAIN_INIT"
    echo "  ➕ Added $REACT_IMPORT to $MAIN_INIT"
  fi

  local DATA_DIR
  DATA_DIR="$(nvim --headless +'lua io.write(vim.fn.stdpath("data"))' +qall 2>/dev/null)"

  local MASON_DIR="$DATA_DIR/mason/packages"
  local packages=""

  [ ! -d "$MASON_DIR/typescript-language-server" ] && \
    packages="$packages typescript-language-server"

  [ ! -d "$MASON_DIR/eslint-lsp" ] && \
    packages="$packages eslint"

  [ ! -d "$MASON_DIR/prettier" ] && \
    packages="$packages prettier"

  if [ -n "$packages" ]; then
    echo "  📦 Installing missing Mason packages: $packages"

    nvim --headless "+MasonInstall $packages" +qall >/dev/null 2>&1 || true

    echo "  ✅ Mason packages installed"
  else
    echo "  ✅ Mason packages already installed"
  fi

  echo "🎉 React configured"
}
