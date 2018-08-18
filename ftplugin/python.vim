
let b:ale_linters = ['flake8', ]
let b:ale_fixers = ['black', ]

" let g:ale_python_flake8_change_directory=0
let b:ale_python_flake8_options='--ignore=D203,D100,D101,D105,D106,D102,C0111 --exclude=.git,migrations,__pycache__,docs/source/conf.py --max-line-length=88'

" Python things 
setlocal makeprg=pep8\ %
setlocal colorcolumn=88,120,160
" Run black with space bb
noremap <buffer> <leader>bb :silent !black %<CR>
