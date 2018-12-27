if exists('b:did_spacevim_dot_ftplugin') || !spacevim#load('graphviz')
  finish
endif
let b:did_spacevim_dot_ftplugin = 1

" graphviz.vim {
nnoremap <silent><buffer> <LocalLeader>s :update<CR>:Graphviz<CR>
nnoremap <silent><buffer> <LocalLeader>c :update<CR>:GraphvizCompile<CR>
" }
