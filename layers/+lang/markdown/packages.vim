if g:spacevim.timer
  MP 'plasticboy/vim-markdown',      { 'on': [] }
else
  MP 'plasticboy/vim-markdown',      { 'for': 'markdown' }
endif

MP 'mzlogin/vim-markdown-toc',     { 'on': ['GenTocGFM', 'GenTocRedcarpet', 'GenTocGitLab', 'UpdateToc', 'RemoveToc'] }
MP 'iamcco/markdown-preview.vim',  { 'on': ['MarkdownPreview'] }
autocmd! User vim-markdown,vim-markdown-toc,markdown-preview.vim call spacevim#autocmd#markdown#Init()
