-- show existing tab with 2 spaces width
vim.o.tabstop = 2

-- when indenting with '>', use 2 spaces
vim.o.shiftwidth = 2

-- on pressing tab, insert spaces
vim.o.expandtab = true

configure_lsp_servers({"dartls"})

require("neotest").setup({
  adapters = {
    require('neotest-dart') {
      command = 'flutter',
      use_lsp = true,
    }
  }
})
