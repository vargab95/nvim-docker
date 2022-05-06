configure_lsp_servers({"tsserver", "vuels"})

require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.diagnostics.eslint,
    }
})
