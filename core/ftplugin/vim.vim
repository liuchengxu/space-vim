if exists('b:did_spacevim_vim_ftplugin')
  finish
endif
let b:did_spacevim_vim_ftplugin = 1

setlocal tabstop=2 shiftwidth=2 softtabstop=2

let b:ale_linters = ['vint']

nnoremap <buffer> <LocalLeader>gh :<C-U>call spacevim#util#OpenPluginHomepage()<CR>

if has_key(g:plugs, 'coc-neco') && !exists('g:did_coc_neco_loaded')
  call plug#load('neco-vim', 'coc-neco')
endif
