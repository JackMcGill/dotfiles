vim.pack.add({
	"https://github.com/rebelot/kanagawa.nvim", -- looks nice but background too grey. maybe figure out how to keep colours but make background black?
	"https://github.com/bluz71/vim-moonfly-colors",
	"https://github.com/olimorris/onedarkpro.nvim",
})


vim.g.moonflyItalics = false -- disable italics

-- activate the scheme
vim.cmd.colorscheme("moonfly")
