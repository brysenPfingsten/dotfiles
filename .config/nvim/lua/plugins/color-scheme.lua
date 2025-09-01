-- -- Color theme
-- return {
--   "shaunsingh/nord.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
-- 	vim.g.nord_contrast = true
-- 	vim.g.nord_borders = false
-- 	vim.g.nord_disable_background = false
-- 	vim.g.nord_italic = false
-- 	vim.g.nord_uniform_diff_background = true
-- 	vim.g.nord_bold = false
--
-- 	require('nord').set()
--   end
-- }

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- ensures it loads before other plugins
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- or "latte", "frappe", "macchiato"
    })
    vim.cmd.colorscheme("catppuccin") -- load automatically
  end,
}

