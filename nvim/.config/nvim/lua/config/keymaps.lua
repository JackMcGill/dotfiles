-- Helper functions
local map = vim.keymap.set
local opts = { noremap = true, silent = true }


-- ═══════════════════════════════════════════════════════════
-- NAVIGATION / SEARCH
-- ═══════════════════════════════════════════════════════════

-- Disable search highlighting
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Open netrw
map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Quick switch to last edited file 
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Center the cursor after jumping up or down
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })


-- ═══════════════════════════════════════════════════════════
-- WINDOW MANAGEMENT 
-- ═══════════════════════════════════════════════════════════

-- Move between windows with Ctrl+hjkl 
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })


-- ═══════════════════════════════════════════════════════════
-- TEXT EDITING
-- ═══════════════════════════════════════════════════════════

-- Auto-close pairs 
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "<", "<><left>")

-- Smart undo break-points (create undo points at logical stops)
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
