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
