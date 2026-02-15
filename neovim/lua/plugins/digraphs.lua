return {
	"srackham/digraph-picker.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	version = "*",
	config = function()
		local picker = require("digraph-picker")
		picker.setup()
		vim.keymap.set(
			{ "i", "n" },
			"<C-k><C-k>",
			picker.insert_digraph,
			{ noremap = true, silent = true, desc = "Digraph picker" }
		)
	end,
}
