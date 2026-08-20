vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	picker = {
		enabled = true,
		layout = {
			backdrop = false,
		},
		source = {
			files = {
				hidden = true,
			},
		},
	},
	indent = {
		enabled = true,
	},
})

vim.api.nvim_set_hl(0, "SnacksPicker", {
	bg = "black",
})
vim.api.nvim_set_hl(0, "SnacksPickerBorder", {
	fg = "#FFFFFF",
	bg = "black",
})
