return {
  "lervag/vimtex",
  ft = { "tex" },
  init = function()
    -- Viewer: choose one you actually use
    -- 'zathura', 'sioyek', 'skim', 'okular', 'general', 'sumatrapdf'
    vim.g.vimtex_view_method = "zathura"  -- macOS: "skim"; Windows: "sumatrapdf"

    vim.g.vimtex_compiler_method = "latexmk"

    vim.g.vimtex_compiler_method = "latexmk"


    vim.g.vimtex_compiler_latexmk = {
      build_dir = "build",
      aux_dir = "build",
      continuous = 1,
      callback = 1,
      executable = "latexmk",
      options = {
        "-xelatex",                  -- or "-xelatex"
        "-shell-escape",            -- needed for minted
        "-interaction=nonstopmode",
        "-synctex=1",
        "-file-line-error",
      },
    }
    -- Let vimtex communicate with nvim via neovim-remote (needed for inverse search)
    vim.g.vimtex_compiler_progname = "nvr"

    -- Nice-to-haves
    vim.g.vimtex_quickfix_mode = 0        -- don't auto-open quickfix on warnings
    vim.g.tex_flavor = "latex"
  end,
}
