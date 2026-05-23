return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    config = function(_, opts)
      require("otter").setup(opts)

      vim.api.nvim_create_user_command("Otter", function()
        require("otter").activate()
      end, {
        desc = "Activate otter.nvim for embedded code chunks",
      })

      -- vim.keymap.set("n", "<leader>co", function()
      --   require("otter").activate()
      -- end, {
      --   desc = "Activate Otter",
      -- })
    end,
  },
}
