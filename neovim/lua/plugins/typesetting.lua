return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = true,
    config = function()
      vim.keymap.set("n", "<leader>rr", "<cmd>TypstWatch<CR>", {
        buffer = true,
        desc = "Typst Watch",
      })
    end,
  },
  {
    "lervag/vimtex",
    ft = { "tex" },
    init = function()
      vim.g.vimtex_view_method = "zathura"

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-lualatex='env FONTCONFIG_FILE=/etc/fonts/fonts.conf FONTCONFIG_PATH=/etc/fonts lualatex %O %S'",
      }
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        continuous = 1,
        callback = 1,
        executable = "latexmk",
        options = {
          "-pdf",
          "-shell-escape",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-file-line-error",
        },
      }
      vim.g.vimtex_compiler_progname = "nvr"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.tex_flavor = "latex"
    end,
  },
}
