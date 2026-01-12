return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio", -- required by dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      --------------------------------------------------------------------------
      -- Virtual text (inline variable values)
      --------------------------------------------------------------------------
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        clear_on_continue = true,
        commented = true, -- show as comments at end of line
      })

      --------------------------------------------------------------------------
      -- UI (sidebars with scopes / stack / breakpoints / watches)
      --------------------------------------------------------------------------
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      --------------------------------------------------------------------------
      -- C / C++ adapter config using Nix-provided codelldb
      --------------------------------------------------------------------------
      -- Use the codelldb binary from PATH (provided by Nix)
      local codelldb_path = vim.fn.exepath("codelldb")
      if codelldb_path == "" then
        vim.notify("codelldb not found in PATH. Did you add it in home-manager?", vim.log.levels.ERROR)
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch C executable",
          type = "codelldb",
          request = "launch",
          program = function()
            -- ask once per session which binary to run
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- reuse for C++
      dap.configurations.cpp = dap.configurations.c

      --------------------------------------------------------------------------
      -- Keymaps
      --------------------------------------------------------------------------
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- basic stepping
      map("n", "<F5>", dap.continue, vim.tbl_extend("force", opts, { desc = "DAP Continue" }))
      map("n", "<F10>", dap.step_over, vim.tbl_extend("force", opts, { desc = "DAP Step Over" }))
      map("n", "<F11>", dap.step_into, vim.tbl_extend("force", opts, { desc = "DAP Step Into" }))
      map("n", "<F12>", dap.step_out, vim.tbl_extend("force", opts, { desc = "DAP Step Out" }))

      -- breakpoints
      map("n", "<leader>db", dap.toggle_breakpoint, vim.tbl_extend("force", opts, { desc = "DAP Toggle Breakpoint" }))
      map("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, vim.tbl_extend("force", opts, { desc = "DAP Conditional Breakpoint" }))

      map("n", "<leader>dl", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, vim.tbl_extend("force", opts, { desc = "DAP Logpoint" }))

      -- ui / control
      map("n", "<leader>du", dapui.toggle, vim.tbl_extend("force", opts, { desc = "DAP UI Toggle" }))
      map("n", "<leader>dr", dap.restart, vim.tbl_extend("force", opts, { desc = "DAP Restart" }))
      map("n", "<leader>dq", function()
        dap.terminate()
        dapui.close()
      end, vim.tbl_extend("force", opts, { desc = "DAP Terminate" }))

      -- eval under cursor
      map("n", "<leader>de", function()
        require("dap.ui.widgets").hover()
      end, vim.tbl_extend("force", opts, { desc = "DAP Hover" }))
      map("v", "<leader>de", function()
        require("dap.ui.widgets").hover()
      end, vim.tbl_extend("force", opts, { desc = "DAP Hover (Visual)" }))
    end,
  },
}
