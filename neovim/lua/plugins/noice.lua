return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- Optional, but I strongly recommend it:
      {
        "rcarriga/nvim-notify",
        opts = {
          -- keep defaults; no need to overthink it
          timeout = 2000,
          render = "minimal",
        },
      },
    },
    opts = {
      -- Recommended by noice for the best UI experience:
      -- (Neovim 0.9+ supports cmdheight=0 well)
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
          help = { pattern = "^:%s*h%s+", icon = "" },
        },
      },

      messages = {
        enabled = true,
        view = "notify", -- uses nvim-notify if installed; otherwise falls back
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },

      popupmenu = {
        enabled = true, -- noice can style the popupmenu; works fine with cmp
        backend = "nui",
      },

      -- LSP UI improvements (hover/signature, message routing)
      lsp = {
        progress = {
          enabled = true,
        },
        hover = {
          enabled = true,
        },
        signature = {
          enabled = true,
        },
        message = {
          enabled = true,
        },
        documentation = {
          -- If you use cmp, noice will nicely format docs
          view = "hover",
        },
      },

      -- Presets are the “easy button”
      presets = {
        bottom_search = true, -- classic / search at bottom
        command_palette = true, -- position cmdline + popupmenu together
        long_message_to_split = true, -- long messages go to a split
        inc_rename = false, -- set true if you use inc-rename plugin
        lsp_doc_border = true, -- adds borders to hover/signature
      },

      -- Kill common message spam
      routes = {
        -- "written" messages after save
        {
          filter = { event = "msg_show", kind = "", find = "%d+L, %d+B" },
          opts = { skip = true },
        },
        -- "search hit BOTTOM" etc
        {
          filter = { event = "msg_show", find = "search hit" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "E486" }, -- Pattern not found
          opts = { skip = true },
        },
      },
    },
    config = function(_, opts)
      -- recommended: allow cmdheight=0 experience
      vim.o.cmdheight = 0

      require("noice").setup(opts)

      -- Optional keymaps (nice to have)
      vim.keymap.set("n", "<leader>nd", function()
        require("noice").cmd("dismiss")
      end, { desc = "Noice dismiss" })

      vim.keymap.set("n", "<leader>nh", function()
        require("noice").cmd("history")
      end, { desc = "Noice history" })

      vim.keymap.set("n", "<leader>nl", function()
        require("noice").cmd("last")
      end, { desc = "Noice last message" })
    end,
  },
}
