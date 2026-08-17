-- this centers the cursor after jumping up or down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

-- netrw
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })
