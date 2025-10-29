return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    dev = false,
    config = function()
      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")

      -- Load snippets from vscode-style and your own folder
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })
      require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/snippets" })

      -- Snippet navigation
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end
      end, { silent = true, desc = "Expand or jump in snippet" })

      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then luasnip.jump(-1) end
      end, { silent = true, desc = "Jump backwards in snippet" })

      -- Choice nodes (cycle with Ctrl-l)
      vim.keymap.set("i", "<C-l>", function()
        if luasnip.choice_active() then luasnip.change_choice(1) end
      end, { silent = true, desc = "Cycle snippet choice" })

      -- Global settings
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
        ext_opts = {
          [types.choiceNode] = { active = { virt_text = { { "<-", "Comment" } } } },
        },
      })
    end,
  },
}
