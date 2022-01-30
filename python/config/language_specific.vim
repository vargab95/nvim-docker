" set up linters and fixers for the languages I use
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['yapf'],
\}
