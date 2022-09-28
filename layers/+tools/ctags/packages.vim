MP 'ludovicchabant/vim-gutentags',  { 'on_ft': ['c', 'cpp', 'cs'],
  \ 'hook_source': function('spacevim#autocmd#gutentags#Init') }

execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

if spacevim#vim#plug#LocateDependency('ctags')[0] ==# 'none'
  " Note: 'depends' loading order not guaranteed for non-lazy plugins
  MP 'universal-ctags/ctags', { 'merged': v:false, 'rtp': '',
    \ 'depends': 'yaml/libyaml', 'lazy': v:true }
  MP 'yaml/libyaml', { 'merged': v:false, 'rtp': '',
    \ 'hook_post_update': function('spacevim#vim#plug#Build', ['libyaml']) }
endif
