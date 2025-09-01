return {
  {
    "3rd/image.nvim",
    ft = { "markdown", "vimwiki", "quarto", "rmd", "norg", "typst" }, -- load on these filetypes
    build = false,                 -- avoid LuaRocks unless you really want FFI
    opts = {
      backend = "kitty",           -- WezTerm uses kitty graphics protocol
      processor = "magick_cli",    -- shell out to ImageMagick (most reliable)
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,     -- <— needed for http(s) images
          only_render_image_at_cursor = true,
          only_render_image_at_cursor_mode = "inline",
          floating_windows = false,
          filetypes = { "markdown", "vimwiki", "quarto", "rmd" },
        },
        neorg = { enabled = true, filetypes = { "norg" } },
        typst = { enabled = true, filetypes = { "typst" } },
        html  = { enabled = false },
        css   = { enabled = false },
      },
      max_width = 80,
      max_height = 30,
      max_width_window_percentage = 60,
      max_height_window_percentage = 50,
      scale_factor = 1.0,
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
      editor_only_render_when_focused = false,
      tmux_show_only_in_active_window = false,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "3rd/image.nvim",
    },
  },
}
