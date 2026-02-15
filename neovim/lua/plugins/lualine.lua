return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus

			if vim.fn.argc(-1) > 0 then
				vim.o.statusline = " "
			else
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			vim.o.laststatus = vim.g.lualine_laststatus

			local icons = {
				diagnostics = { Error = " ", Warn = " ", Info = " ", Hint = " " },
				git = { added = " ", modified = " ", removed = " " },
			}

			local function is_loaded(name)
				return package.loaded[name] ~= nil
			end

			local function project_root()
				local buf = vim.api.nvim_get_current_buf()
				local fname = vim.api.nvim_buf_get_name(buf)
				if fname == "" then
					return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
				end

				-- 1) LSP root
				local clients = vim.lsp.get_clients({ bufnr = buf })
				for _, c in ipairs(clients) do
					local ws = c.config and c.config.workspace_folders
					if ws and ws[1] and ws[1].name then
						return vim.fn.fnamemodify(ws[1].name, ":t")
					end
				end

				-- 2) git root
				local dir = vim.fn.fnamemodify(fname, ":p:h")
				local git = vim.fn.finddir(".git", dir .. ";")
				if git ~= "" then
					local root = vim.fn.fnamemodify(git, ":h")
					return vim.fn.fnamemodify(root, ":t")
				end

				-- 3) cwd
				return vim.fn.fnamemodify(vim.loop.cwd(), ":t")
			end

			local function pretty_path()
				local buf = vim.api.nvim_get_current_buf()
				local name = vim.api.nvim_buf_get_name(buf)
				if name == "" then
					return "[No Name]"
				end

				local path = vim.fn.fnamemodify(name, ":~:.")
				if #path > 60 then
					path = vim.fn.pathshorten(path)
				end
				return path
			end

			local function noice_command()
				return require("noice").api.status.command.get()
			end
			local function noice_command_ok()
				return is_loaded("noice") and require("noice").api.status.command.has()
			end

			local function noice_mode()
				return require("noice").api.status.mode.get()
			end
			local function noice_mode_ok()
				return is_loaded("noice") and require("noice").api.status.mode.has()
			end

			local function dap_status()
				return "  " .. require("dap").status()
			end
			local function dap_status_ok()
				return is_loaded("dap") and require("dap").status() ~= ""
			end

			local function lazy_updates()
				return require("lazy.status").updates()
			end
			local function lazy_updates_ok()
				return is_loaded("lazy.status") and require("lazy.status").has_updates()
			end

			return {
				options = {
					theme = "auto",
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = {
						statusline = { "dashboard", "alpha", "ministarter" },
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },

					lualine_c = {
						{
							project_root,
							icon = " ",
						},
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
						{ pretty_path },
					},

					lualine_x = {
						{ noice_command, cond = noice_command_ok },
						{ noice_mode, cond = noice_mode_ok },
						{ dap_status, cond = dap_status_ok },
						{ lazy_updates, cond = lazy_updates_ok },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
					},

					lualine_y = {
						{ "progress", separator = " ", padding = { left = 1, right = 0 } },
						{ "location", padding = { left = 0, right = 1 } },
					},

					lualine_z = {
						function()
							return " " .. os.date("%R")
						end,
					},
				},
				extensions = { "neo-tree", "lazy", "fzf" },
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
			if vim.o.laststatus == 0 then
				vim.o.laststatus = vim.g.lualine_laststatus or 2
			end
		end,
	},
}
