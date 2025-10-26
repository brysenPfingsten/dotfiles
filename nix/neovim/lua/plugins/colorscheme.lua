return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "darker",
			transparent = true,
			-- term_colors = true, -- ensures Neovim’s terminal colors match
		})
		require("onedark").load()
	end,
}
