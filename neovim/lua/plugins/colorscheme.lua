-- return {
-- 	"navarasu/onedark.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		require("onedark").setup({
-- 			style = "darker",
-- 			transparent = true,
-- 			-- term_colors = true, -- ensures Neovim’s terminal colors match
-- 		})
-- 		require("onedark").load()
-- 	end,
-- }
return {
	"uZer/pywal16.nvim",
	name = "pywal16",
	config = function()
		local pywal16 = require("pywal16")
		pywal16.setup()
		vim.cmd.colorscheme("pywal16")
	end,
}
