vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
})

require("mason").setup()

-- Add mason binaries to Neovims PATH
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
