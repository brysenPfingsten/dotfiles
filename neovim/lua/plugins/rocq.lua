return {
  -- Coqtail provides ftdetect, syntax, and basic ftplugin for Coq files
  {
    "whonore/Coqtail",
    ft = { "coq" },
    init = function()
      -- Disable Coqtail's built-in mappings since we'll use LSP
      vim.g.coqtail_nomap = 1
    end,
  },
  -- coq-lsp.nvim is the official Neovim client for coq-lsp
  {
    "tomtomjhj/coq-lsp.nvim",
    ft = { "coq" },
    dependencies = {
      "whonore/Coqtail",
    },
    opts = {},
  },
}
