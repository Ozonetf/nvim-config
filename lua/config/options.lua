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
})
vim.filetype.add({
  extension = {
    vert = "glsl",
    frag = "glsl",
    geom = "glsl",
    comp = "glsl",
    tesc = "glsl",
    tese = "glsl",
    glsl = "glsl",
  },
  vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
        undercurl = true,
        sp = "#ff0000",
      })

      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", {
        undercurl = true,
        sp = "#ffaa00",
      })

      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", {
        undercurl = true,
        sp = "#00aaff",
      })

      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", {
        undercurl = true,
        sp = "#00ff99",
      })
    end,
  }),
})
