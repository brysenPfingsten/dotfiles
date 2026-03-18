return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope.builtin")
    local map = vim.keymap.set

    -- Normal Fuzzy Finding
    map("n", "<space>ff", telescope.find_files)

    -- Editing Neovim Config
    map("n", "<space>en", function()
      telescope.find_files({
        cmd = vim.fn.stdpath("config"),
      })
    end)

    -- Grep for words
    map("n", "<leader>fg", telescope.live_grep, {})
    -- Buffers
    map("n", "<leader>fb", telescope.buffers, {})
    -- Git File History
    map("n", "<leader>fh", telescope.git_bcommits, {})
    -- LSP Symbols
    map("n", "<leader>fs", telescope.lsp_document_symbols, {})
  end,
}
