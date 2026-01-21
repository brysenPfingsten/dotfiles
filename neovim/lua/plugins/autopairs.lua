return {
  {
    "nvim-mini/mini.pairs",
    opts = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "racket", "scheme" },
        callback = function(ev)
          vim.keymap.set("i", "'", "'", { buffer = true })
          vim.keymap.set("i", "`", "`", { buffer = true })
        end,
      })

      return opts
    end,
  },
}
