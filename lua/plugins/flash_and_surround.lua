-- Flash that replaces f, F, t, T motion with target label find
-- Disables s and S flash activation
-- Adds the "surround" motion with mini.surround
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_laels = true,
        },
      },
    },
    keys = {
      -- { "s", false },
      -- { "S", false },
    },
  },
  { "nvim-mini/mini.surround", version = false, opts = {} },
}
