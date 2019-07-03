if g:spacevim.speed_up_via_timer
  MP 'plasticboy/vim-markdown',      { 'on': [] }
else
  MP 'plasticboy/vim-markdown',      { 'for': 'markdown' }
endif

MP 'mzlogin/vim-markdown-toc',     { 'on': ['GenTocGFM', 'GenTocRedcarpet', 'GenTocGitLab', 'UpdateToc', 'RemoveToc'] }
MP 'previm/previm', { 'for': 'markdown', 'on': 'PrevimOpen' }
autocmd! User vim-markdown,vim-markdown-toc,previm call spacevim#autocmd#markdown#Init()
