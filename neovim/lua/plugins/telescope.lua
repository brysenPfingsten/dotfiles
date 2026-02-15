return {
	"nvim-telescope/telescope.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope.builtin")
		local map = vim.keymap.set

		-- Normal Fuzzy Finding
		map("n", "<space>ff", telescope.find_files)

		-- Editing Neovim Config
		map("n", "<space>en", function()
			telescope.find_files({
				cmd = vim.fn.stdpath("config"),
			})
		end)

		-- Grep for words
		vim.keymap.set("n", "<leader>fg", telescope.live_grep, {})
		-- Buffers
		vim.keymap.set("n", "<leader>fb", telescope.buffers, {})
	end,
}
