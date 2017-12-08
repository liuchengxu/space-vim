if g:spacevim_timer
  MP 'plasticboy/vim-markdown',      { 'on': [] }
else
  MP 'plasticboy/vim-markdown',      { 'for': 'markdown' }
endif

MP 'mzlogin/vim-markdown-toc',     { 'on': ['GenTocGFM', 'GenTocRedcarpet', 'GenTocGitLab'] }
MP 'iamcco/markdown-preview.vim',  { 'on': ['MarkdownPreview'] }
