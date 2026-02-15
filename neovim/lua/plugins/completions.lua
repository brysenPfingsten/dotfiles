return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      "f3fora/cmp-spell",
    },
    config = function()
      local ok_cmp, cmp = pcall(require, "cmp")
      if not ok_cmp then
        return
      end

      local ok_snip, luasnip = pcall(require, "luasnip")
      if not ok_snip then
        return
      end

      vim.o.completeopt = "menu,menuone,noselect"

      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end)

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })

      local spell_fts = {
        markdown = true,
        text = true,
        gitcommit = true,
        norg = true,
        typst = true,
        latex = true,
      }

      local aug = vim.api.nvim_create_augroup("CmpSpellEnable", { clear = true })

      local function enable_spell_if_needed()
        if spell_fts[vim.bo.filetype] then
          vim.opt_local.spell = true
          vim.opt_local.spelllang = { "en_us" }
        end
      end

      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        group = aug,
        callback = enable_spell_if_needed,
      })

      cmp.setup.filetype({ "markdown", "text", "gitcommit", "norg", "typst", "latex" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          {
            name = "spell",
            keyword_length = 2,
            option = {
              keep_all_entries = true,
              preselect_correct_word = true,
            },
          },
          { name = "buffer" },
        }),
      })
    end,
  },
}
