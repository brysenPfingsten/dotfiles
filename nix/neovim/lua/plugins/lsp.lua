return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" }, -- make sure setup runs on files
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			local function as_path(x)
				return (type(x) == "number") and vim.api.nvim_buf_get_name(x) or x
			end
			local function racket_root_dir(x)
				local p = as_path(x)
				if not p or p == "" then
					return vim.loop.cwd()
				end
				return util.find_git_ancestor(p) or util.root_pattern("info.rkt")(p) or vim.loop.cwd()
			end

			lspconfig.racket_langserver.setup({
				cmd = { "racket-langserver" }, -- or { "racket", "--lib", "racket-langserver" }
				filetypes = { "racket", "scheme" },
				root_dir = racket_root_dir,
			})

			-- Nix
			lspconfig.nixd.setup({
				cmd = { "nixd" },
				settings = { nixd = { formatting = { command = { "alejandra" } } } },
			})

			-- C/C++
			lspconfig.clangd.setup({
				cmd = { "clangd" },
			})
		end,
	},
}
