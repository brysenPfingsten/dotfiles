return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  config = function()
    require('oil').setup {
      vim.keymap.set('n', '<leader>o', ':Oil<CR>', { desc = "Open parent directory" } )
  }
  end
}
