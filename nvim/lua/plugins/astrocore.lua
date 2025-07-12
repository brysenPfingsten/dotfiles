return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        -- Tab switcher
        ["<Tab>"] = {
          function()
            vim.cmd("wincmd w")
          end,
          desc = "Switch to next window",
        },
        ["<S-Tab>"] = {
          function()
            vim.cmd("wincmd W")
          end,
          desc = "Switch to previous window",
        },

        -- Racket formatter
        ["<leader>rf"] = {
          function()
            vim.cmd("w")
            vim.cmd("!raco fmt -i " .. vim.fn.expand("%"))
            vim.cmd("edit!")
          end,
          desc = "Format Racket file with raco fmt",
        },

        -- VimTeX remaps
        ["<leader>ll"] = {
          "<plug>(vimtex-compile)",
          desc = "VimTeX Compile",
        },
        ["<leader>lv"] = {
          "<plug>(vimtex-view)",
          desc = "VimTeX View PDF",
        },
        ["<leader>lk"] = {
          "<plug>(vimtex-stop)",
          desc = "VimTeX Stop compilation",
        },
        ["<leader>lc"] = {
          "<plug>(vimtex-clean)",
          desc = "VimTeX Clean",
        },
      },
    },
  },
}
