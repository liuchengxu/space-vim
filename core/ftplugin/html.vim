if exists('b:did_spacevim_html_ftplugin') || !spacevim#load('html')
  finish
endif
let b:did_spacevim_html_ftplugin = 1

setlocal tabstop=2 softtabstop=2 shiftwidth=2

let b:ale_linters = ['tidy']
