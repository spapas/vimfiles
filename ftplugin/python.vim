
let b:ale_linters = ['flake8', ]
let b:ale_fixers = ['black', 'isort', ]

" let g:ale_python_flake8_change_directory=0
let b:ale_python_flake8_options='--ignore=D203,D100,D101,D103,D105,D106,D107,D102,D400,D401,D300,C0111,W503 --exclude=.git,migrations,__pycache__,docs/source/conf.py --max-line-length=88'

" Python things 
setlocal makeprg=pep8\ %
setlocal colorcolumn=88,120,160
" Run black with space bb
noremap <buffer> <leader>bb :silent !black %<CR>

ia <buffer> ENC # -*- coding: utf-8 -*-
