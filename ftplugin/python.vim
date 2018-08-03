
let b:ale_linters = ['flake8', ]
let b:ale_fixers = ['black', ]

" Python things 
setlocal makeprg=pep8\ %
set colorcolumn=88,120,160
" Run black with space bb
map <leader>bb :silent !black %<CR>
