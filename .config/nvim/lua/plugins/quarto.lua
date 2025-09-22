return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "jmbuhr/otter.nvim",     -- optional: better code chunks
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("quarto").setup({
        lspFeatures = {
          languages = { "r", "python", "julia", "bash" }, -- what you actually use
          diagnostics = { enabled = true },
          completion = { enabled = true },
        },
        codeRunner = { enabled = true },
      })
    end
  }
}
