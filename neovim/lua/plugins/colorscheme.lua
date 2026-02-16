return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  float = {
    transparent = false,
    solid = false,
  },
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    -- miscs = {}, -- Uncomment to turn off hard-coded styles
  },
  lsp_styles = {
    virtual_text = {
      errors = { "bold" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = true,
    },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  auto_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    toggleterm = true,
    neotree = true,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },

  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}
