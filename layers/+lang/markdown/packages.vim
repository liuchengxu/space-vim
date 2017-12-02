if g:spacevim_timer
  MP 'plasticboy/vim-markdown',      { 'on': [] }
  MP 'mzlogin/vim-markdown-toc',     { 'on': [] }
  MP 'iamcco/markdown-preview.vim',  { 'on': [] }
else
  MP 'plasticboy/vim-markdown',      { 'for': 'markdown' }
  MP 'mzlogin/vim-markdown-toc',     { 'for': 'markdown' }
  MP 'iamcco/markdown-preview.vim',  { 'on': 'MarkdownPreview' }
endif
