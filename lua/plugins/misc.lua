---@diagnostic disable: unused-local
return {
  { "ThePrimeagen/vim-be-good" },
  {
    "karb94/neoscroll.nvim",
    opts = {
      ignored_filetypes = {
        "alpha",
        "dashboard",
        "snacks_dashboard",
        "lazy",
      },
      -- performance_mode = true,
      hide_cursor = true,
      duration_multiplier = 0.2,
      post_hook = function()
        vim.cmd("normal! zz")
      end,
    },
  }, -- DOWNLOAD nvim-cmp FROM LAZYEXTRA FIRST
  {
    "onsails/lspkind.nvim",
  },
  {
    "hrsh7th/nvim-cmp",

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))

        if col == 0 then
          return false
        end

        local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]

        return current_line:sub(col, col):match("%s") == nil
      end

      -- no auto select
      opts.preselect = cmp.PreselectMode.None

      -- don't insert until explicitly selected
      opts.completion = {
        completeopt = "menu,menuone,noselect,noselect",
      }

      opts.view = {
        docs = {
          auto_open = true,
        },
      }

      -- disable ghost text
      opts.experimental = {
        ghost_text = false,
      }

      -- disable completion in comments/prompts
      opts.enabled = function()
        local context = require("cmp.config.context")

        if vim.bo.buftype == "prompt" then
          return false
        end

        if context.in_treesitter_capture("comment") or context.in_syntax_group("Comment") then
          return false
        end

        return true
      end

      -- completion sources
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      })

      -- sorting
      opts.sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.locality,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }

      -- more visible borders
      opts.window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),

        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }),
      }

      -- formatting
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

      -- super tab
      opts.mapping = vim.tbl_extend("force", opts.mapping or {}, {

        -- tab selects next item
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({
              behavior = cmp.SelectBehavior.Insert,
            })
            -- vim.schedule(function()
            --   cmp.confirm({
            --     behavior = cmp.ConfirmBehavior.Replace,
            --     select = true,
            --   })
            -- end)
          elseif vim.snippet.active({ direction = 1 }) then
            vim.snippet.jump(1)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({
              behavior = cmp.SelectBehavior.Select,
            })
          elseif vim.snippet.active({ direction = -1 }) then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- enter confirms only selected item
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
      })
    end,
  },
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   opts = {
  --     override = {
  --       hpp = {
  --         icon = "󰙲", -- choose any icon you like
  --         color = "#A52A2A", -- brown
  --         name = "Hpp",
  --       },
  --     },
  --   },
  -- },
  { -- Mini Icons
    "nvim-mini/mini.icons",
    opts = {
      extension = {
        hpp = {
          glyph = "󰙲",
          hl = "MiniIconsPurple",
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
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
