config_treesitter() {
  echo "Configuring Treesitter"

  # nvim-treesitter (main branch) compiles parsers with the tree-sitter CLI
  ensure_pnpm_globals "tree-sitter-cli"

  local PARSERS=(
    bash css html javascript jsdoc json lua markdown markdown_inline
    svelte tsx typescript vue yaml
  )

  nvim_write_plugin_spec treesitter <<'EOF'
return {
  -- auto close/rename html, jsx, vue and svelte tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
EOF

  local lua_list
  lua_list="$(printf '"%s",' "${PARSERS[@]}")"

  echo "  📦 Installing parsers: ${PARSERS[*]}"

  if nvim --headless "+lua if not require('nvim-treesitter').install({ ${lua_list} }):wait(300000) then os.exit(1) end" +qall > /dev/null 2>&1; then
    echo "  ✅ Parsers installed"
  else
    echo "  ⚠️  Parser install failed, run :TSInstall ${PARSERS[*]} manually"
  fi

  echo "🎉 Treesitter configured"
}
