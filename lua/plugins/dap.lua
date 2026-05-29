return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local default_config = require("dapui.config")
      dapui.setup(vim.tbl_deep_extend("force", default_config, {
        mappings = {
          edit = "e",
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "stacks", size = 0.4 },
              { id = "breakpoints", size = 0.3 },
              { id = "watches", size = 0.3 },
            },
            size = 40,
            position = "right",
          },

          {
            elements = {
              { id = "scopes", size = 1.0 },
            },
            size = 45,
            position = "left",
          },

          {
            elements = {
              "repl",
            },
            size = 12,
            position = "bottom",
          },
        },
      }))
      -- Auto open/close dap ui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      dap.adapters.codelldb = {
        type = "executable",
        command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
      -- Use same config for c and rust
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      -- Keymaps
      -- use arrow keys to navigate dap
      dap.listeners.after.event_initialized["arrow_keys"] = function()
        vim.keymap.set("n", "<Up>", dap.continue)
        vim.keymap.set("n", "<Right>", dap.step_into)
        vim.keymap.set("n", "<Down>", dap.step_over)
        vim.keymap.set("n", "<Left>", dap.step_out)
      end

      dap.listeners.before.event_terminated["arrow_keys"] = function()
        vim.keymap.del("n", "<Up>")
        vim.keymap.del("n", "<Down>")
        vim.keymap.del("n", "<Left>")
        vim.keymap.del("n", "<Right>")
      end

      vim.keymap.set("n", "<F5>", dap.continue)
      vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<Leader>du", dapui.toggle)

      -- appearance
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#BEF527" })
      vim.fn.sign_define("DapBreakpoint", {
        text = "",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointLine",
        numhl = "DapBreakpoint",
      })
    end,
  },
}
