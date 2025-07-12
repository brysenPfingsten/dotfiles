return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      follow_current_file = { enabled = true }, -- auto-reveal current file
      hijack_netrw_behavior = "open_default",   -- replace netrw with neo-tree
      use_libuv_file_watcher = true,            -- auto-refresh
    },
  },
}
