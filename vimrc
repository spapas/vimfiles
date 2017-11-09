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
    if has('win32')
        set guifont=Fira\ Mono:h11:cGREEK
        set guifont=Source\ Code\ Pro\ Medium:h12
    else
        set guifont=Fira\ Mono\ 11
    endif
    set lines=40 columns=140
endif

set colorcolumn=80,120

" Save swap files to this directory
set directory^=~\.vim\tmp\\

"Use this to make clipboard work as normal with vim - or else use the *
"register to refer to the windows clipboard, for example
" "*yy
" other registers can be used f.e "add "ayy "ap etc
set clipboard=unnamed

set autoindent
set enc=utf-8
" Change tab to spaces
set expandtab
" Remove 4 spaces when pressing backspace
set softtabstop=4
" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

set nowrap
set number

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Highlight search results
set hlsearch

" If searching with all lower will search with case insensitive. I there are
" caps it will search with sensitive case
set ignorecase
set smartcase


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


" CTRLP
" Checkout this answer https://stackoverflow.com/a/28796041/119071 for including submodules
" TL;DR: Run git clone --recursive to clone the project or 
" git submodule update --init bundle/ctrlp.vim on an already initialized project 
 
set runtimepath^=~/vimfiles/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
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
" Run :PlugInstall to install these plugins
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

" Easier buffer switching (shift-tab to switch to last used buffer)
nmap <S-Tab> :b#<cr>
" Easier buffer movements

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Remap leader to space
let mapleader = "\<Space>"
" Sample mapping
nnoremap <Leader>a :echo "Hey there space"<CR>
" Reverse lines without changing unanmed register
nnoremap <Leader>d "udd"up
" Clear search hightlight
nnoremap <Leader>c :noh<CR>
" Remove whitespace - two methods (leader w or leader W)
nnoremap <Leader>W :mark x<CR>:exe "%s/[ ]*$//g"<CR>'x
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" Toggle special character display
nnoremap <leader>l :set list!<CR>
" Add line w/o insert
nnoremap <leader>n o<Esc>
nnoremap <leader>N O<Esc>
" Display special characters
set list
if version >= 800
    set listchars=tab:▸\ ,eol:$,space:\ ,trail:.
else
    set listchars=eol:$,trail:.
endif

" Autosave on lost focus
" au FocusLost * :wa

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

if has("autocmd")
    " Make sure filetype is enabled
    filetype on

    " Delete trailing characters
    autocmd BufWritePre,FileWritePre *.py mark x|exe "%s/[ ]*$//g"|'x

    " Some examples for future reference
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

endif
