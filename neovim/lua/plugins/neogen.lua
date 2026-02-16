return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      -- stylua: ignore
      { "<leader>cd", function() require("neogen").generate() end, desc = "Docstring (Neogen)" },
    },
  },
}
