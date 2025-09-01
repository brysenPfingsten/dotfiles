return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    -- Custom none-ls source for `raco fmt`
    local raco_fmt = {
      name = "raco_fmt",
      method = null_ls.methods.FORMATTING,
      filetypes = { "racket" },
      generator = null_ls.formatter({
        command = "raco",
        args = { "fmt", "--stdin", "--width", "100" },
        to_stdin = true,
      }),
    }

    null_ls.setup({
      sources = {
        raco_fmt,
        stylua,
        -- add other formatters here if you want
      },

      -- create the augroup ONCE, reuse its id
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = false })
          vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 3000 })
            end,
          })
        end
      end,
    })
  end,
}
