---@diagnostic disable: unused-local
return {
  { "ThePrimeagen/vim-be-good" },
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  -- DOWNLOAD nvim-cmp FROM LAZYEXTRA FIRST
  {
    "hrsh7th/nvim-cmp",
    --@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- disable inline completion
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = false
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      -- completeopt
      opts.completion = vim.tbl_extend("force", opts.completion or {}, {
        completeopt = "menu,menuone,noinsert",
      })
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        preselect = cmp.PreselectMode.None,
        experimental = {
          ghost_text = false,
        },
        enabled = function()
          local context = require("cmp.config.context")

          -- disable completion in comments
          if vim.bo.buftype == "prompt" then
            return false
          end
          if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
            return false
          end

          return true
        end,
        sources = {
          { name = "nvim_lsp" }, -- important for macros
          { name = "buffer" },
          { name = "path" },
        },
      })

      -- sorting
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }

      -- window styling
      opts.window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      }

      -- formatting (simple labels; swap in lspkind if you use it)
      local lspkind = require("lspkind")

      opts.formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            buffer = "[Buf]",
            path = "[Path]",
          },
        }),
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = require("cmp").SelectBehavior.Select })
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete({ select = false })
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          separator_style = "slant",
          close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
          middle_mouse_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
        },
        highlights = {
          buffer_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },
          diagnostic_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },

          error_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },
          warning_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },

          info_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },

          hint_selected = {
            bold = true,
            fg = "#fab387",
            italic = false,
          },
        },
      })
    end,
  },
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  {
    "folke/drop.nvim",
    opts = {
      interval = 100, -- every 150ms we update the drops
      screensaver = 1000 * 3 * 60, -- show after 5 minutes. Set to false, to disable},
      theme = "binary",
    },
  },
  { "eandrju/cellular-automaton.nvim" },
}
