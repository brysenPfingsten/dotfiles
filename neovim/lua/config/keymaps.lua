-- For conciseness
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- save file without auto-formatting
map("n", "<leader>wn", "<cmd>noautocmd w <CR>", opts)

-- quit file
map("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
map("n", "x", '"_x', opts)

-- Moving between splits
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Vertical scroll and center
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

-- Resize with arrows
map("n", "<Up>", ":resize -2<CR>", opts)
map("n", "<Down>", ":resize +2<CR>", opts)
map("n", "<Left>", ":vertical resize -2<CR>", opts)
map("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Buffers
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
map("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
map("n", "<leader>v", "<C-w>v", opts) -- split window vertically
map("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
map("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
map("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Tabs
map("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
map("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
map("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
map("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
map("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Keep last yanked when pasting
map("v", "p", '"_dP', opts)

-- Diagnostic keymaps
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save & close current buffer: <leader>c
map("n", "<leader>bc", "<cmd>update | bdelete<CR>", { desc = "Save & close buffer" })

map("n", "<leader>rr", function()
  vim.cmd("w") -- Save file first

  local file_path = vim.fn.expand("%:p")

  -- Open terminal split at the bottom
  vim.cmd("botright split")
  vim.cmd("resize 15")

  -- Start racket with a specific command to ensure clean exit
  vim.cmd("terminal racket")

  -- Set up terminal buffer options for better cleanup
  vim.cmd([[setlocal bufhidden=wipe]]) -- Wipe buffer when hidden
  vim.cmd([[setlocal nobuflisted]]) -- Don't show in buffer list

  vim.defer_fn(function()
    local chan = vim.b.terminal_job_id
    if chan then
      vim.fn.chansend(chan, string.format('(enter! (file "%s"))\n', file_path))
    end
  end, 500)
end, { desc = "Start Racket REPL and enter current file" })

map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
