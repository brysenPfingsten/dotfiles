return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function()
		require("nvim-treesitter.config").setup({
			ensure_installed = {
				"c",
				"lua",
				"nix",
				"racket",
				"markdown",
				"java",
				"vimdoc",
				"help",
				"typst",
				"latex",
			},

			auto_install = false,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
					},
				},

				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
			},
		})
	end,
}
