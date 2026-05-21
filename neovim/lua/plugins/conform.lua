return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    vim.g.format_on_save = false

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "alejandra" },
        typst = { "typstyle", "tinymist" },
        rust = { "rustfmt" },
        java = { "google-java-format" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        if vim.g.format_on_save then
          require("conform").format({ bufnr = args.buf })
        end
      end,
    })

    vim.keymap.set("n", "<leader>tf", function()
      vim.g.format_on_save = not vim.g.format_on_save
      vim.notify("Format on save: " .. (vim.g.format_on_save and "enabled" or "disabled"))
    end, { desc = "Toggle format on save" })
  end,
}
