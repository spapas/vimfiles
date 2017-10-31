set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

" For buffers, hide buffers without asking confirm for save
set hidden

" Careful - for lightline to appear
set laststatus=2

set guifont=Hack:h12:cDEFAULT

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
"set selectmode=mouse,key
syntax on
colorscheme desert

" Delete trailing characters
autocmd BufWritePre,FileWritePre *.py mark x|exe "%s/[ ]*$//g"|'x

" CTRLP
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.pyc  " Windows
" Open Buffers list with ';'
nnoremap <C-;> :CtrlPBuffer<CR>
" Show files by default 
let g:ctrlp_cmd = 'CtrlP'
" Run CtrlP (files) with CTRL+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" if executable('ag')
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
" endif

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" Other
set runtimepath^=~/.vim/bundle/vim-surround
set runtimepath^=~/.vim/bundle/vim-repeat

" PLUG
call plug#begin('~/.vim/plugged')

" FZF 
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'

" lightline-vim
Plug 'itchyny/lightline.vim'

call plug#end()



" Lightline
let g:lightline = {
\ 'colorscheme': 'solarized',
\ 'active': {
\   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', ]]
\ },
\ 
\ }

set equalprg=autopep8\ -
