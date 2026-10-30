config_markdown() {
  echo "Configuring Markdown"

  ensure_brew_pkgs "marksman"
  ensure_pnpm_globals "prettier" "@fsouza/prettierd"

  nvim_write_conf markdown <<"EOF"
if vim.lsp.config then
  vim.lsp.config("marksman", {
    filetypes = { "markdown", "markdown.mdx" },
  })
  vim.lsp.enable("marksman")
end

local status, conform = pcall(require, "conform")
if status then
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  conform.formatters_by_ft.markdown = prettier
  conform.formatters_by_ft["markdown.mdx"] = prettier
end

-- read by markdown-preview.nvim when it loads, so they must be set beforehand
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_browser = ""

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "markdown.mdx" },
  callback = function(args)
    local map = function(lhs, cmd, desc)
      vim.keymap.set("n", lhs, cmd, { buffer = args.buf, desc = desc })
    end

    map("<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", "Markdown: Toggle Preview")
    map("<leader>ms", "<cmd>MarkdownPreview<CR>", "Markdown: Start Preview")
    map("<leader>mq", "<cmd>MarkdownPreviewStop<CR>", "Markdown: Stop Preview")
  end,
})
EOF

  nvim_import_conf markdown

  nvim_write_plugin_spec markdown <<"EOF"
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown", "markdown.mdx" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
  },
}
EOF

  echo "🎉 Markdown configured"
}
