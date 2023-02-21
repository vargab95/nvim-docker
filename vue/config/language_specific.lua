-- show existing tab with 2 spaces width
vim.o.tabstop = 2

-- when indenting with '>', use 2 spaces
vim.o.shiftwidth = 2

-- on pressing tab, insert spaces
vim.o.expandtab = true

configure_lsp_servers({"tsserver", "vuels"})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
        -- require("null-ls").builtins.diagnostics.eslint,
    }
})
