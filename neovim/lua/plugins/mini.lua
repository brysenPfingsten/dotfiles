return {
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					-- Whole buffer: makes `vag` select entire file
					g = function()
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line("$"),
							col = math.max(vim.fn.getline("$"):len(), 1),
						}
						return { from = from, to = to, vis_mode = "V" } -- linewise
					end,

					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}),
				},
			}
		end,
		config = function(_, opts)
			require("mini.ai").setup(opts)
		end,
	},
	{
		{
			"nvim-mini/mini.pairs",
			opts = function(_, opts)
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "racket", "scheme" },
					callback = function(_)
						vim.keymap.set("i", "'", "'", { buffer = true })
						vim.keymap.set("i", "`", "`", { buffer = true })
					end,
				})
				vim.api.nvim_create_autocmd("FileType", {
					pattern = { "typst" },
					callback = function(_)
						vim.keymap.set("i", "$", "$$<Left>", { buffer = true, noremap = true })
					end,
				})

				return opts
			end,
		},
	},
	{
		"echasnovski/mini.surround",
		version = "*", -- Use latest stable release
		config = function()
			require("mini.surround").setup({
				search_method = "cover_or_next",
				delay = 0,
				highlight_duration = 500,
				mappings = {
					add = "sa",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
				},
				custom_surroundings = {
					["("] = { output = { left = "(", right = ")" } },
					["["] = { output = { left = "[", right = "]" } },
					["{"] = { output = { left = "{", right = "}" } },
					['"'] = { output = { left = '"', right = '"' } },
					["'"] = { output = { left = "'", right = "'" } },
					["`"] = { output = { left = "`", right = "`" } },
					["*"] = { output = { left = "*", right = "*" } },
					["$"] = { output = { left = "$", right = "$" } },
				},
			})
		end,
	},
}
