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
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      local function start_jdtls()
        local ok_jdtls, jdtls = pcall(require, "jdtls")
        if not ok_jdtls then
          return
        end

        local ok_setup, jdtls_setup = pcall(require, "jdtls.setup")
        if not ok_setup then
          return
        end

        local root_markers = {
          ".git",
          "mvnw",
          "gradlew",
          "pom.xml",
          "build.gradle",
          "build.gradle.kts",
          "settings.gradle",
          "settings.gradle.kts",
        }

        local root_dir = jdtls_setup.find_root(root_markers)
        if not root_dir or root_dir == "" then
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname ~= "" then
            root_dir = vim.fn.fnamemodify(bufname, ":p:h")
          else
            root_dir = vim.loop.cwd()
          end
        end
        if not root_dir or root_dir == "" then
          return
        end

        local project_name = vim.fn.fnamemodify(root_dir, ":t")
        local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name

        local function resolve_cmd()
          if vim.fn.executable("jdtls") == 1 then
            return { "jdtls", "-data", workspace_dir }
          end
          if vim.fn.executable("jdt-language-server") == 1 then
            return { "jdt-language-server", "-data", workspace_dir }
          end
        end

        local cmd = resolve_cmd()
        if not cmd then
          return
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok_cmp then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        end

        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        jdtls.start_or_attach({
          cmd = cmd,
          root_dir = root_dir,
          capabilities = capabilities,
          handlers = {
            ["language/status"] = function() end,
          },
          init_options = {
            extendedClientCapabilities = extendedClientCapabilities,
          },
          settings = {
            java = {
              configuration = {
                updateBuildConfiguration = "automatic",
              },
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              referencesCodeLens = { enabled = true },
              implementationsCodeLens = { enabled = true },
              format = {
                settings = {
                  url = vim.fn.stdpath("config") .. "/java-settings.prefs",
                },
              },
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
              completion = {
                favoriteStaticMembers = {
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                },
                filteredTypes = {
                  "com.sun.*",
                  "io.micrometer.shaded.*",
                  "java.awt.*",
                  "jdk.*",
                  "sun.*",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
          },
        })
      end

      local group = vim.api.nvim_create_augroup("JdtlsAutostart", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "java",
        callback = start_jdtls,
      })

      start_jdtls()
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
          map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
          map("n", "<leader>cL", function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end, "Refresh codelens")
        end,
      })

      local servers = {
        rust_analyzer = {},
        racket_langserver = {},
        tinymist = {},
        texlab = {},
        ts_ls = {
          settings = {
            completions = {
              completeFunctionCalls = true,
            },
            typescript = {
              preferences = {
                importModuleSpecifierPreference = "relative",
              },
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              },
            },
            javascript = {
              preferences = {
                importModuleSpecifierPreference = "relative",
              },
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              },
            },
          },
        },
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
