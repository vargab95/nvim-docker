require("dependencies")

-- try to use GUI colors in terminal
vim.o.termguicolors = true

-- set up the colorscheme
vim.cmd("colorscheme desert")
vim.o.background = "dark"

-- show existing tab with 4 spaces width by default
-- it can be overwritten by file type specific config
vim.o.tabstop = 4

-- when indenting with '>', use 4 spaces width by default
-- it can be overwritten by file type specific config
vim.o.shiftwidth = 4

-- on pressing tab, insert spaces
vim.o.expandtab = true

-- set relative numbering and simple numbering to help jump
vim.o.relativenumber = true
vim.o.number = true

-- allow to switch buffer without saving
vim.o.hidden = true

-- set a border to usually set 120 line limit
vim.o.colorcolumn = "118"

-- do not generate swap files as locally it causes more
-- pain than it resolvs
vim.o.swapfile = false

-- search down into subfolders
-- provides tab-completion for all file-related tasks
--
-- by setting this, :find *main.py and tabs can be used
-- to find main.py files in the whole project
vim.o.path = vim.o.path .. "**"

-- ignore some common folders
vim.o.wildignore = vim.o.wildignore .. "**/node_modules/**"
vim.o.wildignore = vim.o.wildignore .. "**/__pycache__/**"

-- display all matching files when we tab complete
vim.o.wildmenu = true

-- disable mouse completely
vim.opt.mouse = ""

-- make my life harder by disabling arrow keys
function disable_arrow_keys(mode)
    vim.api.nvim_set_keymap(mode, "<Left>", '<cmd>echo "No left for you!"<CR>', { noremap = true })
    vim.api.nvim_set_keymap(mode, "<Right>", '<cmd>echo "No right for you!"<CR>', { noremap = true })
    vim.api.nvim_set_keymap(mode, "<Up>", '<cmd>echo "No up for you!"<CR>', { noremap = true })
    vim.api.nvim_set_keymap(mode, "<Down>", '<cmd>echo "No down for you!"<CR>', { noremap = true })
end
local disabled_arrow_key_modes = { "n", "i" }
for _, mode in pairs(disabled_arrow_key_modes) do
    disable_arrow_keys(mode)
end

-- configure hlsearch background
vim.cmd("hi Search ctermbg=DarkGray guibg=darkgray")

-- add a simple cursor line to easily find the cursor
vim.o.cursorline = true

-- switch from pink menu
vim.cmd("highlight Pmenu ctermbg=gray guibg=gray")
vim.cmd("highlight PmenuSel ctermbg=green guibg=green")

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Set diagnostic color
vim.cmd("highlight DiagnosticError guifg=LightRed ctermfg=LightRed")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
function configure_lsp_servers(servers)
    for _, lsp in pairs(servers) do
      require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        },
        capabilities = capabilities
      }
    end
end

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}

require('nvim-treesitter.configs').setup {
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- require("language_specific")
pcall(require, "language_specific")
