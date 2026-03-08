return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        css = true,
        css_fn = true,
        mode = "virtualtext",
        virtualtext = "■",
      },
    },
  },
}
