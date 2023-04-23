execute 'source '.fnamemodify(expand('<sfile>'), ':h').'/native-dependency.vim'

if spacevim#vim#plug#LocateDependency('rust')[0] ==# 'none'
  MP 'rust-lang/rust', { 'merged': v:false, 'rtp': '',
    \ 'hook_post_update': function('spacevim#vim#plug#Build', ['rust']) }
endif
