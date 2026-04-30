return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker",
      })
      -- require("onedark").load()
    end,
  },
  { "Mofiqul/vscode.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  { "dracula/vim" },
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   config = function()
  --     -- load the colorscheme here
  --     -- require("night-owl").setup()
  --     vim.cmd.colorscheme("night-owl")
  --   end,
  -- },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
