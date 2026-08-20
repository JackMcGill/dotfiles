vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim",
	"https://github.com/bluz71/vim-moonfly-colors",
	"https://github.com/olimorris/onedarkpro.nvim",
	"https://github.com/folke/tokyonight.nvim",
})

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

-- Activate the theme
vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("kanagawa")

-- Black background
vim.api.nvim_set_hl(0, "Normal", {
	fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg,
	bg = "black",
})
-- Line number column
vim.api.nvim_set_hl(0, "LineNr", {
	fg = "#54546D",
	bg = "black",
})
-- Cursor line
vim.api.nvim_set_hl(0, "CursorLineNr", {
	fg = "#DCD7BA",
	bg = "#161616",
	bold = true,
})
vim.api.nvim_set_hl(0, "CursorLine", {
	bg = "#111111",
})
-- Keep the sign column black too
vim.api.nvim_set_hl(0, "SignColumn", {
	bg = "black",
})

-- =====================================
-- snacks picker colour overrides
-- vim.api.nvim_set_hl(0, "NormalFloat", {
-- 	bg = "black",
-- })
-- vim.api.nvim_set_hl(0, "FloatBorder", {
-- 	fg = "#161616",
-- 	bg = "black",
-- })
-- chad
vim.api.nvim_set_hl(0, "NormalFloat", {
	fg = "#FFFFFF",
	bg = "#161616",
})

vim.api.nvim_set_hl(0, "FloatBorder", {
	fg = "#FFFFFF",
	bg = "#161616",
})

-- diagnostics colour overrides
for _, group in ipairs({
	"DiagnosticVirtualTextError",
	"DiagnosticVirtualTextWarn",
	"DiagnosticVirtualTextInfo",
	"DiagnosticVirtualTextHint",
}) do
	local hl = vim.api.nvim_get_hl(0, {
		name = group,
		link = false,
	})

	vim.api.nvim_set_hl(0, group, {
		fg = hl.fg,
		bg = "black",
	})
end
