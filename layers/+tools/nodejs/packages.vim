execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

" v >= 16.10 is required for corepack
" v < 17 required for tree-sitter
"  https://github.com/tree-sitter/node-tree-sitter/issues/102
if spacevim#vim#plug#LocateDependency('node')[0] ==# 'none'
  MP 'nodejs/node', { 'merged': v:false, 'rtp': '',
    \ 'rev': 'v16.16.0',
    \ 'hook_post_update': function('spacevim#vim#plug#Build', ['node']) }
endif
