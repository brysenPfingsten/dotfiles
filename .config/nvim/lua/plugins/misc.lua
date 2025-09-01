return {
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        local npairs = require("nvim-autopairs")
        local Rule   = require("nvim-autopairs.rule")

        npairs.setup({
          -- keep defaults
        })

        -- Remove single quote and backtick pairing in racket files
        npairs.remove_rule("'","racket")
        npairs.remove_rule("`","racket")
      end,
    },
      {
        -- Highlight todo, notes, etc in comments
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
      },
      {
        -- High-performance color highlighter
        'norcalli/nvim-colorizer.lua',
        config = function()
          require('colorizer').setup()
        end,
      },
      {
          "numToStr/Comment.nvim",
          keys = {
            { "<leader>/", mode = { "n", "v" }, desc = "Toggle comment" },
          },
          config = function()
            require("Comment").setup()

            -- Map <leader>/ to toggle comment in both normal and visual mode
            vim.keymap.set("n", "<leader>/", function()
              require("Comment.api").toggle.linewise.current()
            end, { desc = "Toggle comment" })

            vim.keymap.set("v", "<leader>/", function()
              -- toggle for selected lines
              require("Comment.api").toggle.linewise(vim.fn.visualmode())
            end, { desc = "Toggle comment", silent = true })
          end,
        }
}
