return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = { notification = { window = { winblend = 0 } } } },
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- keymaps on attach
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, fn, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]oc [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]S Symbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/documentHighlight') then
          local g = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf, group = g, callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf, group = g, callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(ev)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = g, buffer = ev.buf }
            end,
          })
        end

        if client and client:supports_method('textDocument/inlayHint') then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- capabilities
    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- servers
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')

    local servers = {
      -- Racket: installed via raco (not Mason)
      racket_langserver = {
        cmd = { 'racket', '--lib', 'racket-langserver' },
        filetypes = { 'racket' },
        root_dir = function(fname)
          return util.find_git_ancestor(fname) or util.root_pattern('info.rkt')(fname) or vim.loop.cwd()
        end,
      },

      ts_ls = {},
      ruff = {},
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              mccabe = { enabled = false },
              pylsp_mypy = { enabled = false },
              pylsp_black = { enabled = false },
              pylsp_isort = { enabled = false },
            },
          },
        },
      },
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      cssls = {},
      tailwindcss = {},
      dockerls = {},
      sqlls = {},
      terraformls = {},
      jsonls = {},
      yamlls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file('', true) },
            diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } },
            format = { enable = false },
          },
        },
      },
    }

    -- Mason ensure_installed (only tools Mason actually knows)
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = { -- lspconfig names that Mason *does* provide
        'ts_ls', 'pylsp', 'html', 'cssls', 'tailwindcss', 'dockerls', 'sqlls',
        'terraformls', 'jsonls', 'yamlls', 'lua_ls', "clangd",
      },
      automatic_installation = true,
    }
    require('mason-tool-installer').setup {
      ensure_installed = { 'stylua' }, -- tools by Mason package name
    }

    -- finally set up each server
    for name, cfg in pairs(servers) do
      cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
      lspconfig[name].setup(cfg)
    end
  end,
}

