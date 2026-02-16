return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },

      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,

      watch_gitdir = { follow_files = true },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",

      update_debounce = 100,
      max_file_length = 40000,

      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },

      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation (respects diff mode)
        map("n", "]h", function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, "Next hunk")

        map("n", "[h", function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, "Prev hunk")

        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")

        map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")

        map("n", "<leader>ghus", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")

        -- stylua: ignore
				map("n", "<leader>ghB", function() gs.blame_line({ full = true }) end, "Blame line (full)")
        map("n", "<leader>ghb", gs.toggle_current_line_blame, "Toggle line blame")
        -- stylua: ignore
        map("n", "<leader>ghd", gs.diffthis, "Diff this (index)")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff this (last commit)")

        map("n", "<leader>ghT", gs.toggle_deleted, "Toggle deleted")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },

  -- {
  -- 	"sindrets/diffview.nvim",
  -- 	cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
  -- 	keys = {
  -- 		{ "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open" },
  -- 		{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
  --
  -- 		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git: repo history" },
  -- 		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git: file history" },
  -- 		{ "<leader>gH", ":DiffviewFileHistory<cr>", mode = "v", desc = "Git: history for selection" },
  -- 	},
  -- 	opts = {
  -- 		enhanced_diff_hl = true,
  -- 		view = {
  -- 			default = { layout = "diff2_horizontal" },
  -- 			file_history = { layout = "diff2_horizontal" },
  -- 		},
  -- 	},
  -- },
}
