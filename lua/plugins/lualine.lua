local function recording_macro()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return " @" .. reg
end

local function get_time()
  return " " .. os.date("%I:%M:%S %p"):gsub("^0", "")
end

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
        },

        sections = {
          lualine_a = { "mode", { recording_macro } },
          lualine_b = { "branch", "diff" },
          lualine_c = { "filename", "diagnostics" },

          lualine_y = { "progress", "location" },
          lualine_z = { { get_time } },
        },
      })
    end,
  },
}
