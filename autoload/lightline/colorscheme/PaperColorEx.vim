" =============================================================================
" Filename: autoload/lightline/colorscheme/PaperColorEx.vim
" Author: TKNGUE
" License: MIT License
" Last Change: 2017/11/25 11:13:35.
" =============================================================================

if lightline#colorscheme#background() ==# 'light'
  let g:lightline#colorscheme#PaperColorEx#palette = g:lightline#colorscheme#PaperColor_lightEx#palette
else
  let g:lightline#colorscheme#PaperColorEx#palette = g:lightline#colorscheme#PaperColor_darkEx#palette
endif
