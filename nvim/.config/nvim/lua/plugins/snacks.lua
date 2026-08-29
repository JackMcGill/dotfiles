vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons" }, -- icons for the picker
	{ src = "https://github.com/folke/snacks.nvim" },
})

require("mini.icons").setup()
require("snacks").setup({
	explorer = {
		enabled = true,
		replace_netrw = false,
	},
	picker = {
		enabled = true,
		sources = {
			explorer = {
				git_status = true,
			},
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
