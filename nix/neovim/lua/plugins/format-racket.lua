return {
	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
				racket = { "raco_fmt" },
				nix = { "alejandra" },
				c = { "clang-format" },
				cpp = { "clang-format" },
			})

			opts.formatters = vim.tbl_deep_extend("force", opts.formatters or {}, {
				raco_fmt = {
					command = "raco",
					args = { "fmt" },
					stdin = true,
				},
				-- If you ever need to tweak clang-format, uncomment:
				-- ["clang-format"] = {
				--   command = "clang-format",
				--   -- args = { "--fallback-style=LLVM" },
				--   stdin = true,
				-- },
			})

			-- optional: format on save (LazyVim often sets this already)
			-- opts.format_on_save = { lsp_fallback = true, timeout_ms = 2000 }
			opts.format_on_save = false

			return opts
		end,
	},
}
