return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        -- override <leader>fg to use live_grep instead of git_files
        ["<leader>fg"] = {
          function()
            require("telescope.builtin").live_grep()
          end,
          desc = "Live Grep (Search inside files)",
        },
      },
    },
  },
}
