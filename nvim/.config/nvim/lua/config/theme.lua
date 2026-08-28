vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/olimorris/onedarkpro.nvim",
	"https://github.com/folke/tokyonight.nvim",
})

-- ====== Disable comments
require("kanagawa").setup({
	commentStyle = { italic = false },
	keywordStyle = { italic = false },
	colors = {
		theme = {
			all = { ui = { bg_gutter = "none" } }, -- remove gutter background
		},
	},
})
require("tokyonight").setup({
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
	},
})

-- actual setup
require("onedarkpro").setup({
	colors = {
		cursorline = "#0F0F0F",
	},
	options = {
		cursorline = true,
	},
})

-- Activate the theme
vim.cmd.colorscheme("onedark_dark")

-- ====== Diagnostics
vim.api.nvim_set_hl(0, "NormalFloat", {
	bg = "#181716",
	fg = "#c0caf5",
})
vim.api.nvim_set_hl(0, "FloatBorder", {
	bg = "#181716",
	fg = "#FFFFFF",
})
