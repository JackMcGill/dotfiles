vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
	picker = {
		enabled = true,
		sources = {
			files = {
				hidden = true,
			},
		},
		icons = {
			files = {
				enabled = true,
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
