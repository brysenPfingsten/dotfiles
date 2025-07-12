return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      n = {
        ["<leader>rr"] = {
          function()
            vim.cmd("w") -- Save file

            -- Get file path BEFORE switching to terminal
            local file_path = vim.fn.expand("%:p")

            -- Open terminal with racket
            vim.cmd("split | terminal racket")

            -- After delay, send enter! command to REPL
            vim.defer_fn(function()
              -- Must access correct terminal channel
              local chan = vim.b.terminal_job_id
              if chan then
                vim.fn.chansend(chan, string.format('(enter! (file "%s"))\n', file_path))
              end
            end, 300)
          end,
          desc = "Start Racket REPL and enter current file",
        },
      },
    },
  },
}
