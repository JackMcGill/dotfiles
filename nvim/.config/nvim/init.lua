-- this gets done first conventionally. apparently some plugins need it. ¯\_(ツ)_/¯
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config") -- Load all config first

require("plugins") -- Load all plugins
