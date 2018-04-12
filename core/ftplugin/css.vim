if exists('b:did_spacevim_css_ftplugin') || !spacevim#load('html')
  finish
endif
let b:did_spacevim_css_ftplugin = 1

setlocal tabstop=2 softtabstop=2 shiftwidth=2

" https://github.com/hail2u/vim-css3-syntax#notes
setlocal iskeyword+=-
