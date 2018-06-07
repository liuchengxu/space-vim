if exists('b:did_spacevim_vim_ftplugin')
  finish
endif
let b:did_spacevim_vim_ftplugin = 1

setlocal tabstop=2 shiftwidth=2 softtabstop=2

let b:ale_linters = ['vint']

nnoremap <buffer> <LocalLeader>gh :<C-U>call spacevim#util#OpenPluginHomepage()<CR>
