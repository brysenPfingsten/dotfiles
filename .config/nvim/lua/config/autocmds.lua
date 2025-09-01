-- Turn on wrap and spell in markdown and latex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Never run Treesitter in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(ev)
    pcall(vim.treesitter.stop, ev.buf)
    -- Optional: keep terminals simple
    vim.bo[ev.buf].spell = false
    vim.wo[ev.buf].conceallevel = 0
  end,
})
