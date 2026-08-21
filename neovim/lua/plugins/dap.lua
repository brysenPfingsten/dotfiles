return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      local codelldb_path = vim.fn.exepath("codelldb")
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      -- Open TUI programs in a new kitty window so they don't fight nvim for the terminal
      dap.defaults.fallback.external_terminal = {
        command = "kitty",
        args = { "-e" },
      }

      local function resolve_binary()
        local metadata = vim.fn.system("cargo metadata --no-deps --format-version 1 2>/dev/null")
        local ok, data = pcall(vim.json.decode, metadata)
        if ok and data and data.packages and data.packages[1] then
          local pkg = data.packages[1]
          local target_dir = data.target_directory
          for _, target in ipairs(pkg.targets) do
            for _, kind in ipairs(target.kind) do
              if kind == "bin" then
                return target_dir .. "/debug/" .. target.name
              end
            end
          end
        end
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end

      dap.configurations.rust = {
        {
          name = "Launch",
          type = "codelldb",
          request = "launch",
          program = resolve_binary,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Launch (TUI — external terminal)",
          type = "codelldb",
          request = "launch",
          program = resolve_binary,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
          terminal = "external",
        },
      }

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.4 },
              { id = "breakpoints", size = 0.2 },
              { id = "stacks", size = 0.2 },
              { id = "watches", size = 0.2 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 12,
          },
        },
      })

      require("nvim-dap-virtual-text").setup({ commented = true })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Conditional breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      map("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
      map("n", "<leader>do", dap.step_over, { desc = "DAP: Step over" })
      map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step out" })
      map("n", "<leader>dr", dap.run_to_cursor, { desc = "DAP: Run to cursor" })
      map("n", "<leader>dR", dap.restart, { desc = "DAP: Restart" })
      map("n", "<leader>dq", dap.terminate, { desc = "DAP: Terminate" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
      map({ "n", "v" }, "<leader>de", function()
        dapui.eval(nil, { enter = true })
      end, { desc = "DAP: Evaluate expression" })
    end,
  },
}
