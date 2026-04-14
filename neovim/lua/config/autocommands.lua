--region Region Folding
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "//region,//endregion"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "racket",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = ";;region,;;endregion"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.foldmethod = "marker"
    vim.opt_local.foldmarker = "--region,--endregion"
  end,
})
--endregion

--region Typst Compilation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function()
    vim.keymap.set("n", "<leader>rr", "<cmd>TypstWatch<CR>", {
      buffer = true,
      desc = "Typst Watch",
    })
  end,
})
--endregion
