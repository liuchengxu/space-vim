if exists('b:did_spacevim_dot_ftplugin') || !spacevim#load('graphviz')
  finish
endif
let b:did_spacevim_dot_ftplugin = 1

" wmgraphviz.vim {
nnoremap <buffer> <LocalLeader>c :update<CR>:GraphvizCompile<CR><CR>
nnoremap <buffer> <LocalLeader>s :update<CR>:GraphvizShow<CR><CR>
" }
