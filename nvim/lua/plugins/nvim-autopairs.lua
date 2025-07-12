return {
  "windwp/nvim-autopairs",
  opts = {
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {},
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    npairs.setup(opts)

    -- Remove ' rule for racket filetype by adding a new conditional rule
    npairs.remove_rule("'")

    -- Re-add only for non-Racket filetypes
    npairs.add_rules {
      Rule("'", "'")
        :with_pair(function(_opts)
          return vim.bo.filetype ~= "racket"
        end)
        :with_move(function(_opts)
          return true
        end)
        :with_del(function(_opts)
          return true
        end),
    }
  end,
}
