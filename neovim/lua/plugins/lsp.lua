return {
	-- JDTLS runtime (needed for Java extras)
	{
		"mfussenegger/nvim-jdtls",
		ft = "java", -- lazy-load on Java files
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			local has_wk, wk = pcall(require, "which-key")
			local has_telescope, telescope_builtin = pcall(require, "telescope.builtin")
			local has_illuminate, illuminate = pcall(require, "illuminate")

			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				signs = false,
				underline = true,
			})

			local function enable_inlay_hints(bufnr)
				local ih = vim.lsp.inlay_hint
				if type(ih) == "table" and ih.enable then
					ih.enable(true, { bufnr = bufnr })
				elseif type(ih) == "function" then
					ih(bufnr, true)
				end
			end
			local function toggle_inlay_hints(bufnr)
				local ih = vim.lsp.inlay_hint
				if type(ih) == "table" and ih.is_enabled then
					ih.enable(not ih.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				elseif type(ih) == "function" then
					-- naive toggle for older API
					ih(bufnr, not (vim.b[bufnr].inlay_hints_enabled or false))
					vim.b[bufnr].inlay_hints_enabled = not (vim.b[bufnr].inlay_hints_enabled or false)
				end
			end

			-- helper: prefer telescope pickers when available
			local function picker_or(buf_fn, picker_fn)
				if has_telescope then
					return picker_fn
				else
					return buf_fn
				end
			end

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

			local function on_attach(client, bufnr)
				local bmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
				end

				enable_inlay_hints(bufnr)
				bmap("n", "<leader>uh", function()
					toggle_inlay_hints(bufnr)
				end, "Toggle Inlay Hints")

				-- ====== LSP core ======
				bmap("n", "gd", picker_or(vim.lsp.buf.definition, telescope_builtin.lsp_definitions), "Goto Definition")
				bmap("n", "gr", picker_or(vim.lsp.buf.references, telescope_builtin.lsp_references), "References")
				bmap(
					"n",
					"gI",
					picker_or(vim.lsp.buf.implementation, telescope_builtin.lsp_implementations),
					"Goto Implementation"
				)
				bmap(
					"n",
					"gy",
					picker_or(vim.lsp.buf.type_definition, telescope_builtin.lsp_type_definitions),
					"Goto T[y]pe Definition"
				)
				bmap("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
				bmap("n", "K", vim.lsp.buf.hover, "Hover")
				bmap("n", "gK", vim.lsp.buf.signature_help, "Signature Help")

				-- Code actions / rename / source
				bmap({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
				bmap({ "n", "x" }, "<leader>cc", function()
					if vim.lsp.codelens then
						vim.lsp.codelens.run()
					end
				end, "Run Codelens")
				bmap("n", "<leader>cC", function()
					if vim.lsp.codelens then
						vim.lsp.codelens.refresh()
						if vim.lsp.codelens.display then
							vim.lsp.codelens.display()
						end
					end
				end, "Refresh & Display Codelens")
				bmap("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
				bmap("n", "<leader>cA", function()
					vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} }, apply = true })
				end, "Source Action")

				-- Rename file
				bmap("n", "<leader>cR", function()
					local old = vim.api.nvim_buf_get_name(0)
					if old == "" then
						vim.notify("Current buffer has no name", vim.log.levels.WARN)
						return
					end
					local new = vim.fn.input("New path: ", old)
					if new == "" or new == old then
						return
					end

					local params =
						{ files = { { oldUri = vim.uri_from_fname(old), newUri = vim.uri_from_fname(new) } } }
					local have_support = false
					for _, c in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
						local w = c.server_capabilities.workspace
						local f = w and w.fileOperations
						if f and f.willRename then
							have_support = true
							c.request("workspace/willRenameFiles", params, function(err, res)
								if not err and res then
									vim.lsp.util.apply_workspace_edit(res, c.offset_encoding or "utf-16")
								end
							end)
						end
					end

					vim.fn.mkdir(vim.fn.fnamemodify(new, ":h"), "p")
					local ok, msg = os.rename(old, new)
					if not ok then
						vim.notify("Rename failed: " .. tostring(msg), vim.log.levels.ERROR)
						return
					end

					local view = vim.fn.winsaveview()
					vim.api.nvim_buf_set_name(0, new)
					vim.cmd("silent keepalt write")
					vim.cmd("silent! bwipeout " .. vim.fn.fnameescape(old))
					vim.fn.winrestview(view)

					if not have_support then
						for _, c in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
							c.notify("workspace/didRenameFiles", params)
						end
					end
					vim.notify("Renamed:\n" .. old .. "\n→ " .. new, vim.log.levels.INFO)
				end, "Rename File")

				local next_ref = function()
					if has_illuminate then
						illuminate.goto_next_reference(true)
					else
						vim.diagnostic.goto_next({ float = false })
					end
				end
				local prev_ref = function()
					if has_illuminate then
						illuminate.goto_prev_reference(true)
					else
						vim.diagnostic.goto_prev({ float = false })
					end
				end
				bmap("n", "]]", next_ref, "Next Reference")
				bmap("n", "[[", prev_ref, "Prev Reference")
				bmap("n", "<A-n>", next_ref, "Next Reference")
				bmap("n", "<A-p>", prev_ref, "Prev Reference")

				-- Symbols / Calls / Info
				bmap(
					"n",
					"<leader>ss",
					picker_or(function()
						vim.lsp.buf.document_symbol()
					end, telescope_builtin.lsp_document_symbols),
					"LSP Symbols"
				)
				bmap(
					"n",
					"<leader>sS",
					picker_or(function()
						vim.lsp.buf.workspace_symbol()
					end, telescope_builtin.lsp_workspace_symbols),
					"LSP Workspace Symbols"
				)
				bmap(
					"n",
					"gai",
					picker_or(vim.lsp.buf.incoming_calls, telescope_builtin.lsp_incoming_calls),
					"C[a]lls Incoming"
				)
				bmap(
					"n",
					"gao",
					picker_or(vim.lsp.buf.outgoing_calls, telescope_builtin.lsp_outgoing_calls),
					"C[a]lls Outgoing"
				)
				bmap("n", "<leader>cl", "<cmd>LspInfo<cr>", "Lsp Info")

				if has_wk then
					wk.add({
						{ "<leader>c", group = "Code" },
						{ "<leader>cl", desc = "Lsp Info", mode = "n" },
						{ "gd", desc = "Goto Definition", mode = "n" },
						{ "gr", desc = "References", mode = "n" },
						{ "gI", desc = "Goto Implementation", mode = "n" },
						{ "gy", desc = "Goto T[y]pe Definition", mode = "n" },
						{ "gD", desc = "Goto Declaration", mode = "n" },
						{ "K", desc = "Hover", mode = "n" },
						{ "gK", desc = "Signature Help", mode = "n" },
						{ "<C-k>", desc = "Signature Help", mode = "i" },
						{ "<leader>ca", desc = "Code Action", mode = { "n", "x" } },
						{ "<leader>cc", desc = "Run Codelens", mode = { "n", "x" } },
						{ "<leader>cC", desc = "Refresh & Display Codelens", mode = "n" },
						{ "<leader>cR", desc = "Rename File", mode = "n" },
						{ "<leader>cr", desc = "Rename", mode = "n" },
						{ "<leader>cA", desc = "Source Action", mode = "n" },
						{ "]]", desc = "Next Reference", mode = "n" },
						{ "[[", desc = "Prev Reference", mode = "n" },
						{ "<A-n>", desc = "Next Reference", mode = "n" },
						{ "<A-p>", desc = "Prev Reference", mode = "n" },
						{ "<leader>ss", desc = "LSP Symbols", mode = "n" },
						{ "<leader>sS", desc = "LSP Workspace Symbols", mode = "n" },
						{ "gai", desc = "C[a]lls Incoming", mode = "n" },
						{ "gao", desc = "C[a]lls Outgoing", mode = "n" },
						{ "<leader>uh", desc = "Toggle Inlay Hints", mode = "n" }, -- +++
					})
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if ok_cmp then
				capabilities = cmp_lsp.default_capabilities(capabilities)
			end

			-- Racket
			lspconfig.racket_langserver.setup({
				cmd = { "racket", "--lib", "racket-langserver" },
				filetypes = { "racket", "scheme" },
				root_dir = racket_root_dir,
				on_attach = on_attach, -- +++ attach so you get keymaps/hints here too
				capabilities = capabilities,
			})

			lspconfig.nixd.setup({
				cmd = { "nixd" },
				settings = { nixd = { formatting = { command = { "alejandra" } } } },
				on_attach = on_attach, -- +++
				capabilities = capabilities,
			})

			-- C/C++
			lspconfig.clangd.setup({
				cmd = { "clangd" },
				on_attach = on_attach, -- +++
				capabilities = capabilities,
			})

			-- Lua
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" },
						},
						telemetry = { enable = false },
					},
				},
			})

			-- Python
			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic", -- or "strict"
							autoImportCompletions = true,
							diagnosticMode = "openFilesOnly",
							inlayHints = {
								variableTypes = true,
								functionReturnTypes = true,
								parameterNames = true,
								parameterTypes = true,
								callArgumentNames = "all",
							},
						},
						-- If you need a specific venv:
						venvPath = ".",
						venv = ".venv",
					},
				},
			})

			-- Ruff LSP
			lspconfig.ruff_lsp.setup({
				on_attach = function(client, bufnr)
					-- Let Ruff do only diagnostics/fixes; not formatting (it doesn’t format anyway)
					on_attach(client, bufnr)
					-- Optional: if you also run ruff CLI with Conform, keep this for diagnostics only.
				end,
				capabilities = capabilities,
				init_options = {
					settings = {
						args = {},
					},
				},
			})

			-- JavaScript / TypeScript
			local tsserver = lspconfig.ts_ls or lspconfig.tsserver
			if tsserver then
				tsserver.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					root_dir = function(fname)
						return util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(fname)
					end,
					single_file_support = true,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				})
			end

      lspconfig.tinymist.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = util.root_pattern("typst.toml", ".git"),
        single_file_support = true,
      })
		end,
	},
}
