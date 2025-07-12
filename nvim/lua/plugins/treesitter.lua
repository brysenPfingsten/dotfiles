---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "racket",
      "javascript",
      "python",
      "java",
    },
  },
}
