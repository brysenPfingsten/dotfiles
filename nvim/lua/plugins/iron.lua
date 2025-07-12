return {
  "Vigemus/iron.nvim",
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")

    iron.setup {
      config = {
        repl_definition = {
          racket = {
            command = { "racket" },
          },
        },
        repl_open_cmd = view.split.vertical.botright(0.4),
      },
      keymaps = {
        send_line = "<space>sl",
        send_file = "<space>sf",
        exit = "<space>sq",
      },
    }

    -- Keymap: reload current Racket file with `(require "filename.rkt")`
    -- vim.api.nvim_set_keymap(
      -- "n",
      -- "<space>rr",
      -- [[:w<CR>:lua require("iron.core").send(nil, {string.format('(require (file "%s")', vim.fn.expand("%:p"))})<CR>]],
      -- { noremap = true, silent = true }
    -- )

    -- Optional: keymap to start REPL (not in default iron.nvim bindings)
    vim.api.nvim_set_keymap(
      "n",
      "<space>si",
      [[:lua require("iron.core").repl_for("racket")<CR>]],
      { noremap = true, silent = true }
    )
  end,
}

