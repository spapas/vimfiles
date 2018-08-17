source ~/vimfiles/vimrc_defaults

" Basic settings ---------------------- {{{
"
set nocompatible " Important
filetype plugin indent on " Enable ft

set hidden " For buffers, hide buffers without asking confirm for save
set laststatus=2 " Always display status bar 

set history=200 " keep 200 lines of command line history
set noruler     " Not needed (displays line/col but will use lightline instead)
set showcmd     " display incomplete commands
set wildmenu    " display completion matches in a status line

set ttimeout    " time out for key codes
set timeoutlen=500 " wait up to 500ms for mappings 
set ttimeoutlen=100 " wait up to 100ms after Esc for special key

set scrolloff=3     " scroll down before the last line

set display=truncate " Show @@@ in the last line if it is truncated.

if has('mouse')
  set mouse=a
endif

" }}}

" Mappings settings ---------------------- {{{

" Don't use Ex mode, use Q for formatting. Revert with :unmap Q
noremap Q gq  


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" }}}

" Gui settings ---------------------- {{{
if has('gui_running')
    " Remove toolbar and menu
    set go-=Tt
    set go-=m
    " Remove scrollbars
    set go-=rL
    " Display text tabs (instead of GUI ones)
    set go-=e
    " Do not use modal alert dialogs! (Prefer Vim style prompt.)
    " http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
    set guioptions+=c
    set guitablabel=%M\ %t
    " Please get the fonts from here for use in windows: https://github.com/spapas/my-nerd-fonts/
    " set guifont=Fira\ Mono:h11:cGREEK
    " or
    " or For Linux
    if has('win32')

        set guifont=SourceCodePro_NF:h14:cGREEK:qDRAFT
        " set guifont=Hack:h12:cGREEK
        " st guifont=Source\ Code\ Pro\ Medium:h12
        " set guifont=Hack:h11:cGREEK
    else
        set guifont=Fira\ Mono\ 12
    endif
    set lines=35 columns=140
endif

" }}}

" Other settings ----------------- {{{
packadd! matchit
if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif
" }}}


" Autocmd  ----------------- {{{

if has("autocmd")
  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

  augroup vimrcEx
  au!
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  augroup END
endif " has("autocmd")
" }}}


set colorcolumn=80,120

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

" Allow moving between lines with left/right arrow keys backspace and space
set whichwrap=b,s,<,>,[,]

" Don't redraw when exuting macros
set lazyredraw

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
" set selection=exclusive
" set virtualedit=onemore
"or
" make selecting easier for windows
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
" colorscheme onedark
let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'override' : {
  \       }
  \     }
  \   },
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
colorscheme PaperColor
set background=dark

" Use Unix as the standard file type
set ffs=unix,dos,mac
set encoding=utf8

" CTRLP

set wildignore+=*.bak
set wildignore+=*.exe
set wildignore+=*.pyc
set wildignore+=*.swp
set wildignore+=*.zip
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*,node_modules\*,tmp\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/node_modules/*,*/tmp/*
endif

" Open Buffers list with 'ctrl-j'
noremap <C-j> :CtrlPBuffer<CR>
" Show files by default
let g:ctrlp_cmd = 'CtrlP'
" Run CtrlP (files) with CTRL+P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if executable('ag')
  " Use Ag over Grep
  let g:ackprg = 'ag --vimgrep'
  nnoremap <leader>ag :Ack<SPACE>

  set grepprg=a\ --nogroup\ --nocolor\ --column
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

Plug 'michaeljsmith/vim-indent-object'

Plug 'w0rp/ale'
Plug 'maximbaz/lightline-ale'

Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

Plug 'mileszs/ack.vim'

call plug#end()


" Lightline
function! LightlineReadonly()
    return &readonly ? '' : ''
endfunction
" Careful here: I've modified the PaperColor scheme (and renamed it as
" PaperColorEx in order to display linting errors properly.
let g:lightline = {
\ 'colorscheme': 'PaperColorEx',
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' },
\ 'component': {
\   'lineinfo': ' %3l:%-2v',
\   'tagbar_current': '%{tagbar#currenttag("%s", "", "f")}'
\ },
\ 'component_function': {
\   'readonly': 'LightlineReadonly',
\   'ctrlpmark': 'CtrlPMark',
\ },
\ }
let g:lightline.inactive = {
\ 'left': [ [ 'filename' ] ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'percent' ] ] }
let g:lightline.tabline = {
\ 'left': [ [ 'tabs' ] ],
\ 'right': [ [ 'close' ] ] }
let g:lightline.tab = {
\ 'active': [ 'tabnum', 'filename', 'modified' ],
\ 'inactive': [ 'tabnum', 'filename', 'modified' ] }

" Integrate ale with lightline
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
\   'gutentags': 'MyGutentagsStatus',
      \ }

function! MyGutentagsStatus()
    return gutentags#statusline("[", "]", "")
endfunction


let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'ok',
      \ }

" Don't show INSERT (mode) - it is displayed on lightline
set noshowmode

let g:lightline.active = {
\   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'gutentags',], ['ctrlpmark', 'tagbar_current',  ], ],
\   'right': [[ 'linter_checking',  'linter_errors', 'linter_warnings' , 'linter_ok' ], ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype', ]]
\ }

" Use autopep8 for auto - identing
set equalprg=autopep8\ -

" Easier buffer switching (shift-tab to switch to last used buffer)
nmap <S-Tab> :b#<cr>
" Also useful
" imap <S-Tab> <ESC>:b#<cr>
" cmap <S-Tab> <ESC>:b#<cr>

" Easier buffer movements
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Remap leader to space
let mapleader = "\<Space>"
" Remove buffer
noremap <Leader>rb :bd<CR>
" Select text that was just pasted (ie use p<leader>ps)
nnoremap <leader>ps `[v`]
" Toggle spelling
nnoremap <leader>sp :set spell!<CR> 

" Spell english and greek
set spelllang=en,el

" Reverse lines without changing unnamed register
nnoremap <Leader>d "udd"up
" Clear search nightlight
nnoremap <Leader>cs :noh<CR>
" Remove whitespace - two methods (leader w or leader W)
nnoremap <Leader>W :mark x<CR>:exe "%s/[ ]*$//g"<CR>'x
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>
" Toggle special character display
nnoremap <leader>li :set list!<CR>
" Add line w/o insert
nnoremap <leader>n o<Esc>
nnoremap <leader>N O<Esc>

" Better paste
nnoremap <leader>pp "_diwP
" Open new tab
nnoremap <Leader>tn :tabnew<CR>
" Close (remove) tab
nnoremap <Leader>tr :tabclose<CR>
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>vc :e <C-R>=fnamemodify($MYVIMRC, ':p:h').'/vim-cmds.txt'<CR><CR>
" or
" nmap <silent> <leader>vc :e <C-R>=fnamemodify($MYVIMRC,  ':p:h')<CR>\vim-cmds.txt<CR>


" Run make
nnoremap <leader>mk :make<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprev<CR>
" UndoTreeToggle
nnoremap <leader>ut :UndotreeToggle<CR>
"Toggle paste mode - disables autoident  when pasting multiple lines
set pastetoggle=<F2>
" Do a json pretty print to the file
nmap <silent> <leader>jl :%!py -2 -m json.tool<CR>

" Tagbar Toggle
nnoremap <silent> <F9> :TagbarToggle<CR>
" Sort by position in the file
let g:tagbar_sort = 0
let g:tagbar_iconchars = ['▶', '▼']

" Display special characters
set list
if version >= 800
    set listchars=tab:→\ ,eol:$,space:\ ,trail:.
else
    set listchars=eol:$,trail:.
endif

" Autosave on lost focus
" au FocusLost * :wa

" Disable arrow keys
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

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


fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    " Delete trailing characters
    " autocmd BufWritePre,FileWritePre *.py,*.js,*.ts,*.json,*.txt mark x|exe "%s/[ ]*$//g"|'x
    autocmd BufWritePre *.py,*.js,*.ts,*.json,*.txt,*.sh :call CleanExtraSpaces()

    " Some examples for future reference
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    "
endif


let g:surround_37 = "{% \r %}"
let g:surround_36 = "{{ \r }}"

" Faster update for gitgutter
set updatetime=1000

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
nmap <silent> <leader>at :ALEToggle<cr>
nmap <silent> <leader>af :ALEFix<cr>

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter% %code%] %s [%severity%]'


" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z


" Don't save .netrwhist
:let g:netrw_dirhistmax = 0

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction


augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END




