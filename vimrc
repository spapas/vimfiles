set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

" For buffers, hide buffers without asking confirm for save
set hidden

" Careful - for lightline to appear
set laststatus=2

if has('gui_running')
    " set guifont=Fira\ Mono:h11:cGREEK
    " or
    " set guifont=Hack:h11:cGREEK
    " or For Linux
    set guifont=Fira\ Mono\ 11
    set lines=40 columns=120
endif


"Use this to make clipboard work as normal with vim - or else use the *
"register to refer to the windows clipboard, for example
" "*yy
" other registers can be used f.e "add "ayy "ap etc
set clipboard=unnamed

set autoindent
set enc=utf-8
set expandtab

"To expand special characters
"set list

set nowrap
set number
set hlsearch

" Number of spaces to use for each step of (auto)indent. 
set shiftwidth=4

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" http://vimdoc.sourceforge.net/htmldoc/options.html#'foldcolumn'
" play with zM zm zr zR and more http://vimdoc.sourceforge.net/htmldoc/usr_28.html
set foldcolumn=2
set foldmethod=indent
set foldlevel=12

" allow delete over all things
set backspace=indent,eol,start

" this is already set by behave mswin (makes shift + arrows etc work to select)
"set keymodel=startsel,stopsel

" make selecting easier for windows
set selection=exclusive
set virtualedit=onemore
"or
"set selection=inclusive

set nobackup
set writebackup
" Vim keeps a hidden undo file for persistent undos(extension .un~). I don't like this because it adds a lot of files.
" If you think you need it you can add an undodir directory that will save all undo files in a directory
" Also see this answer: https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
set noundofile
"set selectmode=mouse,key
syntax on
" colorscheme desert
" colorscheme solarized
" colorscheme gruvbox
" colorscheme PaperColor
" colorscheme jellybeans
colorscheme onedark
set background=dark


" Delete trailing characters
autocmd BufWritePre,FileWritePre *.py mark x|exe "%s/[ ]*$//g"|'x

" CTRLP
" Checkout this answer https://stackoverflow.com/a/28796041/119071 for
" including submodules
set runtimepath^=~/vimfiles/bundle/ctrlp.vim
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc  " Windows
" Open Buffers list with 'ctrl-j'
noremap <C-j> :CtrlPBuffer<CR>
" Show files by default 
let g:ctrlp_cmd = 'CtrlP'
" Run CtrlP (files) with CTRL+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" Other plugins
" set runtimepath^=~/.vim/bundle/vim-surround
" set runtimepath^=~/.vim/bundle/vim-repeat

" PLUG
call plug#begin('~/vimfiles/plugged')

" lightline-vim
Plug 'itchyny/lightline.vim'

call plug#end()



" Lightline
let g:lightline = {
\ 'colorscheme': 'onedark',
\ 'active': {
\   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype', ]]
\ },
\ 
\ }
" Don't show INSERT (mode) - it is displayed on lightline
set noshowmode

" Use autopep8 for auto - identing
set equalprg=autopep8\ -

" Easier buffer switching (tab to switch to last used buffer)
nmap <tab> :b#<cr>
