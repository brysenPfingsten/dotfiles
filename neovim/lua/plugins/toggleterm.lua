return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "TermSelect", "ToggleTermSetName" },
    keys = (function()
      local function project_root()
        ---@diagnostic disable-next-line: deprecated
        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        for _, c in ipairs(clients) do
          local ws = c.config.workspace_folders
          if ws and ws[1] and ws[1].name then
            return ws[1].name
          end
        end

        local buf = vim.api.nvim_buf_get_name(0)
        local start = (buf ~= "" and vim.fs.dirname(buf)) or vim.uv.cwd()
        local root = vim.fs.root(start, { ".git", "lua", "package.json", "pyproject.toml", "go.mod" })
        return root or start
      end

      local function tt_toggle(direction, size, use_cwd)
        return function()
          local count = vim.v.count1
          local dir = use_cwd and vim.uv.cwd() or project_root()
          require("toggleterm").toggle(count, size, dir, direction)
        end
      end

      local function vsize()
        return math.floor(vim.o.columns * 0.4)
      end

      local lazygit_term ---@type any
      local yazi_term ---@type any

      local function toggle_command_floating(term, command)
        if not term then
          local Terminal = require("toggleterm.terminal").Terminal

          term = Terminal:new({
            cmd = command,
            dir = "git_dir",
            direction = "float",
            hidden = true,

            on_open = function(term)
              vim.keymap.set("t", "<Esc>", function()
                return string.char(27)
              end, { buffer = term.bufnr, expr = true, noremap = true, silent = true })
              vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { buffer = term.bufnr, noremap = true, silent = true })
            end,
          })
        end

        term:toggle()
      end

      local function toggle_lazygit()
        toggle_command_floating(lazygit_term, "lazygit")
      end

      -- local function toggle_yazi()
      --   toggle_command_floating(yazi_term, "yazi")
      -- end

      -- stylua: ignore
			return {
				{ "<leader>tf", tt_toggle("float", 0, false), desc = "ToggleTerm (float project root)" },
				{ "<leader>th", tt_toggle("horizontal", 15, false), desc = "ToggleTerm (horizontal project root)" },
				{ "<leader>tv", tt_toggle("vertical", vsize(), false), desc = "ToggleTerm (vertical project root)" },
				{ "<leader>tn", "<cmd>ToggleTermSetName<cr>", desc = "Set term name" },
				{ "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select term" },
        { "<leader>gg", toggle_lazygit, desc = "Toggle Lazygit" },
			}
    end)(),
    opts = {
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      close_on_exit = true,
      float_opts = {
        border = "rounded",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.85)
        end,
        winblend = 0,
      },

      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
    },
  },
}
