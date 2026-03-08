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
      numhl = true,
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

        -- Hunks
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
        map("n", "<leader>ghus", gs.undo_stage_hunk, "[G]it [H]unk [U]ndo [S]tage")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "[G]it [H]unk [P]review")

        -- Buffers
        map("n", "<leader>gbs", gs.stage_buffer, "[G]it [B]uffer [S]tage")
        map("n", "<leader>gbr", gs.reset_buffer, "[G]it [B]uffer [R]eset")

        -- Diffing
        map("n", "<leader>gbd", gs.diffthis, "[G]it [H]unk [D]iff")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff this (last commit)")

        -- Blaming
        -- stylua: ignore
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "[G]it [H]unk [Blame]")
        map("n", "<leader>glb", gs.toggle_current_line_blame, "[G]it [L]ine [B]lame")
        map("n", "<leader>gb", gs.toggle_current_line_blame, "[G]it [B]lame")

        -- Toggling
        map("n", "<leader>gtd", gs.toggle_deleted, "[G]it [T]oggle [D]eleted")
        map("n", "<leader>gtn", gs.toggle_numhl, "[G]it [T]oggle [N]umber Highlighting")
        map("n", "<leader>gtwd", gs.toggle_word_diff, "[G]it [T]oggle [W]ord [D]iff")

        -- Hunk Text Object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
      end,
    },
  },
}
