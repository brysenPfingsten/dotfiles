return {
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      highlight = true,
      separator = " > ",
      depth_limit = 5,
      lazy_update_context = true,
    },
    init = function()
      vim.g.navic_silence = true
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local navic = require("nvim-navic")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if not client then
            return
          end

          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end

          if client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
          end, "Toggle Inlay Hints")

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gr", vim.lsp.buf.references, "List references")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
          map("n", "<M-K>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostics")
        end,
      })

      local servers = {
        rust_analyzer = {},
        racket_langserver = {},
        tinymist = {},
        lua_ls = {
          settings = {
            Lua = {
              hint = { enable = true },
              diagnostics = { globals = { "vim" } },
              workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            },
          },
        },
        nixd = {
          settings = {
            nixd = {
              nixpkgs = {
                expr = [[
                  let
                    flake = builtins.getFlake "path:/home/pfingsbr/dotfiles/nix";
                  in
                    flake.inputs.nixpkgs.legacyPackages.${builtins.currentSystem}
                ]],
              },
              options = {
                nixos = {
                  expr = [[
                    (builtins.getFlake "path:/home/pfingsbr/dotfiles/nix").nixosConfigurations.nixos.options
                  ]],
                },
                ["home-manager"] = {
                  expr = [[
                    (builtins.getFlake "path:/home/pfingsbr/dotfiles/nix").nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []
                  ]],
                },
              },
            },
          },
        },
      }

      for name, cfg in pairs(servers) do
        cfg.capabilities = capabilities
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end
    end,
  },
}
