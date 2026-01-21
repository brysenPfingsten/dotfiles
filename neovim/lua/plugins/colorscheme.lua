-- return {
--   "navarasu/onedark.nvim",
--   priority = 1000,
--   config = function()
--     require("onedark").setup({
--       style = "warmer",
--       transparent = true,
--     })
--     require("onedark").load()
--   end,
-- }
-- return {
-- 	"uZer/pywal16.nvim",
-- 	name = "pywal16",
-- 	config = function()
-- 		local pywal16 = require("pywal16")
-- 		pywal16.setup()
-- 		vim.cmd.colorscheme("pywal16")
-- 	end,
-- }
--
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = true,
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
    keywords = { "italic" },
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    telescope = true,
    which_key = true,
    lsp_trouble = true,
    mason = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
}
