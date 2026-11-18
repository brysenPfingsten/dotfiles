--region Region Folding
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    local comment = vim.bo.commentstring:match("^(.-)%%s")
    if vim.bo.filetype == "cypher" and (not comment or comment == "") then
      comment = "//"
    end

    if comment then
      comment = vim.trim(comment)
    end
    if comment and comment ~= "" and not comment:find(",", 1, true) then
      vim.opt_local.foldmethod = "marker"
      vim.opt_local.foldmarker = comment .. "region," .. comment .. "endregion"
    else
      vim.opt_local.foldmethod = "manual"
    end
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
