return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "warmer",
      transparent = true,
    })
    require("onedark").load()
  end,
}
-- return {
-- 	"uZer/pywal16.nvim",
-- 	name = "pywal16",
-- 	config = function()
-- 		local pywal16 = require("pywal16")
-- 		pywal16.setup()
-- 		vim.cmd.colorscheme("pywal16")
-- 	end,
-- }
