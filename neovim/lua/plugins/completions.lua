return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("racket", {
        s("thunk", {
          t("(λ () "),
          i(1, "body"),
          t(")"),
        }),
        s("lambda", {
          t("(λ ("),
          i(1, "args"),
          t(") "),
          i(2, "body"),
          t(")"),
        }),
        s("block", {
          t({ "#|", "" }),
          i(1, ""),
          t({ "", "|#" }),
        }),
        s("func", {
          t("(define ("),
          i(1, "name"),
          i(2, "args)"),
          t({ "  ", ")" }),
        }),
        s("srule", {
          t("(define-syntax-rule ("),
          i(1, "name"),
          t(" "),
          i(2, "args"),
          t({ ")", "  " }),
          i(3, "template"),
          t({ "", ")" }),
        }),
      })

      ls.add_snippets("markdown", {
        s("note", {
          t("> [!NOTE]"),
          i(1, " Note"),
          t({ "", "> " }),
          i(2, "..."),
        }),
      })

      vim.keymap.set({ "i", "s" }, "<M-k>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true, desc = "LuaSnip expand or jump" })

      vim.keymap.set({ "i", "s" }, "<M-j>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true, desc = "LuaSnip jump backward" })

      vim.keymap.set({ "i", "s" }, "<M-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true, desc = "LuaSnip next choice" })

      vim.keymap.set({ "i", "s" }, "<M-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { silent = true, desc = "LuaSnip previous choice" })
    end,
  },

  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "ribru17/blink-cmp-spell",
      "onsails/lspkind.nvim",
    },
    opts = {
      keymap = {
        preset = "none",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      snippets = { preset = "luasnip" },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        per_filetype = {
          markdown = { "lsp", "path", "snippets", "spell", "buffer" },
          text = { "lsp", "path", "snippets", "spell", "buffer" },
          gitcommit = { "lsp", "path", "snippets", "spell", "buffer" },
          norg = { "lsp", "path", "snippets", "spell", "buffer" },
          typst = { "lsp", "path", "snippets", "spell", "buffer" },
          latex = { "lsp", "path", "snippets", "spell", "buffer" },
        },
        providers = {
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            opts = { preselect_correct_word = true },
          },
        },
      },

      completion = {
        ghost_text = { enabled = true },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "rounded",
            direction_priority = {
              menu_north = { "s", "e", "w", "n" },
              menu_south = { "s", "e", "w", "n" },
            },
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
          },
        },

        menu = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind", gap = 1 },
              { "source_name" },
            },
            components = {
              kind_icon = {
                text = function(ctx)
                  local lspkind = require("lspkind")
                  local icon = lspkind.symbolic(ctx.kind, { mode = "symbol" })
                  return (icon or ctx.kind_icon) .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  return "BlinkCmpKind" .. ctx.kind
                end,
              },
              source_name = {
                text = function(ctx)
                  local labels = {
                    LSP = "[LSP]",
                    Snippets = "[Snip]",
                    Buffer = "[Buf]",
                    Path = "[Path]",
                    Spell = "[Spell]",
                  }
                  return labels[ctx.source_name] or ("[" .. ctx.source_name .. "]")
                end,
                highlight = "BlinkCmpLabelDescription",
              },
            },
          },
        },
      },
    },

    config = function(_, opts)
      require("blink.cmp").setup(opts)

      local spell_fts = {
        markdown = true,
        text = true,
        gitcommit = true,
        norg = true,
        typst = true,
        latex = true,
      }

      local aug = vim.api.nvim_create_augroup("BlinkSpellEnable", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        group = aug,
        callback = function()
          if spell_fts[vim.bo.filetype] then
            vim.opt_local.spell = true
            vim.opt_local.wrap = true
            vim.opt_local.spelllang = { "en_us" }
          end
        end,
      })
    end,
  },
}
