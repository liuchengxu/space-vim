if g:spacevim.speed_up_via_timer
  MP 'plasticboy/vim-markdown',      { 'lazy': 1,
    \ 'hook_source': function('spacevim#autocmd#markdown#Init') }
else
  MP 'plasticboy/vim-markdown',      { 'on_ft': 'markdown',
    \ 'hook_source': function('spacevim#autocmd#markdown#Init') }
endif

MP 'mzlogin/vim-markdown-toc',     { 'on_cmd':
  \ ['GenTocGFM', 'GenTocRedcarpet', 'GenTocGitLab', 'UpdateToc', 'RemoveToc'],
  \ 'hook_source': function('spacevim#autocmd#markdown#Init') }
MP 'previm/previm', { 'on_ft': 'markdown', 'on_cmd': 'PrevimOpen',
  \ 'hook_source': function('spacevim#autocmd#markdown#Init') }
