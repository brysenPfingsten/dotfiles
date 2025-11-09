return {
	-- rustaceanvim is pulled in by the Rust extra; we just configure it.
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		dev = true,
		init = function()
			-- Global config consumed by rustaceanvim
			vim.g.rustaceanvim = {
				-- LSP config passed to rust-analyzer
				server = {
					on_attach = function(client, bufnr)
						-- inline hints on attach (Neovim 0.10+)
						if client.server_capabilities.inlayHintProvider then
							local ih = vim.lsp.inlay_hint
							if type(ih) == "table" and ih.enable then
								ih.enable(true, { bufnr = bufnr })
							elseif type(ih) == "function" then
								ih(bufnr, true)
							end
						end
						-- handy toggle
						vim.keymap.set("n", "<leader>uh", function()
							local ih = vim.lsp.inlay_hint
							local b = bufnr
							if type(ih) == "table" and ih.is_enabled then
								ih.enable(not ih.is_enabled({ bufnr = b }), { bufnr = b })
							else
								vim.b[b].inlay_hints_enabled = not vim.b[b].inlay_hints_enabled
								ih(b, vim.b[b].inlay_hints_enabled)
							end
						end, { buffer = bufnr, desc = "Toggle Inlay Hints (Rust)" })
					end,
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = { command = "clippy" },
							inlayHints = {
								typeHints = true,
								parameterHints = true,
								chainingHints = true,
							},
						},
					},
				},
				tools = {
					-- rustaceanvim extras like runnables, debuggables, hover actions
					float_win_config = { border = "rounded" },
				},
			}
		end,
	},
}
