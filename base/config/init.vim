" enter the current millenium
set nocompatible

" try to use GUI colors in terminal
set termguicolors

" don't resize splits automatically
set noequalalways

" set up the colorscheme
colorscheme desert
set background=dark

" enable syntax highlighting
syntax on

" enable indenting
filetype plugin indent on

" show existing tab with 4 spaces width by default
" it can be overwritten by file type specific config
set tabstop=4

" when indenting with '>', use 4 spaces width by default
" it can be overwritten by file type specific config
set shiftwidth=4

" on pressing tab, insert spaces
set expandtab

" disable mouse
set mouse=

" set the proper encoding
set encoding=utf-8

" set relative numbering to help jump
set relativenumber

" set a border to usually set 120 line limit
set colorcolumn=118

" do not generate swap files as locally it causes more
" pain than it resolvs
set noswapfile

" delete whitespaces at the end of the lines automatically
autocmd BufWritePre * %s/\s\+$//e

" search down into subfolders
" provides tab-completion for all file-related tasks
"
" by setting this, :find *main.py and tabs can be used
" to find main.py files in the whole project
set path+=**

" ignore some common folders
set wildignore+=**/node_modules/**
set wildignore+=**/__pycache__/**

" display all matching files when we tab complete
set wildmenu

" set shortcut for ale
nnoremap <C-g> :ALEGoToDefinition<CR>

" set the necessary pathes for vim plugged
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" start plugin list
call plug#begin('~/.vim/plugged')

" for some nicer look
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" to have file analysis and errors
Plug 'dense-analysis/ale'

" for easy commentary
Plug 'tpope/vim-commentary'

" add commonly used config
Plug 'tpope/vim-sensible'

" add FZF for easier navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" end of plugin list
call plug#end()

" do automatic fix on save
let g:ale_fix_on_save = 1

" use auto completeion feature of ale
let g:ale_completion_enabled = 1

" set up a prettier sign
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
hi ALEErrorSign ctermfg=darkred guifg=red
hi ALEWarningSign ctermfg=darkyellow guifg=yellow

" set up the airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'

" make my life harder by disabling arrow keys
noremap <Left> :echo "No left for you!"<CR>
noremap <Right> :echo "No right for you!"<CR>
noremap <Up> :echo "No up for you!"<CR>
noremap <Down> :echo "No down for you!"<CR>

" configure hlsearch background
hi Search ctermbg=DarkGray guibg=darkgray

" set up error style
hi SpellBad cterm=underline ctermfg=red ctermbg=NONE gui=underline guifg=red guibg=NONE
hi SpellCap cterm=underline ctermfg=yellow ctermbg=NONE gui=underline guifg=yellow guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

" add a simple cursor line to easily find the cursor
hi CursorLine cterm=underline
set cursorline

" switch from pink menu
highlight Pmenu ctermbg=gray guibg=gray
highlight PmenuSel ctermbg=green guibg=green

" add command to create tags file
"
" with tags file,
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" tweaks for browsing
"
" by allowing these you can
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" add commands for snippets
" this script autoloads all commands in my skeletons folders
"
" for example, I have a skeleton called py3class to generate
" a python3 class definition into an empty file, so when I
" type ,py3class, it will be generated
let dir = globpath('/home/developer/.config/nvim/skeletons', '*', 0, 1)
for skeleton_path in dir
    let skeleton_name = substitute(skeleton_path, "^.*\/", "", "")
    execute ":nnoremap ,".skeleton_name." :-1read /home/developer/.config/nvim/skeletons/".skeleton_name."<CR>"
endfor

" set esc to usual mode in terminal mode
tmap <Esc> <C-\><C-N>

" command to open file browser
command! Editor execute ":vsp | edit . | vertical resize 30"

" Source language specific config

if filereadable("/home/developer/.config/nvim/language_specific.vim")
    source /home/developer/.config/nvim/language_specific.vim
endif
