-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.lsp.inlay_hint.enable(false)
vim.diagnostic.config({
  virtual_text = {
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
  virtual_lines = {
    only_current_line = true,
  },
})
