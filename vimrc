set nocompatible
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

" For buffers, hide buffers without asking confirm for save
set hidden

" Careful - for lightline to appear
set laststatus=2

if has('gui_running')
    " Remove toolbar and menu
    set go-=T
    set go-=m
    " Remove scrollbars
    set go-=rL
    " Display text tabs (instead of GUI ones)
    set go-=e
    " Do not use modal alert dialogs! (Prefer Vim style prompt.)
    " http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
    set guioptions+=c
    " set guifont=Fira\ Mono:h11:cGREEK
    " or
    " or For Linux
    if has('win32')
        " set guifont=Fira\ Mono:h11:cGREEK
        set guifont=Source\ Code\ Pro\ Medium:h11
        " set guifont=Hack:h11:cGREEK
    else
        set guifont=Fira\ Mono\ 11
    endif
    set lines=50 columns=200
endif

set colorcolumn=80,120,160

" Save swap files to this directory
set directory^=~\.vim\tmp\\

"Use this to make clipboard work as normal with vim - or else use the *
"register to refer to the windows clipboard, for example
" "*yy
" other registers can be used f.e "add "ayy "ap etc
" Unix has an unnamed (*) and an unnamedplus (+) clipboard
set clipboard^=unnamed,unnamedplus

set autoindent
set copyindent
set enc=utf-8
" Change tab to spaces
set expandtab
" Remove 4 spaces when pressing backspace
set softtabstop=4
" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4
" Improve tab behavior
set smarttab

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

set nowrap
set number

" When a bracket is inserted, briefly jump to the matching one.
set showmatch

" Highlight search results
set hlsearch
" Highlight search results as typed
set incsearch

" If searching with all lower will search with case insensitive. I there are
" caps it will search with sensitive case
set ignorecase
set smartcase

" Do not go to start of line when changing buffers (remember position)
set nostartofline

" Autoread a file if has been changed outside of vim but not inside of vim
set autoread

" http://vimdoc.sourceforge.net/htmldoc/options.html#'foldcolumn'
" play with zM zm zr zR and more http://vimdoc.sourceforge.net/htmldoc/usr_28.html
set foldcolumn=2
set foldmethod=indent
set foldlevelstart=99

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
 
set wildignore+=*\\tmp\\*  " Windows
set wildignore+=*.bak
set wildignore+=*.exe
set wildignore+=*.pyc 
set wildignore+=*.swp
set wildignore+=*.zip
set wildignore+=*/node_modules/*
set wildignore+=*\\node_modules\\*
set wildignore+=node_modules\\*
set wildignore+=node_modules
" Open Buffers list with 'ctrl-j'
noremap <C-j> :CtrlPBuffer<CR>
" Show files by default
let g:ctrlp_cmd = 'CtrlP'
" Run CtrlP (files) with CTRL+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m
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

Plug 'ctrlpvim/ctrlp.vim'
" lightline-vim
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
" Undotree (https://github.com/mbbill/undotree)
Plug 'mbbill/undotree'
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'
" https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'
" https://github.com/justinmk/vim-sneak
Plug 'justinmk/vim-sneak'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
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
" Remove buffer
noremap <Leader>rb :bd<CR>
" Select text that was just pasted (ie use pgp)
nnoremap gp `[v`]
" Remap leader to space
let mapleader = "\<Space>"
" Sample mapping
nnoremap <Leader>a :echo "Hey there space"<CR>
" Reverse lines without changing unanmed register
nnoremap <Leader>d "udd"up
" Clear search hightlight
"
nnoremap <Leader>c :noh<CR>
" Remove whitespace - two methods (leader w or leader W)
nnoremap <Leader>W :mark x<CR>:exe "%s/[ ]*$//g"<CR>'x
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" Toggle special character display
nnoremap <leader>l :set list!<CR>
" Add line w/o insert
nnoremap <leader>n o<Esc>
nnoremap <leader>N O<Esc>
" Better paste
nnoremap <leader>p "_diwP
" Open new tab
nnoremap <Leader>t :tabnew<CR>
" Close (remove) tab
nnoremap <Leader>rt :tabclose<CR>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Run make
nnoremap <leader>mk :make<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
" UndoTreeToggle
nnoremap <leader>u :UndotreeToggle<CR>
"Toggle paste mode - disables autoident  when pasting multiple lines
set pastetoggle=<F2>

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

" The next mappings and function will make * and # search for the *selection*
" instead of the word under the cursor on visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

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
    autocmd FileType python setlocal makeprg=pep8\ %

endif



"let g:EasyMotion_do_mapping = 0 " Disable default mappings
"" Jump to anywhere you want with minimal keystrokes, with just one key binding.
"" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
"" or
"" `s{char}{char}{label}`
"" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)
"
"" Turn on case insensitive feature
"let g:EasyMotion_smartcase = 1
"
"" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
