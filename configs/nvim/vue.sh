config_vue() {
  echo "Configuring Vue.js"

  nvim_write_conf vue <<'EOF'
if vim.lsp.config then
  -- vue_ls v3 relies on vtsls + @vue/typescript-plugin for the <script> part
  local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

  vim.lsp.config("vtsls", {
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    },
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_language_server_path,
              languages = { "vue" },
              configNamespace = "typescript",
            },
          },
        },
      },
    },
  })

  vim.lsp.enable({ "vtsls", "vue_ls" })
end

local status, conform = pcall(require, "conform")
if status then
  conform.formatters_by_ft.vue = { "prettierd", "prettier", stop_after_first = true }
end
EOF

  nvim_import_conf vue
  ensure_mason_pkgs vue-language-server css-lsp

  echo "🎉 Vue.js configured"
}
