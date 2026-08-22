vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

require("snacks").setup({
  picker = {
    enabled = true,
    source = {
      files = {
        hidden = true
      }
    }
  }
})
