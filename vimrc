" vim: set foldmethod=marker foldmarker={{{,}}} nowrap:

" Basic settings ---------------------- {{{
"
set nocompatible " Important
filetype plugin indent on " Enable ft
syntax on
set hidden " For buffers, hide buffers without asking confirm for save
set laststatus=2 " Always display status bar

set fileformats=unix,dos,mac " Use Unix as the standard file type
set history=200 " keep 200 lines of command line history
set showcmd     " display incomplete commands
set wildmenu    " display completion matches in a status line

set autoindent
set copyindent
set encoding=utf-8

set expandtab " Change tab to spaces
set softtabstop=4 " Remove 4 spaces when pressing backspace
set shiftwidth=4 " Number of spaces to use for each step of (auto)indent.
set smarttab " Improve tab behavior
set tabstop=4 " Number of spaces that a <Tab> in the file counts for.

set nowrap " Don't wrap
set number " Display line numbers

set scroll=5 " Number of lines to scroll with c-u / c-d

if has('mouse')
  set mouse=a
endif

set nostartofline " Do not go to start of line when changing buffers (remember position)

"Use this to make clipboard work as normal with vim - or else use the *
"register to refer to the windows clipboard, for example
" "*yy
" other registers can be used f.e "add "ayy "ap etc
" Unix has an unnamed (*) and an unnamedplus (+) clipboard
set clipboard^=unnamed,unnamedplus


" }}}

" Display settings ---------------------- {{{
try
    set display=truncate " Show @@@ in the last line if it is truncated.
catch
endtry
set scrolloff=3     " scroll down before the last line
set noruler     " Not needed (displays line/col but will use lightline instead)
set colorcolumn=80,120 " Add vertical bars
set showmatch " When a bracket is inserted, briefly jump to the matching one.
set lazyredraw " Don't redraw when exuting macros
set noshowmode " Don't show INSERT (mode) - it is displayed on lightline
set fillchars=stlnc:-,vert:\|,fold:-
set list " Display special characters
set showbreak=… " Display ellipsis on long lines when wrap is enabled
if version >= 800
    set listchars=tab:→\ ,eol:$,space:\ ,trail:.
else
    set listchars=eol:$,trail:.
endif

" }}}

" Basic Mappings settings ---------------------- {{{

" Remap leader to space
let mapleader = "\<Space>"
" and local leader to \
let maplocalleader = "\\"

" Don't use Ex mode, use Q for formatting. Revert with :unmap Q
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Remove buffer
noremap <Leader>rb :bd<CR>

" Very useful for greek to work in normal mode
set langmap=ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,σs,τt,θu,ωv,ςw,χx,υy,ζz

" }}}

" Gui settings ---------------------- {{{
if has('gui_running')
    " Remove toolbar and menu
    set guioptions-=T
    set guioptions-=t
    set guioptions-=m
    " Remove scrollbars
    set guioptions-=rL
    set guioptions-=L
    " Display text tabs (instead of GUI ones)
    set guioptions-=e
    " Do not use modal alert dialogs! (Prefer Vim style prompt.)
    " http://stackoverflow.com/questions/4193654/using-vim-warning-style-in-gvim
    set guioptions+=c
    set guitablabel=%M\ %t
    " Please get the fonts from here for use in windows: https://github.com/spapas/my-nerd-fonts/
    if has("win16") || has("win32")

        set guifont=SourceCodePro_NF:h14:cGREEK:qDRAFT
        " set guifont=Hack:h12:cGREEK
        " set guifont=Source\ Code\ Pro\ Medium:h12
        " set guifont=Hack:h11:cGREEK
        " set guifont=Fira\ Mono:h11:cGREEK
    else
        set guifont=Source\ Code\ Pro\ 14
    endif
    set lines=40 columns=140
endif

" }}}

" Other settings ----------------- {{{

set spelllang=en,el " Spell english and greek

if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward compatible).
  set nolangremap
endif

set backspace=indent,eol,start " allow delete over all things

let g:netrw_dirhistmax = 0 " Don't save .netrwhist

set splitbelow " Open new splits below
set splitright " Open new splits to the right
set whichwrap=b,s,<,>,[,] " Allow moving between lines with left/right arrow keys backspace and space

set timeout   " add time out for mappings; useful with vim-which-key
set ttimeout    " time out for key codes
set timeoutlen=500 " wait up to 500ms for mappings
set ttimeoutlen=10 " wait up to 10ms after Esc for special key

" http://vimdoc.sourceforge.net/htmldoc/options.html#'foldcolumn'
" play with zM zm zr zR and more http://vimdoc.sourceforge.net/htmldoc/usr_28.html
set foldcolumn=2
set foldmethod=indent
set foldlevelstart=99

" Use autopep8 for auto - identing
" set equalprg=autopep8\ -
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

  augroup extraStuff
    au!
    " Delete trailing characters
    " autocmd BufWritePre,FileWritePre *.py,*.js,*.ts,*.json,*.txt mark x|exe "%s/[ ]*$//g"|'x
    autocmd BufWritePre *.py,*.js,*.ts,*.json,*.txt,*.sh,*.html :call CleanExtraSpaces()

    " Some examples for future reference
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml

  augroup END
endif


" }}}

" Search etc ---------------------- {{{

" Highlight search results
set hlsearch
" Highlight search results as typed
set incsearch
" If searching with all lower will search with case insensitive. If there are
" caps it will search with sensitive case
set ignorecase
set smartcase

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
" }}}

" File management ---------------------- {{{
"
set autoread " Autoread a file if has been changed outside of vim but not inside of vim

" Don't save swap files to the same directory
if has("win16") || has("win32")
    " set directory^=C:\Users\serafeim\AppData\Local\Temp\\
    set directory-=.
else
    set directory-=.
endif

set nobackup
set writebackup

" Vim keeps a hidden undo file for persistent undos(extension .un~). I don't
" like this because it adds a lot of files.  If you think you need it you can
" add an undodir directory that will save all undo files in a directory. Also
" see this answer:
" https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
set undofile
if has("win16") || has("win32")
    if !isdirectory($HOME."/vimfiles/undodir")
        call mkdir($HOME."/vimfiles/undodir", "", 0700)
    endif
    set undodir=$HOME/vimfiles/undodir
else 
    if !isdirectory($HOME."/.vim/undodir")
        call mkdir($HOME."/.vim/undodir", "", 0700)
    endif
    set undodir=$HOME/.vim/undodir
endif
" }}}

" Colorscheme settings {{{
"
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
" }}}

" Core Mappings ------------------ {{{

" Easier buffer switching (shift-tab to switch to last used buffer)
" nmap <S-Tab> :b#<cr>
" TODO: This seems better... let's test it for a little while though
nmap <S-Tab> <C-^>
" Also useful
" imap <S-Tab> <ESC>:b#<cr>
" cmap <S-Tab> <ESC>:b#<cr>

" Toggle spelling
nnoremap <leader>sp :set spell!<CR>
nnoremap <leader>se i <Esc>wa <Esc>b
" Reverse lines without changing unnamed register
nnoremap <Leader>d "udd"up
" Clear search nightlight
nnoremap <Leader>cs :noh<CR>
" Remove whitespace - two methods (leader w or leader W)
nnoremap <Leader>WS :mark x<CR>:exe "%s/[ ]*$//g"<CR>'x
" nnoremap <leader>ws :%s/\s\+$//<cr>:let @/=''<CR>
" Toggle special character display
nnoremap <leader>li :set list!<CR>
" Add line w/o insert
nnoremap <leader>n o<Esc>
nnoremap <leader>N O<Esc>

nnoremap <leader>yf :let @+ = expand("%")<cr><Esc>
nnoremap <leader>yp :let @+ = expand("%:p")<cr><Esc>

" Toggle text wrap
nnoremap <leader>wr :set wrap!<cr>
" Select text that was just pasted (ie use p<leader>ps)
nnoremap <leader>ps `[v`]
" Better paste
nnoremap <leader>pp "_diwP"_yiw
" Open new tab
nnoremap <Leader>tn :tabnew<CR>
" Close (remove) tab
nnoremap <Leader>tr :tabclose<CR>
" Quickly edit/reload the vimrc file
noremap <silent> <leader>ve :e $MYVIMRC<CR>
noremap <silent> <leader>vs :so $MYVIMRC<CR>
noremap <silent> <leader>vc :e <C-R>=fnamemodify($MYVIMRC, ':p:h').'/vim-cmds.txt'<CR><CR>
" or
" nmap <silent> <leader>vc :e <C-R>=fnamemodify($MYVIMRC,  ':p:h')<CR>\vim-cmds.txt<CR>
"
"Toggle paste mode - disables auto indent  when pasting multiple lines
set pastetoggle=<F2>
" Do a json pretty print to the file
nmap <silent> <leader>jl :%!py -2 -m json.tool<CR>

" The next mappings and function will make * and # search for the *selection*
" instead of the word under the cursor on visual mode
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Move to start/end of line in insert and command mode
cnoremap <C-a>  <Home>
cnoremap <C-e>  <End>
inoremap <C-a>  <Home>
inoremap <C-e>  <End>

" Disable arrow keys
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" }}}

" Plugins --------------------- {{{
" Run :PlugInstall to install these plugins
if has("win16") || has("win32")
    call plug#begin('~/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim' " lightline-vim
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround' " https://github.com/tpope/vim-surround
Plug 'tpope/vim-repeat' " https://github.com/tpope/vim-repeat
Plug 'justinmk/vim-sneak' " https://github.com/justinmk/vim-sneak
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}
" Do a
" let g:codestats_api_key = 'YOUR_KEY_HERE'
" in your local settings
if has("python") || has("python3")
    Plug 'https://gitlab.com/code-stats/code-stats-vim.git'
endif


call plug#end()
" }}}

" Lightline -------------------- {{{
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


let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'ok',
      \ }



let g:lightline.active = {
\   'left': [['mode', 'paste'], ['readonly', 'filename', 'modified', 'gutentags',], ['ctrlpmark', 'tagbar_current',  ], ],
\   'right': [[ 'linter_checking',  'linter_errors', 'linter_warnings' , 'linter_ok' ], ['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype', ]]
\ }

" }}}

" CtrlP configuration ------------------ {{{

" Open Buffers list with 'ctrl-j'
noremap <C-j> :CtrlPBuffer<CR>
let g:ctrlp_cmd = 'CtrlP' " Show files by default
let g:ctrlp_map = '<c-p>' " Run CtrlP (files) with CTRL+P
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
  " Or can use ripgrep
  let g:ctrlp_user_command = 'rg --files %s'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" Mainly useful for lightline integration
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }
" }}}

" Other Plugin configuration ------------------ {{{

" Make surround work with django templates
let g:surround_37 = "{% \r %}"
let g:surround_36 = "{{ \r }}"

" }}}

" Plugin Mappings ------------------ {{{
" }}}

" Useful functions --------------------------- {{{

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

" }}}

" Useful plugin related functions ------------------------ {{{

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

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

" }}}

" Plugin autocmd  ----------------- {{{

if has("autocmd")
endif " has("autocmd")
" }}}

" Abbreviations  ----------------- {{{

" Replace only in insert mode
iabbr teh the

" }}}

" Include other files  ----------------- {{{
try
    execute 'source '.fnamemodify($MYVIMRC, ':p:h').'/scripts/*'
    execute 'source '.fnamemodify($MYVIMRC, ':p:h').'/local.vim'
catch
endtry
" }}}

