return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          -- by default uses pytest if available
          dap = { justMyCode = false },
          args = { "-q" }, -- add default pytest args
          runner = "pytest",
        }),
      },
      -- optional visuals
      summary = { animated = false },
    })

    local nt = require("neotest")
    -- Keymaps
    vim.keymap.set("n", "<leader>tn", function()
      nt.run.run()
    end, { desc = "Test: nearest" })
    vim.keymap.set("n", "<leader>tf", function()
      nt.run.run(vim.fn.expand("%"))
    end, { desc = "Test: file" })
    vim.keymap.set("n", "<leader>ts", function()
      nt.run.stop()
    end, { desc = "Test: stop" })
    vim.keymap.set("n", "<leader>to", function()
      nt.output.open({ enter = true, auto_close = true })
    end, { desc = "Test: output" })
    vim.keymap.set("n", "<leader>tS", function()
      nt.summary.toggle()
    end, { desc = "Test: summary" })
    vim.keymap.set("n", "<leader>ta", function()
      nt.run.run({ suite = true })
    end, { desc = "Test: all" })
  end,
}
