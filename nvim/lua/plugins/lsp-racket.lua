return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      racket_langserver = {
        cmd = { "racket", "-l", "racket-langserver" },
        filetypes = { "racket" },
        root_dir = function(fname)
          return require("lspconfig.util").find_git_ancestor(fname)
              or vim.fn.getcwd()
        end,
      },
    },
  },
}
