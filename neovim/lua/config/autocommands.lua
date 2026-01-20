-- Enable VimTeX folding and hook it into Neovim folds
vim.g.vimtex_fold_enabled = 1

vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    -- Use VimTeX fold expression
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "vimtex#fold#level(v:lnum)"
    vim.opt_local.foldtext = "vimtex#fold#text()"

    -- Quality-of-life defaults
    vim.opt_local.foldlevel = 99 -- start with folds open
    vim.opt_local.foldlevelstart = 99 -- keep them open on buffer enter
    vim.opt_local.foldenable = true
  end,
})
