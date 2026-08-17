-- this file owns plugin installation and the order in which plugin configuration is applied
-- NOTE: theme plugins are installed and located in plugins/theme.lua
-- NOTE: ALL Java stuff is installed, configured and located in plugins/java.lua

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
})

require("plugins.theme")
